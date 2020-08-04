import 'package:intl/intl.dart';
import 'package:doc/models/timeSlot.dart';
import 'package:doc/providers/doctorinfo.dart';
import 'package:doc/providers/timeSlot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:doc/screens/patient_form.dart';
import 'package:provider/provider.dart';
// import 'package:navigate/pages/third.dart';

class Timeslots extends StatefulWidget {
  @override
  _TimeslotsState createState() => _TimeslotsState();
}

class _TimeslotsState extends State<Timeslots> {
  DateTime selectedDate = DateTime.now();
  //String _date = "Not set";
  //List _filteredTimeSlots = [];
  //Arealist status;

  @override
  Widget build(BuildContext context) {
    final InfolistProvider infolistProvider =
        Provider.of<InfolistProvider>(context, listen: true);
    final TimeSlotProvider timeSlotsProvider =
        Provider.of<TimeSlotProvider>(context, listen: true);
   //  timeSlotsProvider.getTimeSlots(String );
    // timeSlotsProvider.timeSlots.forEach((slot) {
    //   print("slot date = ${slot.date} , _date = $_date");
    //   if (slot.date == _date) {
    //     _filteredTimeSlots.add(slot);
    //   }
    // });
    // print(_filteredTimeSlots);
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
                        //'Dr. Nobody Noman (MBBS)', //Set Doctor Name
                        infolistProvider.currentInfo != null
                            ? 'Dr : ' +
                                infolistProvider.currentInfo.docName
                                    .toUpperCase()
                            : "",
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
                      padding: const EdgeInsets.fromLTRB(17.0, 5.0, 0, 0),
                      child: Text(
                        //'No.20, Nowhere, Noland', //Set Doctor Address
                        infolistProvider.currentInfo != null
                            ? infolistProvider.currentInfo.docAddress
                            : "",
                        style: TextStyle(
                          color: Colors.teal[100],
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                //  )
                // ),
              ],
            ),
          ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child:
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
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Set Date',
                        style: TextStyle(
                          fontFamily: 'Sansation',
                          color: Colors.teal[200],
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: RaisedButton(
                      color: Colors.teal[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      elevation: 4.0,
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            theme: DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            showTitleActions: true,
                            minTime: DateTime(2020, 1, 1),
                            maxTime: DateTime(2030, 12, 31), onConfirm: (date) {
                          print('confirm :  $date');
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          final String formatted = formatter.format(date);
                          // timeSlotsProvider.getTimeSlots({'date': date.toString()});
                          timeSlotsProvider.getTimeSlots({'date': formatted});

                          if (date != null && date != selectedDate)
                            setState(() {
                              selectedDate = date;
                            });
                        },
                            currentTime: DateTime.now(),
                            locale: LocaleType
                                .en); //currentTime: DateTime.now(), locale: LocaleType.en
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Icon(
                                          Icons.event,
                                          size: 18.0,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      Text(
                                        "${selectedDate.toLocal()}"
                                            .split(' ')[0],
                                        style: TextStyle(
                                            fontFamily: 'Louis',
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "Change",
                              style: TextStyle(
                                  fontFamily: 'Sansation',
                                  color: Colors.red[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
              child: GridView.count(
                childAspectRatio: 2,
                //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                shrinkWrap: true,
                crossAxisCount: 2,
                // itemCount: state.bestContributeCountry.length,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // itemBuilder: (BuildContext context, int index) {
                children:
                    List.generate(timeSlotsProvider.timeSlots.length, (index) {
                  TimeSlot currentTimeSlot =
                      timeSlotsProvider.timeSlots.length != 0
                          ? timeSlotsProvider.timeSlots[index]
                          : [];
                  // print(timeSlotsProvider.timeSlots.length);
                  // print(currentTimeSlot);
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
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
                                height: 60.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: RaisedButton(
                                    onPressed: () {
                                      if (currentTimeSlot.slot != 1) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PatientForm(
                                                        currentTimeSlot)));
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
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                              Text(
                                                // if (currentTimeSlot.date == c)

                                                "${currentTimeSlot.startTime} - ${currentTimeSlot.endTime}",
                                                style: TextStyle(
                                                  fontFamily: 'Louis',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      currentTimeSlot.slot == 1
                                                          ? Colors.teal[700]
                                                          : Colors.white,
                                                ),
                                              ),
                                              Text(
                                                currentTimeSlot.slot == 1
                                                    ? "Not Awailable"
                                                    : "Awailable",
                                                style: TextStyle(
                                                  fontFamily: 'Louis',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      currentTimeSlot.slot == 1
                                                          ? Colors.red[200]
                                                          : Colors.teal[200],
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   // flex: 5,
                            //   child: Container(
                            //     height: 60.0,
                            //     child: Padding(
                            //       padding: const EdgeInsets.symmetric(
                            //           horizontal: 2.0),
                            //       child: RaisedButton(
                            //         onPressed: () {},
                            //         color: Colors.teal,
                            //         shape: new RoundedRectangleBorder(
                            //           borderRadius:
                            //               new BorderRadius.circular(5.0),
                            //         ),
                            //         child: Padding(
                            //           padding: EdgeInsets.all(0),
                            //           child: Container(
                            //             width: 180,
                            //             child: Center(
                            //                 child: Column(
                            //                     mainAxisAlignment:
                            //                         MainAxisAlignment.center,
                            //                     children: <Widget>[
                            //                   Text(
                            //                     '10:15am - 10:30am',
                            //                     style: TextStyle(
                            //                       fontFamily: 'Louis',
                            //                       fontSize: 18,
                            //                       fontWeight: FontWeight.w600,
                            //                       color: Colors.teal[800],
                            //                     ),
                            //                   ),
                            //                   Text(
                            //                     'Not Available',
                            //                     style: TextStyle(
                            //                       fontFamily: 'Louis',
                            //                       fontSize: 12,
                            //                       fontWeight: FontWeight.w600,
                            //                       color: Colors.red[200],
                            //                     ),
                            //                   ),
                            //                 ])),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
}
