import 'package:doc/providers/doctorarealist.dart';
import 'package:doc/providers/doctorinfo.dart';
import 'package:doc/providers/patient.dart';
import 'package:doc/providers/timeSlot.dart';
import 'package:doc/providers/userData.dart';
import 'package:doc/screens/selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doc/theme/colors/light_colors.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.kLightYellow, // navigation bar color
    statusBarColor: Color(0xffffb969), // status bar color
  ));

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
 // final ArealistProvider status = ArealistProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => PatientProvider()),
          ChangeNotifierProvider(create: (ctx) => TimeSlotProvider()),
          ChangeNotifierProvider(create: (ctx) => InfolistProvider()),
          ChangeNotifierProvider(create: (ctx) => UserDataProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SelectionPage(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Theme.of(context).textTheme.apply(
                bodyColor: LightColors.kDarkBlue,
                displayColor: LightColors.kDarkBlue,
                fontFamily: 'Poppins'),
          ),
        ));
  }
}
