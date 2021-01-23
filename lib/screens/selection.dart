import 'package:doc/Widgets/top_container.dart';
import 'package:doc/models/cacheData.dart';
import 'package:doc/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import "package:doc/models/company.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doc/providers/timeSlot.dart';
import 'package:doc/providers/userData.dart';
import 'package:doc/screens/timeslots.dart';
import 'package:doc/screens/user_booked.dart';
import 'package:doc/providers/doctorinfo.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platform_device_id/platform_device_id.dart';
//import 'package:doc/widgets/top_container.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_vcard_parser/simple_vcard_parser.dart';

class SelectionPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

String qrData = "No data found!";
var data;
bool hasdata = false;

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
      // setState(() async{
      // lessons = await getCompanies();
      // });
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

    ListTile makeListTile(Company company) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            child: CircleAvatar(
              radius: 40,
              // backgroundColor: Color(0xffFDCF09),
              child: CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(company.logo),
              ),
            ),
          ),
          title: Text(
            company.name,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(
                      company.address,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45),
                    ),
                  ))
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 40.0),
          onTap: () async {
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
                'bookingcalendar': infolistProvider.currentInfo.bookingcalendar
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Timeslots()));
            } else {
              print("something went wrong");
            }
          },
        );

    Card makeCard(Company company) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(company),
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
        // elevation: 0,
        child: Container(
          height: 50,
          width: width,
          child: Row(
            children: <Widget>[
              SizedBox(width: 30.0),
              IconButton(
                color: LightColors.kDarkBlue,
                icon: Icon(
                  Icons.menu,
                  size: 35,
                ),
                onPressed: () {},
              ),
              Spacer(),
              IconButton(
                color: LightColors.kDarkBlue,
                icon: Icon(
                  FontAwesomeIcons.calendarAlt,
                  size: 30,
                ),
                onPressed: () async {
                  final UserDataProvider userDataProvider =
                      Provider.of<UserDataProvider>(context, listen: false);

                  final Map<String, dynamic> _userData = {
                    'uniqueIdentifier': _identifier,
                  };
                  _addData();
                  final Map<String, dynamic> successInfo =
                      await userDataProvider.getUserData(_userData);

                  if (successInfo['success']) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserBooking()));
                  } else {
                    print("something went wrong");
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
                final InfolistProvider infolistProvider =
                    Provider.of<InfolistProvider>(context, listen: false);
                // if (await canLaunch(qrData)) {
                // VCard vc = VCard(qrData);
                // print(vc.organisation);
                var companyID = companyWid.split('-')[1];
                print(companyWid);
                print(vc.name);
                // var id = companyWid;
                // var launchAddress = qrData.split('-')[0];
                // print(qrData);
                // print(launchAddress);
                //  await launch(launchAddress);

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SelectionPage()));
                }
                // } else {
                //   throw 'Could not launch ';
                // }
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
              height: 200,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Icon(Icons.menu,
                    //         color: LightColors.kDarkBlue, size: 30.0),
                    //     Icon(Icons.search,
                    //         color: LightColors.kDarkBlue, size: 25.0),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 7.0, 3, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 90.0,
                            lineWidth: 8.0,
                            animation: true,
                            percent: 0.75,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: LightColors.kRed,
                            backgroundColor: LightColors.kDarkYellow,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 35.0,
                              backgroundImage: AssetImage(
                                'assets/images/sampleLogo2.png',
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Book Me...',
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
                            children: <Widget>[
                              // subheading('My companies'),
                            ],
                          ),
                          SizedBox(height: 15.0),
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
          //  // if (await canLaunch(qrData)) {
          //     alertMassage();
          //  // }
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

  // List<String> _getList() {
  //   SharedPreferences prefs;
  //   var yourList = prefs.getStringList("key");
  //   print(yourList);
  // }

  Future<List<Company>> getCompanies() async {
    var gatCompaniesFromCache = await getData();
    print(gatCompaniesFromCache);
    print("****");
    List<Company> list = <Company>[];
    gatCompaniesFromCache.forEach((element) {
      list.add(new Company(
          name: element['name'],
          address: element['address'],
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
    // print(cacheData);
    return cacheData;
  }
}
