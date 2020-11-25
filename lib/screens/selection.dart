import 'package:doc/Widgets/top_container.dart';
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

class SelectionPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<SelectionPage> {
  String cacheDocArea, cacheDocSuburb, cacheBValue;
  List lessons;
  String _identifier = 'Unknown';
  @override
  void initState() {
    lessons = getCompanies();
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
    double height =MediaQuery.of(context).size.height;
    ListTile makeListTile(Company company) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            child: CircleAvatar(
              radius: 40,
              // backgroundColor: Color(0xffFDCF09),
              child: CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage('assets/logo/sampleLogo.png'),
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
          itemCount: lessons.length,
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
        onPressed: () {},
      ),
    );
  }

  _addData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('identifier', _identifier);
    print(_identifier);
  }
}

List getCompanies() {
  return [
    Company(
        name: "AutoMax Service",
        address: "Kalutara North",
        id: "3k0n6tMxJf6Rw8izDiZi",
        logo: "auotmax.png")
  ];
}
