import 'package:doc/models/area.dart';
import 'package:doc/providers/doctorarealist.dart';
import 'package:doc/providers/timeSlot.dart';
import 'package:doc/providers/userData.dart';
import 'package:doc/screens/timeslots.dart';
import 'package:doc/screens/user_booked.dart';
import 'package:flutter/material.dart';
import 'package:doc/providers/doctorinfo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platform_device_id/platform_device_id.dart';

class SelectionPage extends StatefulWidget {
  SelectionPage({Key key}) : super(key: key);

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  String cacheDocArea, cacheDocSuburb, cacheBValue;
  String _identifier = 'Unknown';
  Future<Map<String, dynamic>> data;
  List<Area> areas = [];
  List<Sub> allSuburbs = [];
  List<Sub> suburbs = [];
  List<Doctor> allDoctors = [];
  List<Doctor> doctors = [];
  Area _selectedArea;
  Sub _selectedSub;
  Doctor _selectedDoc;
  String _areaDisabledText = 'District first';
  String _doctorDisabledText = ' Area first';

  void _getData() async {
    try {
      data = ArealistProvider.getAreaList();
    } catch (e) {
      print(e);
    }
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

  _onAreaSelected(Area area) {
    setState(() {
      _selectedArea = area;
      _selectedSub = null;
      _selectedDoc = null;
      suburbs =
          allSuburbs.where((i) => i.aName == _selectedArea.aName).toList();
      if (suburbs.isEmpty) _areaDisabledText = 'No Areas Now';
      _doctorDisabledText = ' Area first';
      doctors.clear();
    });
  }

  _onSelectSub(Sub sub) {
    setState(() {
      _selectedSub = sub;
      _selectedDoc = null;
      doctors =
          allDoctors.where((i) => i.suburb == _selectedSub.sName).toList();
      if (doctors.isEmpty) _doctorDisabledText = 'No Doctors ';
    });
  }

  _onSelectDoc(Doctor doctor) {
    setState(() {
      _selectedDoc = doctor;
    });
  }

  @override
  void initState() {
    super.initState();
    this._getData();
    this.initPlatformState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    final InfolistProvider infolistProvider =
        Provider.of<InfolistProvider>(context, listen: true);
    final TimeSlotProvider timeSlotsProvider =
        Provider.of<TimeSlotProvider>(context, listen: true);
    print(cacheDocArea);
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(children: <Widget>[
            Expanded(
                flex: 4,
                child: Wrap(
                  spacing: 10.0,
                  children: <Widget>[
                    Container(
                      // margin: EdgeInsets.all(100.0),
                      height: 280.0,
                        
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.elliptical(200, 50),
                            bottomRight: Radius.elliptical(200, 50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: Offset(
                              0.0,
                              5.0,
                            ),
                          )
                        ],
                      ),

                      child: Center(
                        child: Image(
                          image: AssetImage('assets/logo/sampleLogo.png'),
                          height: 100.0,
                          width: 150.0,
                        ),
                      ),
                    ), //widget
                  ],
                )
                //
                ),
            Expanded(
                flex: 3,
                child: FutureBuilder<Map<String, dynamic>>(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        }
                        this.areas = snapshot.data['areas'];
                        this.allSuburbs = snapshot.data['suburbs'];
                        this.allDoctors = snapshot.data['doctors'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 140,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'District',
                                          style: TextStyle(
                                            color: Colors.teal[100],
                                            fontFamily: 'Louis',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Container(
                                        width: 180,
                                        height: 30,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                            color: Colors.teal[800],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: DropdownButton<Area>(
                                          isExpanded: true,
                                          icon: Icon(Icons.expand_more),
                                          iconEnabledColor: Colors.teal[100],
                                          iconSize: 20,
                                          underline: SizedBox(),
                                          hint: Text('Select District',
                                              style: TextStyle(
                                                fontFamily: 'Louis',
                                                color: Colors.teal[100],
                                                fontWeight: FontWeight.w100,
                                                fontSize: 17.0,
                                              )),
                                          disabledHint:
                                              Text('No Districts Available'),
                                          value: _selectedArea,
                                          items: areas
                                              .map((e) =>
                                                  DropdownMenuItem<Area>(
                                                      value: e,
                                                      child: Text(e.aName
                                                          .toUpperCase())))
                                              .toList(),
                                          onChanged: _onAreaSelected,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 140,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Area',
                                          style: TextStyle(
                                            color: Colors.teal[100],
                                            fontFamily: 'Louis',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Container(
                                        width: 180,
                                        height: 30,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                            color: Colors.teal[800],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: DropdownButton<Sub>(
                                          isExpanded: true,
                                          icon: Icon(Icons.expand_more),
                                          iconEnabledColor: Colors.teal[100],
                                          iconSize: 20,
                                          underline: SizedBox(),
                                          hint: Text('Select Area',
                                              style: TextStyle(
                                                fontFamily: 'Louis',
                                                color: Colors.teal[100],
                                                fontWeight: FontWeight.w100,
                                                fontSize: 17.0,
                                              )),
                                          disabledHint: Text(_areaDisabledText),
                                          value: _selectedSub,
                                          items: suburbs
                                              .map((e) => DropdownMenuItem<Sub>(
                                                  value: e,
                                                  child: Text(
                                                      e.sName.toUpperCase())))
                                              .toList(),
                                          onChanged: _onSelectSub,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 140,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Doctor',
                                          style: TextStyle(
                                            color: Colors.teal[100],
                                            fontFamily: 'Louis',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Container(
                                        width: 180,
                                        height: 30,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                            color: Colors.teal[800],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: DropdownButton<Doctor>(
                                          isExpanded: true,
                                          icon: Icon(Icons.expand_more),
                                          iconEnabledColor: Colors.teal[100],
                                          iconSize: 20,
                                          underline: SizedBox(),
                                          hint: Text('Select Doctor',
                                              style: TextStyle(
                                                fontFamily: 'Louis',
                                                color: Colors.teal[100],
                                                fontWeight: FontWeight.w100,
                                                fontSize: 17.0,
                                              )),
                                          disabledHint:
                                              Text(_doctorDisabledText),
                                          value: _selectedDoc,
                                          items: doctors
                                              .map((e) =>
                                                  DropdownMenuItem<Doctor>(
                                                      value: e,
                                                      child: Text(e.name
                                                          .toUpperCase())))
                                              .toList(),
                                          onChanged: _onSelectDoc,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: RaisedButton(
                                onPressed: () async {
                                  final InfolistProvider infolistProvider =
                                      Provider.of<InfolistProvider>(context,
                                          listen: false);

                                  final Map<String, dynamic> _infoData = {
                                    'docArea': '${_selectedArea.aName}',
                                    'docSuburb': '${_selectedSub.sName}',
                                    'docName': '${_selectedDoc.name}',
                                  };
                                  final Map<String, dynamic> successInfo =
                                      await infolistProvider.getInfo(_infoData);

                                  if (successInfo['success']) {
                                    timeSlotsProvider.getTimeSlots({
                                      'appointmentcalendar': infolistProvider
                                          .currentInfo.appointmentcalendar,
                                      'bookingcalendar': infolistProvider
                                          .currentInfo.bookingcalendar
                                    });
                                    if (_selectedArea.aName != 'null' &&
                                        _selectedSub.sName != 'null' &&
                                        _selectedDoc.name != 'null') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Timeslots()));
                                    }
                                  } else {
                                    print("something went wrong");
                                  }
                                },
                                color: Colors.teal,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                    width: 60,
                                    child: timeSlotsProvider.isLoading &&
                                            infolistProvider.isLoading
                                        ? Center(
                                            child: SpinKitFadingCircle(
                                              color: Colors.white,
                                            ),
                                          )
                                        : Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Next',
                                                style: TextStyle(
                                                  fontFamily: 'Louis',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Icon(
                                                Icons.navigate_next,
                                                color: Colors.white,
                                                size: 22,
                                              )
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                        ),
                      );
                    })),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Doctor Booking App (Disclamer)\n\n',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              fontFamily: 'Louis',
                              color: Colors.teal[200])),
                      TextSpan(
                          text:
                              'this is a doc boking app. this is a doc boking app. this is a doc boking app. this is a doc boking app. ',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Louis',
                              color: Colors.teal[300]))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(250, 10, 0, 60),
                child: RaisedButton(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserBooking()));
                    } else {
                      print("something went wrong");
                    }
                  },
                  color: Colors.teal,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(9.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: 40,
                      // height: 30,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Text(
                          //   'Next',
                          //   style: TextStyle(
                          //     fontFamily: 'Louis',
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.w600,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          Icon(
                            Icons.history,
                            color: Colors.black,
                            size: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  _addData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('identifier', _identifier);
    print(_identifier);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    cacheBValue = prefs.getString('bValue');
    cacheDocArea = prefs.getString('docArea');
    cacheDocSuburb = prefs.getString('docSuburb');
  }
}
