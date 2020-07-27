import 'package:doc/models/patient.dart';
import 'package:flutter/material.dart';

class ReceiptPage extends StatelessWidget {

   
 final Patient patient;
  ReceiptPage({Key key, @required this.patient}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    //print(patient.name);
    return Scaffold(
      appBar: AppBar(
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
          height: 80.0,
          color: Colors.teal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Booking Successful !',
                  style: TextStyle(
                    fontFamily: 'Louis',
                    color: Colors.red[200],
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
                Colors.teal,
                Colors.teal[900],
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
                      border: Border.all(color: Colors.teal[200])),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Date : ',
                          style: TextStyle(
                            fontFamily: 'Sansation',
                            color: Colors.teal[200],
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '2020 - 12 - 12', //set date
                          style: TextStyle(
                            fontFamily: 'Sansation',
                            color: Colors.teal[100],
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
                      border: Border.all(color: Colors.teal[200])),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Time : ',
                          style: TextStyle(
                            fontFamily: 'Sansation',
                            color: Colors.teal[200],
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '8:15am', //set time
                          style: TextStyle(
                            fontFamily: 'Sansation',
                            color: Colors.teal[100],
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
                      Colors.teal[900],
                      Colors.black,
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
                            'Dr. Nobody Noman (MBBS)',
                            style: TextStyle(
                                fontFamily: 'Louis',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Text(
                            'No.20, Nowhere, Noland',
                              style: TextStyle(
                                color: Colors.teal[100],
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Name : ',
                                          style: TextStyle(
                                              fontFamily: 'Louis',
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    //'Person who booking', //fetch name
                                               (" ${patient.name}"),
                                                style: TextStyle(
                                                    fontFamily: 'Louis',
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Patient Name : ',
                                          style: TextStyle(
                                              fontFamily: 'Louis',
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    //'Patient name here', //fetch patient name
                                                    ("${patient.patient}"),
                                                style: TextStyle(
                                                    fontFamily: 'Louis',
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'NIC Number : ',
                                          style: TextStyle(
                                              fontFamily: 'Louis',
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                   // '123456789v', //fetch patient name
                                                   ("${patient.idno}"),
                                                style: TextStyle(
                                                    fontFamily: 'Louis',
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Age : ',
                                          style: TextStyle(
                                              fontFamily: 'Louis',
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                   // '45 yrs', //fetch patient name
                                                   ("${patient.age}"),
                                                style: TextStyle(
                                                    fontFamily: 'Louis',
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Address : ',
                                          style: TextStyle(
                                              fontFamily: 'Louis',
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    //'No. 77, ward no99, Patient street, Hospital', //fetch patient name
                                          (" ${patient.address}"),
                                                style: TextStyle(
                                                    fontFamily: 'Louis',
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Phone Number : ',
                                          style: TextStyle(
                                              fontFamily: 'Louis',
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                   // '0771236547', //fetch patient name
                                                    ("${patient.mobile}"),
                                                style: TextStyle(
                                                    fontFamily: 'Louis',
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Reference number : ',
                                          style: TextStyle(
                                              fontFamily: 'Louis',
                                              color: Colors.white60,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '15D-064F', //fetch any referance number
                                                style: TextStyle(
                                                    fontFamily: 'Louis',
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ]),
                                    ),
                                  ),
                                ]))
                      ],
                      // ),
                    ),
                  ),
                )))
      ]),
      // ),
    );
  }
}
