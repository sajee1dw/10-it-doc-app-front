import 'package:doc/models/userData.dart';
import 'package:doc/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:doc/screens/user_booked.dart';

class DataPage extends StatefulWidget {
  final UserData userData;
  DataPage(this.userData);
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    var x = widget.userData.endTime;
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
                // Image.asset(
                //   'assets/logo/sampleLogo.png',
                //   fit: BoxFit.contain,
                //   height: 32,
                // ),
              ],
            ),
          )),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                height: 80.0,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Booking Data .... !',
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
                                x.split("T")[0], //set date
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
                                x.split("T")[1], //set time
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
                        padding:
                            const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                        child: Container(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(" Name : " + widget.userData.doctorName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 7.0),
                              //   child: Text('No.20, Nowhere, Noland',
                              //       style: TextStyle(
                              //         color: Colors.teal[100],
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w400,
                              //       )),
                              // ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
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
                                                      text:
                                                          '${widget.userData.name}', //fetch name
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ]),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(bottom: 6.0),
                                        //   child: RichText(
                                        //     text: TextSpan(
                                        //         text: 'Patient Name : ',
                                        //         style: TextStyle(
                                        //             fontFamily: 'Louis',
                                        //             color: Colors.black,
                                        //             fontSize: 18,
                                        //             fontWeight: FontWeight.w600),
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text:
                                        //                   '${widget.userData.patient}', //fetch patient name
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
                                        //   padding: const EdgeInsets.only(bottom: 6.0),
                                        //   child: RichText(
                                        //     text: TextSpan(
                                        //         text: 'NIC Number : ',
                                        //         style: TextStyle(
                                        //             fontFamily: 'Louis',
                                        //             color: Colors.black,
                                        //             fontSize: 18,
                                        //             fontWeight: FontWeight.w600),
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text:
                                        //                   '${widget.userData.idno}', //fetch patient name
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
                                        //   padding: const EdgeInsets.only(bottom: 6.0),
                                        //   child: RichText(
                                        //     text: TextSpan(
                                        //         text: 'Age : ',
                                        //         style: TextStyle(
                                        //             fontFamily: 'Louis',
                                        //             color: Colors.black,
                                        //             fontSize: 18,
                                        //             fontWeight: FontWeight.w600),
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text:
                                        //                   '${widget.userData.age}', //fetch patient name
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
                                                      text:
                                                          '${widget.userData.address}', //fetch patient name
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
                                                      text:
                                                          '${widget.userData.mobile}', //fetch patient name
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 130, 0, 0),
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
                                                              UserBooking()));
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
                                                          'Back',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700, //
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        // Icon(
                                                        //   Icons.navigate_next,
                                                        //   color: Colors.white,
                                                        //   //size: 22,
                                                        // )
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
                      )))
            ],
          )),
      // ),
    );
  }
}
