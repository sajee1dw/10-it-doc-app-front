import 'package:bookme/models/userData.dart';
import 'package:bookme/providers/userData.dart';
import 'package:bookme/screens/booked_data.dart';
import 'package:bookme/theme/colors/light_colors.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;
    print(cacheIdentifier);
    return Scaffold(
      appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios,
                color: Colors.white, size: size * 0.05),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: LightColors.kDarkYellow,
          title: Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      width * 0.0150, height * 0.0070, width * 0.003, 0),
                  child: Text(
                    'Your Bookings.!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size * 0.06,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )),

      // ),
      body: Column(
        children: <Widget>[
          Container(
            height: height * 0.100,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.6500, height * 0.0020, 0.0, 0),
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
                            Text(
                              'Clear',
                              style: TextStyle(
                                fontSize: size * 0.04,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 20,
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
                      childAspectRatio: 2.5,
                      shrinkWrap: true,
                      crossAxisCount: 1,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      children: List.generate(userDataProvider.userData.length,
                          (index) {
                        UserData currentUserData =
                            userDataProvider.userData.length != 0
                                ? userDataProvider.userData[index]
                                : [];
                        return Container(
                          height: height * 2,
                          color: Colors.transparent,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      height: height * 0.1400, //box height
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.0350),
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
                                                new BorderRadius.circular(30.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Container(
                                              width: width * 0.250,
                                              child: Center(
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                    Text(
                                                      "Name -: " +
                                                          currentUserData
                                                              .clientName +
                                                          "               " +
                                                          "Date -: " +
                                                          (currentUserData
                                                                  .endTime)
                                                              .split(" ")[0] +
                                                          "               " +
                                                          "Time -: " +
                                                          (currentUserData
                                                                  .startTime)
                                                              .split(" ")[1],
                                                      style: TextStyle(
                                                        fontSize: size * 0.025,
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
