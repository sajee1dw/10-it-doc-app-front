import 'dart:async';
import 'package:bookme/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  PackageInfo _packageInfo = PackageInfo(
    //add this variables if want to get those

    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      print(DateTime.now().timeZoneOffset);
      _packageInfo = info;
    });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: height * 0.10,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios,
                color: Colors.white, size: size * 0.035),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
          height: height * 0.2,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'About Us',
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
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'App version : ' + _packageInfo.version,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: size * 0.02,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.topCenter,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  width * 0.1, height * 0.01, width * 0.1, 0.0),
                              child: Text(
                                'This is another paragraph. I think it needs to be added that the set of elements tested is not exhaustive in any sense. I have selected those elements for which it can make sense to write user style sheet rules, in my opinion.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size * 0.02,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                      // ),
                    ),
                  ),
                ))),
      ]),
    );
  }
}
