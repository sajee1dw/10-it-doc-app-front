import 'package:bookme/Widgets/top_container.dart';
import 'package:bookme/models/cacheData.dart';
import 'package:bookme/screens/aboutUs.dart';
import 'package:bookme/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import "package:bookme/models/company.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bookme/providers/timeSlot.dart';
import 'package:bookme/providers/userData.dart';
import 'package:bookme/screens/timeslots.dart';
import 'package:bookme/screens/user_booked.dart';
import 'package:bookme/providers/doctorinfo.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'dart:convert';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:simple_vcard_parser/simple_vcard_parser.dart';

//import 'package:url_launcher/url_launcher.dart';// URL launcher <-

class SelectionPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

String qrData = "No data found!";
var data;
bool hasdata = false;
bool isEnabled = true;

class _ListPageState extends State<SelectionPage> {
  String cacheDocArea, cacheDocSuburb, cacheBValue;
  List<Company> lessons = <Company>[];
  String _identifier = 'Unknown';
  @override
  void initState() {
    getCompanies().then((List<Company> val) {
      lessons = val;
      print('company id');
      print(val[0].id);
      print(lessons);
      setState(() {
        isEnabled = true;
      });
    }).catchError((error) {
      print(error);
    });

    super.initState();

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    if (!mounted) return;

    setState(() {
      _identifier = deviceId;
      print("******deviceId->$_identifier");
    });
  }

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TimeSlotProvider timeSlotsProvider =
        Provider.of<TimeSlotProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.height;

