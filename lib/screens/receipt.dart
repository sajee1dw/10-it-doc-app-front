import 'package:doc/providers/patient.dart';
import 'package:doc/providers/timeSlot.dart';
import 'package:doc/screens/timeslots.dart';
import 'package:doc/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:doc/screens/selection.dart';
import 'package:doc/providers/doctorinfo.dart';
import 'package:provider/provider.dart';

class ReceiptPage extends StatelessWidget {
  // final Patient patient;
  // ReceiptPage({Key key, @required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InfolistProvider infolistProvider =
        Provider.of<InfolistProvider>(context, listen: true);
    final PatientProvider patientProvider =
        Provider.of<PatientProvider>(context, listen: true);
    final TimeSlotProvider timeSlotsProvider =
        Provider.of<TimeSlotProvider>(context, listen: true);
    //DateFormat formated = new DateFormat("HH:mm");
    // //'${formated.format(patient.startTime)}'
    // var startDateTime = ("${patient.startTime}");
    // var startTime = ("${formated.format(patient.startTime)}");

    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.white, size: 35),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: LightColors.kDarkYellow,
          title: Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/logo/sampleLogo.png',
                  fit: BoxFit.contain,
                  height: 32,
                ),
              ],
            ),
          )),
      body: Column(children: <Widget>[
        Container(
          height: 100.0,
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
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 70.0,
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
                  margin: const EdgeInsets.fromLTRB(17.0, 0, 8.0, 0),
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
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          //startDateTime.split(" ")[0],
                          patientProvider.currentPatient.date,

                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                ),
                // )
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8.0, 0, 17.0, 0),
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
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          //startTime,
                          patientProvider.currentPatient.startTime,
                          // '${formated.format(DateTime.parse(patientProvider.currentPatient.date + 'T' + patientProvider.currentPatient.startTime + '+00:00').toLocal())}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
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
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                  child: Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            infolistProvider.currentInfo != null
                                ? 'Name : ' +
                                    infolistProvider.currentInfo.docName
                                        .toUpperCase()
                                : "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700)),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Text(
                              infolistProvider.currentInfo != null
                                  ? infolistProvider.currentInfo.docAddress
                                  : "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: patientProvider
                                            .currentPatient.bValue ==
                                        '1'
                                    ? <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 6.0),
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'Name : ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: patientProvider
                                                          .currentPatient.name,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ]),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       bottom: 6.0),
                                        //   child: RichText(
                                        //     text: TextSpan(
                                        //         text: 'Patient Name : ',
                                        //         style: TextStyle(
                                        //             fontFamily: 'Louis',
                                        //             color: Colors.black,
                                        //             fontSize: 18,
                                        //             fontWeight:
                                        //                 FontWeight.w600),
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: patientProvider
                                        //                   .currentPatient
                                        //                   .patient,
                                        //               style: TextStyle(
                                        //                   fontFamily: 'Louis',
                                        //                   color: Colors.black,
                                        //                   fontSize: 18,
                                        //                   fontWeight:
                                        //                       FontWeight.w400)),
                                        //         ]),
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       bottom: 6.0),
                                        //   child: RichText(
                                        //     text: TextSpan(
                                        //         text: 'NIC Number : ',
                                        //         style: TextStyle(
                                        //             fontFamily: 'Louis',
                                        //             color: Colors.black,
                                        //             fontSize: 18,
                                        //             fontWeight:
                                        //                 FontWeight.w600),
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: patientProvider
                                        //                   .currentPatient.idno,
                                        //               style: TextStyle(
                                        //                   fontFamily: 'Louis',
                                        //                   color: Colors.black,
                                        //                   fontSize: 18,
                                        //                   fontWeight:
                                        //                       FontWeight.w400)),
                                        //         ]),
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       bottom: 6.0),
                                        //   child: RichText(
                                        //     text: TextSpan(
                                        //         text: 'Age : ',
                                        //         style: TextStyle(
                                        //             fontFamily: 'Louis',
                                        //             color: Colors.black,
                                        //             fontSize: 18,
                                        //             fontWeight:
                                        //                 FontWeight.w600),
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: patientProvider
                                        //                   .currentPatient.age,
                                        //               style: TextStyle(
                                        //                   fontFamily: 'Louis',
                                        //                   color: Colors.black,
                                        //                   fontSize: 18,
                                        //                   fontWeight:
                                        //                       FontWeight.w400)),
                                        //         ]),
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 6.0),
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'Address : ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: patientProvider
                                                          .currentPatient
                                                          .address,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 6.0),
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'Phone Number : ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: patientProvider
                                                          .currentPatient
                                                          .mobile,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30.0),
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'Reference number : ',
                                                style: TextStyle(
                                                    fontFamily: 'Louis',
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          //'15D-064F', //fetch any referance number
                                                          patientProvider
                                                              .currentPatient
                                                              .bValue,
                                                      style: TextStyle(
                                                          fontFamily: 'Louis',
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 150, 0, 0),
                                          child: Container(
                                            child: Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                                  padding: EdgeInsets.all(8),
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
                                                        // Expanded(
                                                        Text(
                                                          'Done',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700, //
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        // ),
                                                        Icon(
                                                          Icons.navigate_next,
                                                          color: Colors.white,
                                                          //size: 22,
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
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 150, 0, 0),
                                          child: Container(
                                            child: Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                                  padding: EdgeInsets.all(8),
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
                                                        // Expanded(
                                                        Text(
                                                          'Again',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        // ),
                                                        Icon(
                                                          Icons.navigate_next,
                                                          color: Colors.white,
                                                          //size: 22,
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
                      // ),
                    ),
                  ),
                ))),
      ]),
      // ),
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
