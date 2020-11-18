import 'package:doc/models/slotTitle.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:doc/models/timeSlot.dart';
import 'package:doc/providers/doctorinfo.dart';
import 'package:doc/providers/timeSlot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:doc/screens/patient_form.dart';
import 'package:provider/provider.dart';

class Timeslots extends StatefulWidget {
  @override
  _TimeslotsState createState() => _TimeslotsState();
}

DateFormat formated = new DateFormat("HH:mm");

class _TimeslotsState extends State<Timeslots> {
  DateTime selectedDate = DateTime.now();
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final InfolistProvider infolistProvider =
        Provider.of<InfolistProvider>(context, listen: true);
    final TimeSlotProvider timeSlotsProvider =
        Provider.of<TimeSlotProvider>(context, listen: true);

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
                            minTime: DateTime(now.year, now.month, now.day),
                            maxTime: DateTime(now.year, now.month, now.day + 1),
                            onConfirm: (date) {
                          print('confirm :  $date');
                          print(formated.format(
                              DateTime.parse('2018-09-07T04:30+00:00')
                                  .toLocal()));
                          print(formated.format(DateTime.parse(
                                  '2020-08-12' + 'T' + '04:30' + '+00:00')
                              .toLocal()));

                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          final String formatted = formatter.format(date);
                          timeSlotsProvider.getTimeSlots({
                            'date': formatted,
                            'appointmentcalendar': infolistProvider
                                .currentInfo.appointmentcalendar,
                            'bookingcalendar':
                                infolistProvider.currentInfo.bookingcalendar
                          });

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
              child: timeSlotsProvider.isLoading
                  ? Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                      ),
                    )
                  : ListView.builder(
                      itemCount: timeSlotsProvider.slotTitles.length,
                      itemBuilder: (BuildContext ctx, int i) {
                        SlotTitle currentSlotTitle =
                            timeSlotsProvider.slotTitles[i];
                        return Container(
                          child: Column(
                            children: [
                              Text(
                                "Title : " + (currentSlotTitle.title).split('-')[0],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GridView.count(
                                childAspectRatio: 2,
                                //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                // itemCount: state.bestContributeCountry.length,
                                scrollDirection: Axis.vertical,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                // itemBuilder: (BuildContext context, int index) {
                                children: List.generate(
                                  currentSlotTitle.slots.length,
                                  
                                  (index) {
                                    TimeSlot currentTimeSlot =
                                        currentSlotTitle.slots.length != 0
                                            ? TimeSlot.fromJson(
                                                currentSlotTitle.slots[index])
                                            : null;

                                    // var x = currentTimeSlot.date +'T'+ currentTimeSlot.startTime +'00:00'  ;
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      color: Colors.transparent,
                                      child: new Column(
                                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // shrinkWrap: true,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  height: 60.0,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0),
                                                    child: RaisedButton(
                                                      onPressed: () {
                                                        print(currentTimeSlot.available);
                                                        if (currentTimeSlot
                                                                .available !=
                                                            "0") {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      PatientForm(
                                                                          currentTimeSlot)));
                                                        }
                                                      },
                                                      color: Colors.teal,
                                                      shape:
                                                          new RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        child: Container(
                                                          width: 180,
                                                          child: Center(
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                Text(
                                                                  "${formated.format(DateTime.parse(currentTimeSlot.date + 'T' + currentTimeSlot.startTime + '+00:00').toLocal())} - ${formated.format(DateTime.parse(currentTimeSlot.date + 'T' + currentTimeSlot.endTime + '+00:00').toLocal())}",
                                                                  //"${currentTimeSlot.startTime} - ${currentTimeSlot.endTime}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Louis',
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: currentTimeSlot.available ==
                                                                            "0"
                                                                        ? Colors.teal[
                                                                            700]
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  currentTimeSlot
                                                                              .available ==
                                                                          "0"
                                                                      ? "Not Available"
                                                                      : currentTimeSlot.available +" Slot Available",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Louis',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: currentTimeSlot.available ==
                                                                            "0"
                                                                        ? Colors.red[
                                                                            200]
                                                                        : Colors
                                                                            .teal[200],
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
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// "${currentTimeSlot.startTime} - ${currentTimeSlot.endTime}",
