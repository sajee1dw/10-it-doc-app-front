import 'package:bookme/providers/patient.dart';
import 'package:bookme/providers/timeSlot.dart';
import 'package:bookme/screens/timeslots.dart';
import 'package:bookme/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:bookme/screens/selection.dart';
import 'package:bookme/providers/doctorinfo.dart';
import 'package:provider/provider.dart';

class ReceiptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InfolistProvider infolistProvider =
        Provider.of<InfolistProvider>(context, listen: true);
    final PatientProvider patientProvider =
        Provider.of<PatientProvider>(context, listen: true);
    final TimeSlotProvider timeSlotsProvider =
        Provider.of<TimeSlotProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: LightColors.kDarkYellow,
          title: Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/logo-small.png',
                  fit: BoxFit.contain,
                  height: height * 0.05,
                ),
              ],
            ),
          )),
      body: Column(children: <Widget>[
        Container(
          height: height * 0.1,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  patientProvider.currentPatient.bValue == '1'
                      ? 'Booking Successful !'
                      : 'Booking Failed !',
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: size * 0.026,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: height * 0.07,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.fromLTRB(width * 0.017, 0, width * 0.008, 0),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(30.0),
                      color: LightColors.kLightYellow2,
                      border: Border.all(color: Colors.white24)),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Date : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size * 0.014,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          patientProvider.currentPatient.date,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: size * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                ),
                // )
              ),
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.fromLTRB(width * 0.017, 0, width * 0.008, 0),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(30.0),
                      color: LightColors.kLightYellow2,
                      border: Border.all(color: Colors.white24)),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Time : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size * 0.014,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          patientProvider.currentPatient.startTime,
                          // '${formated.format(DateTime.parse(patientProvider.currentPatient.date + 'T' + patientProvider.currentPatient.startTime + '+00:00').toLocal())}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: size * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.white,
                      Colors.orange[200],
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.010,
                      width * 0.03, height * 0.030),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            infolistProvider.currentInfo != null
                                ? 'Name : ' +
                                    infolistProvider.currentInfo.clientName
                                        .toUpperCase()
                                : "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size * 0.020,
                                fontWeight: FontWeight.w700)),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.007),
                          child: Text(
                              infolistProvider.currentInfo != null
                                  ? infolistProvider.currentInfo.address
                                  : "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size * 0.016,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: height * 0.03),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: patientProvider
                                            .currentPatient.bValue ==
                                        '1'
                                    ? <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: height * 0.006),
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'Name : ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: size * 0.018,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: patientProvider
                                                          .currentPatient.name,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                              size * 0.018,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: height * 0.006),
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'Address : ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: size * 0.018,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: patientProvider
                                                          .currentPatient
                                                          .address,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                              size * 0.018,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: height * 0.006),
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'Phone Number : ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: size * 0.018,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: patientProvider
                                                          .currentPatient
                                                          .mobile,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                              size * 0.018,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, height * .15, 0, 0),
                                          child: Container(
                                            child: Center(
                                                child: Padding(
                                              padding:
                                                  EdgeInsets.all(size * 0.01),
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SelectionPage()));
                                                },
                                                color: Colors.teal,
                                                shape:
                                                    new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      size * 0.008),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.20,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          'Done',
                                                          style: TextStyle(
                                                            fontSize:
                                                                size * 0.016,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700, //
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.navigate_next,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ),
                                        )
                                      ]
                                    : <Widget>[
                                        failMassage(),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, height * 0.15, 0, 0),
                                          child: Container(
                                            child: Center(
                                                child: Padding(
                                              padding:
                                                  EdgeInsets.all(size * 0.010),
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  timeSlotsProvider
                                                      .getTimeSlots({
                                                    'appointmentcalendar':
                                                        infolistProvider
                                                            .currentInfo
                                                            .appointmentcalendar,
                                                    'bookingcalendar':
                                                        infolistProvider
                                                            .currentInfo
                                                            .bookingcalendar
                                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Timeslots()));
                                                },
                                                color: Colors.teal,
                                                shape:
                                                    new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      size * 0.008),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.20,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          'Again',
                                                          style: TextStyle(
                                                            fontSize:
                                                                size * 0.016,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.navigate_next,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ),
                                        )
                                      ]))
                      ],
                    ),
                  ),
                ))),
      ]),
    );
  }
}

Widget failMassage() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: RichText(
      text: TextSpan(
          text: 'Try Again  ...... !',
          style: TextStyle(
              fontFamily: 'Louis',
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.w600)),
    ),
  );
}
