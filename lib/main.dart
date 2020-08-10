import 'package:doc/providers/doctorarealist.dart';
import 'package:doc/providers/doctorinfo.dart';
import 'package:doc/providers/patient.dart';
import 'package:doc/providers/timeSlot.dart';
import 'package:doc/screens/selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ArealistProvider status = ArealistProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => PatientProvider()),
          ChangeNotifierProvider(create: (ctx) => TimeSlotProvider()),
          ChangeNotifierProvider(create: (ctx) => InfolistProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SelectionPage(),
          theme: ThemeData(
            appBarTheme: AppBarTheme(color: Colors.teal),
          ),
        ));
  }
}
