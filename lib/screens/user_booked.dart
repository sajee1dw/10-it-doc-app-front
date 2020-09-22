import 'package:doc/models/userData.dart';
import 'package:doc/providers/userData.dart';
import 'package:doc/screens/booked_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBooking extends StatefulWidget {
  @override
  _UserBookingState createState() => _UserBookingState();
}

class _UserBookingState extends State<UserBooking> {
  String cacheIdentifier;
 @override
  void initState() {
    setState(() {
      getData();
    });
    return super.initState();
  }
  Widget build(BuildContext context) {
    final UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context, listen: true);
    print(cacheIdentifier);
    return Scaffold(
      appBar: AppBar(
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

      // ),
      body: Column(
        children: <Widget>[
          // Expanded(
          //   flex: 2,
          //   child:
          Container(
            height: 80.0,
            color: Colors.teal,
            child: Row(
              children: <Widget>[
                //  Container(
                //    color: Colors.red,
                //    child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Your Bookings......!',
                        style: TextStyle(
                          fontFamily: 'Louis',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(250.0, 5.0, 10, 0),
                      child: FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          userDataProvider.getUserData({
                            'uniqueIdentifier': cacheIdentifier,
                            'clearLogId': cacheIdentifier,
                          });
                        },
                        child: Text(
                          "Clear log",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
                // )
                // ),
              ],
            ),
          ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child:

          Expanded(
            flex: 12,
            child: Container(
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
              child: userDataProvider.isLoading
                  ? Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                      ),
                    )
                  : GridView.count(
                      childAspectRatio: 4,
                      shrinkWrap: true,
                      crossAxisCount: 1,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      children: List.generate(userDataProvider.userData.length,
                          (index) {
                        UserData currentUserData =
                            userDataProvider.userData.length != 0
                                ? userDataProvider.userData[index]
                                : [];
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          color: Colors.transparent,
                          child: new Column(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // shrinkWrap: true,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      height: 80.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: RaisedButton(
                                          onPressed: () {
                                            if (currentUserData.bValue != 1) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DataPage(
                                                              currentUserData)));
                                            }
                                          },
                                          color: Colors.teal,
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Container(
                                              width: 180,
                                              child: Center(
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                    Text(
                                                      "Doctor -: " +
                                                          currentUserData
                                                              .doctorName +
                                                          "               " +
                                                          "Date -: " +
                                                          (currentUserData
                                                                  .endTime)
                                                              .split("T")[0] +
                                                          "               " +
                                                          "Time -: " +
                                                          (currentUserData
                                                                  .startTime)
                                                              .split("T")[1],
                                                      //"${formated.format(DateTime.parse(currentTimeSlot.date + 'T' + currentTimeSlot.startTime + '+00:00').toLocal())} - ${formated.format(DateTime.parse(currentTimeSlot.date + 'T' + currentTimeSlot.endTime + '+00:00').toLocal())}",
                                                      //"${currentTimeSlot.startTime} - ${currentTimeSlot.endTime}",
                                                      style: TextStyle(
                                                        fontFamily: 'Louis',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: currentUserData
                                                                    .bValue ==
                                                                1
                                                            ? Colors.teal[700]
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                    // Text(
                                                    //   currentUserData.bValue == 1
                                                    //       ? "Not Awailable"
                                                    //       : "Awailable",
                                                    //   style: TextStyle(
                                                    //     fontFamily: 'Louis',
                                                    //     fontSize: 12,
                                                    //     fontWeight:
                                                    //         FontWeight.w600,
                                                    //     color: currentUserData
                                                    //                 .bValue ==
                                                    //             1
                                                    //         ? Colors.red[200]
                                                    //         : Colors.teal[200],
                                                    //   ),
                                                    // ),
                                                  ])),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),

                      // }
                    ),
            ),
          ),
        ],
      ),
    );
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    cacheIdentifier = prefs.getString('identifier');
  }
}
