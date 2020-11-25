import 'package:doc/models/userData.dart';
import 'package:doc/providers/userData.dart';
import 'package:doc/screens/booked_data.dart';
import 'package:doc/theme/colors/light_colors.dart';
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
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.white, size: 35),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: LightColors.kDarkYellow,
          title: Center(
            
            child: new Row(
              
              mainAxisAlignment: MainAxisAlignment.end,
              children:<Widget> [
                Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 7.0, 3, 0),
                      child: Text(
                        'Your Bookings.!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
              ],
            ),
          )
          ),

      // ),
      body: Column(
        children: <Widget>[
          Container(
            height: 60.0,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(15.0, 7.0, 3, 0),
                    //   child: Text(
                    //     'Your Bookings.!',
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 22,
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(280.0, 0.0, 10, 0),
                      child: FlatButton(
                        color: LightColors.kGreen,
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          userDataProvider.getUserData({
                            'uniqueIdentifier': cacheIdentifier,
                            'clearLogId': cacheIdentifier,
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Expanded(
                            Text(
                              'Clear',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700, //
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
                  colors: <Color>[Colors.white, Colors.orange[200]],
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
                                          color: LightColors.kLightYellow2,
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(40.0),
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
                                                      "Name -: " +
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
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
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