    ListTile makeListTile(Company company) => ListTile(
      
          contentPadding:
               EdgeInsets.symmetric(horizontal: width*0.0100, vertical: height*0.0100),
          leading: Container(
            child: CircleAvatar(
              radius: 40,
              child: CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(company.logo),
              ),
            ),
          ),
          title: Text(
            company.name,
            style: TextStyle(
              fontSize: size * 0.0300,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(
                      company.shortAddress,
                      style: TextStyle(
                          fontSize: size * 0.0160,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45),
                    ),
                  ))
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 40.0),
          onTap: () async {
            if (isEnabled == true) {
              setState(() {
                isEnabled = false;
              });
              print(isEnabled);
              final InfolistProvider infolistProvider =
                  Provider.of<InfolistProvider>(context, listen: false);

              final Map<String, dynamic> _infoData = {
                'userId': '${company.id}',
              };
              final Map<String, dynamic> successInfo =
                  await infolistProvider.getInfo(_infoData);
              print(infolistProvider.currentInfo.appointmentcalendar);
              print(infolistProvider.currentInfo.bookingcalendar);
              if (successInfo['success']) {
                timeSlotsProvider.getTimeSlots({
                  'appointmentcalendar':
                      infolistProvider.currentInfo.appointmentcalendar,
                  'bookingcalendar':
                      infolistProvider.currentInfo.bookingcalendar
                });

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Timeslots()));
                setState(() {
                  isEnabled = true;
                });
              } else {
                print("something went wrong");
              }
            }
          },
        );

    Card makeCard(Company company) => Card(
          elevation: 10.0,
          
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            child: makeListTile(company),
            // height: 80.0,  //card height change
            // width:20.0
          ),
        );
    Widget companyCard() {
      return Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: lessons != null ? lessons.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(lessons[index]);
          },
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      );
    }

    Widget bottomNavigationBar() {
      return Container(
        child: Container(
          height: height * 0.080,
          width: width,
          child: Row(
            children: <Widget>[
              SizedBox(width: 25.0),
              IconButton(
                color: LightColors.kDarkBlue,
                icon: Icon(
                  Icons.info_outline,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()));
                },
              ),
              Spacer(),
              IconButton(
                color: LightColors.kDarkBlue,
                icon: Icon(
                  Icons.book_outlined,
                  size: 35,
                ),
                onPressed: () async {
                  if (isEnabled == true) {
                    setState(() {
                      isEnabled = false;
                    });
                    final UserDataProvider userDataProvider =
                        Provider.of<UserDataProvider>(context, listen: false);

                    final Map<String, dynamic> _userData = {
                      'uniqueIdentifier': _identifier,
                    };
                    _addData();
                    final Map<String, dynamic> successInfo =
                        await userDataProvider.getUserData(_userData);

                    if (successInfo['success']) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserBooking()));
                      setState(() {
                        isEnabled = true;
                      });
                    } else {
                      print("something went wrong");
                    }
                  }
                },
              ),
              SizedBox(width: 20.0),
            ],
          ),
        ),
      );
    }

    Widget alertMassage() {
      VCard vc = VCard(qrData);
      var companyWid = vc.organisation;
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: hasdata
            ? () async {
                if (isEnabled == true) {
                  setState(() {
                    isEnabled = false;
                  });
                  final InfolistProvider infolistProvider =
                      Provider.of<InfolistProvider>(context, listen: false);
                  var companyID =
                      companyWid.split('-')[1]; //10IT-ZAfxyr2CwLa5VxL0EpmF
                  print(companyWid);
                  print(vc.name);

                  final Map<String, dynamic> _infoData = {'userId': companyID};

                  final Map<String, dynamic> successInfo =
                      await infolistProvider.getInfo(_infoData);
                  if (successInfo['success']) {
                    print(infolistProvider.currentInfo.appointmentcalendar);
                    print(infolistProvider.currentInfo.bookingcalendar);
                    timeSlotsProvider.getTimeSlots({
                      'appointmentcalendar':
                          infolistProvider.currentInfo.appointmentcalendar,
                      'bookingcalendar':
                          infolistProvider.currentInfo.bookingcalendar
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectionPage()));
                    setState(() {
                      isEnabled = true;
                    });
                  } else {
                    print("something went wrong");
                  }
                }
              }
            : null,
      );
      Widget canclebButton = FlatButton(
          child: Text("CANCLE"),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SelectionPage()));
          });
      var name = companyWid.split('-')[0];
      AlertDialog alert = AlertDialog(
        title: Text("${(name)}"),
        content: Text(
          "Add ${(name)} to the Booking List.. ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          canclebButton,
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: height * 0.3400,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 7.0, 3, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/logo-small.png',
                            height: height * 0.1,
                            width: 85,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Book Me.LK',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: LightColors.kDarkBlue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Booking app',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[],
                          ),
                          SizedBox(height: height * 0.0350),
                          companyCard()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightColors.kGreen,
        child: Icon(
          Icons.add,
          size: 45,
        ),
        onPressed: () async {
          var options = ScanOptions();
          var data = await BarcodeScanner.scan(options: options);
          setState(() {
            qrData = data.rawContent;
            hasdata = true;
          });
          print(qrData);
          print(qrData.isNotEmpty);
          if (qrData.isNotEmpty == true) {
            alertMassage();
          }
        },
      ),
    );
  }

  _addData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('identifier', _identifier);
    print(_identifier);
  }

  Future<List<Company>> getCompanies() async {
    var gatCompaniesFromCache = await getData();
    print(gatCompaniesFromCache);
    print("****");
    List<Company> list = <Company>[];
    gatCompaniesFromCache.forEach((element) {
      list.add(new Company(
          name: element['name'],
          shortAddress: element['shortAddress'],
          id: element['id'], //BvarFwPaBYtAuZTnkGMN,//3k0n6tMxJf6Rw8izDiZi
          logo: element['logo']));
    });
    print(list);
    return list;
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map> getObjectList(String key) {
      if (prefs == null) return null;
      List<String> dataList = prefs.getStringList(key);
      return dataList?.map((value) {
        Map _dataMap = json.decode(value);
        return _dataMap;
      })?.toList();
    }

    List<Map> getObjList<T>(String key, T f(Map v),
        {List<T> defValue = const []}) {
      if (prefs == null) return null;
      List<Map> dataList = getObjectList(key);
      List<Map> list = dataList;
      return list ?? defValue;
    }

    var cacheData =
        getObjList<CustomModel>("data", (v) => CustomModel.fromJson(v));
    return cacheData;
  }
}
