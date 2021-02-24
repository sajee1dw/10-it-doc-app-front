import 'package:bookme/models/userData.dart';
import 'package:bookme/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:bookme/screens/user_booked.dart';

class DataPage extends StatefulWidget {
  final UserData userData;
  DataPage(this.userData);
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.height;
    var x = widget.userData.startTime;
    return Scaffold(
      appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios,
                color: Colors.white, size: size * 0.035),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            height: height * 0.1,
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
                      fontSize: size * 0.04,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.09,
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
                              fontSize: size * 0.025,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            x.split(" ")[0], //set date
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: size * 0.03,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                  ),
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
                              fontSize: size * 0.025,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            x.split(" ")[1], //set time
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: size * 0.03,
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
                          Text(" Name : " + widget.userData.clientName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size * 0.040,
                                  fontWeight: FontWeight.w500)),
                          //or use padding to show name
                          Padding(
                              padding: EdgeInsets.only(top: height * 0.03),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: height * 0.006),
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'Name : ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
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
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'Address : ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      '${widget.userData.address}', //fetch address
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
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'Phone Number : ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      '${widget.userData.mobile}', //fetch patient mobile
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
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
                                          padding: const EdgeInsets.all(10.0),
                                          child: RaisedButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserBooking()));
                                            },
                                            color: Colors.teal,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.20,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Back',
                                                      style: TextStyle(
                                                        fontSize: size * 0.03,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                    ),
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
                  )))
        ],
      )),
    );
  }
}
