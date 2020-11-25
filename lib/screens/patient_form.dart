import 'package:doc/models/timeSlot.dart';
import 'package:doc/providers/doctorinfo.dart';
import 'package:doc/theme/colors/light_colors.dart';
import 'package:provider/provider.dart';
import '../providers/patient.dart';
import 'package:doc/screens/receipt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';

class PatientForm extends StatefulWidget {
  final TimeSlot timeSlot;
  PatientForm(this.timeSlot);

  @override
  _PatientFormState createState() => _PatientFormState();
}

DateFormat formated = new DateFormat("HH:mm");

class _PatientFormState extends State<PatientForm> {
  Map<String, dynamic> _formData = <String, dynamic>{};
  String _identifier = 'Unknown';
  String _now = new DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController patientController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String name;
  String patientname;
  String age;
  String phone;
  bool isEnabled = true;
  String cacheName,
      cachePatientName,
      cacheIdNo,
      cacheAge,
      cacheAddress,
      cacheMobile,
      cacheBValue;

  @override
  void initState() {
    setState(() {
      getData();
    });
    initPlatformState();
    return super.initState();
  }

  Future<void> initPlatformState() async {
    String deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    if (!mounted) return;

    setState(() {
      _identifier = deviceId;
      print("****deviceId->$_identifier");
    });
  }

  @override
  Widget build(BuildContext context) {
    final InfolistProvider infolistProvider =
        Provider.of<InfolistProvider>(context, listen: true);
    print("creater Date" + _now);
    return Scaffold(
      appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.white, size: 35),
            onPressed: () => Navigator.of(context).pop(),
          ),
          toolbarHeight: 80.0,
          backgroundColor: LightColors.kDarkYellow,
          title: Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  // height: 120.0,
                  color: LightColors.kDarkYellow,
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
                                color: Colors.black,
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
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
              ],
            ),
          )),
      body: Column(
        children: <Widget>[
          // Expanded(
          //   flex: 2,
          // child:
          // Container(
          //   height: 80.0,
          //   color: LightColors.kDarkYellow,
          //   child: Row(
          //     children: <Widget>[
          //       //  Container(
          //       //    color: Colors.red,
          //       //    child:
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(150.0, 0.0, 0, 0),
          //             child: Text(
          //               infolistProvider.currentInfo != null
          //                   ? 'Dr : ' +
          //                       infolistProvider.currentInfo.docName
          //                           .toUpperCase()
          //                   : "",
          //               style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.w800,
          //               ),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(140.0, 5.0, 0, 0),
          //             child: Text(
          //               infolistProvider.currentInfo != null
          //                   ? infolistProvider.currentInfo.docAddress
          //                   : "",
          //               style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //               textAlign: TextAlign.start,
          //             ),
          //           ),
          //         ],
          //       ),
          //       //  )
          //       // ),
          //     ],
          //   ),
          // ),
          // ),
          Container(
            height: 70.0,
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
                    margin: const EdgeInsets.fromLTRB(17.0, 0, 8.0, 0),
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
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${widget.timeSlot.date}', //set date
                            style: TextStyle(
                              color: Colors.grey,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${formated.format(DateTime.parse(widget.timeSlot.date + 'T' + widget.timeSlot.startTime + '+00:00').toLocal())}',
                            //'${widget.timeSlot.startTime}', //set time
                            style: TextStyle(
                              color: Colors.grey,
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
              // children: <Widget>[
              child: Container(
                  //  width: 100,
                  // height: 700,
                  // color: Colors.yellow[200],
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        // child: Padding(
                        //   padding: const EdgeInsets.all(15.0),
                        //   child: Text(
                        //     'Please complete the form below',
                        //     style: TextStyle(
                        //         color: Colors.red[600],
                        //         fontSize: 17.0,
                        //         fontWeight: FontWeight.w600),
                        //   ),
                        // )
                      ),
                      Container(
                          width: 350,
                          child: Form(
                              key: _formKey,
                              autovalidate: _autoValidate,
                              child: formPatient()))
                    ]),
                  ))
              // ],
              )
        ],
      ),
    );
  }

  Widget formPatient() {
    final InfolistProvider infolistProvider =
        Provider.of<InfolistProvider>(context, listen: true);
    // FocusNode myFocusNode = new FocusNode();
    return new Column(
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 1.0),
              child: Text(
                'Who make the reservation?'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
        new TextFormField(
          controller: nameController,
          autofocus: true,
          style: new TextStyle(
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w500 //Colors.teal[200]
                ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black) //Colors.teal[200]
                ),
          ),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String value) {
            _formData['Name'] = "value";
          },
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Please enter your details below.'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )),
        // new TextFormField(
        //   controller: patientController,
        //   autofocus: true,
        //   style: new TextStyle(
        //     color: Colors.grey,
        //     fontFamily: 'Sansation',
        //   ),
        //   decoration: const InputDecoration(
        //     labelText: 'Patient Name',
        //     labelStyle: TextStyle(
        //       color: Colors.black, //Colors.teal[200]
        //     ),
        //     enabledBorder: UnderlineInputBorder(
        //         borderSide: BorderSide(color: Colors.teal)),
        //     focusedBorder: UnderlineInputBorder(
        //       borderSide:
        //           BorderSide(color: Color(0xFF80CBC4)), //Colors.teal[200]
        //     ),
        //   ),
        //   keyboardType: TextInputType.text,
        //   validator: validatepatientName,
        //   onSaved: (String value) {
        //     _formData['Patient Name'] = value;
        //   },
        // ),
        // new TextFormField(
        //   controller: idController,
        //   autofocus: true,
        //   style: new TextStyle(
        //     color: Colors.grey,
        //     fontFamily: 'Sansation',
        //   ),
        //   decoration: const InputDecoration(
        //     labelText: 'ID Number',
        //     labelStyle: TextStyle(
        //       color: Colors.black, //Colors.teal[200]
        //     ),
        //     enabledBorder: UnderlineInputBorder(
        //         borderSide: BorderSide(color: Colors.teal)),
        //     focusedBorder: UnderlineInputBorder(
        //       borderSide:
        //           BorderSide(color: Color(0xFF80CBC4)), //Colors.teal[200]
        //     ),
        //   ),
        //   keyboardType: TextInputType.text,
        //   validator: validateIDnumber,
        //   onSaved: (String value) {
        //     _formData['IDNumber'] = value;
        //   },
        // ),
        // new TextFormField(
        //   controller: ageController,
        //   autofocus: true,
        //   style: new TextStyle(
        //     color: Colors.grey,
        //     fontFamily: 'Sansation',
        //   ),
        //   decoration: const InputDecoration(
        //     labelText: 'Age',
        //     labelStyle: TextStyle(
        //       color: Colors.black,
        //     ),
        //     enabledBorder: UnderlineInputBorder(
        //         borderSide: BorderSide(color: Colors.teal)),
        //     focusedBorder: UnderlineInputBorder(
        //       borderSide:
        //           BorderSide(color: Color(0xFF80CBC4)), //Colors.teal[200]
        //     ),
        //   ),
        //   keyboardType: TextInputType.text,
        //   validator: validateAge,
        //   onSaved: (String value) {
        //     _formData['Age'] = value;
        //   },
        // ),
        new TextFormField(
          controller: addressController,
          autofocus: true,
          style: new TextStyle(
            color: Colors.black,
            fontFamily: 'Sansation',
          ),
          decoration: const InputDecoration(
            labelText: 'Address',
            labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w500 //Colors.teal[200]
                ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color(0xFF80CBC4)), //Colors.teal[200]
            ),
          ),
          keyboardType: TextInputType.text,
          validator: validateAddress,
          onSaved: (String value) {
            _formData['Address'] = value;
          },
        ),
        new TextFormField(
          controller: mobileController,
          autofocus: true,
          style: new TextStyle(
            color: Colors.black,
            fontFamily: 'Sansation',
          ),
          decoration: const InputDecoration(
            labelText: 'Mobile',
            labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w500 //Colors.teal[200]
                ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color(0xFF80CBC4)), //Colors.teal[200]
            ),
          ),
          keyboardType: TextInputType.phone,
          validator: validateMobile,
          onSaved: (String value) {
            _formData['Mobile'] = value;
          },
        ),
        new SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RaisedButton(
            onPressed: () async {
              if (_validateInputs() && isEnabled == true) {
                setState(() {
                  isEnabled = false;
                });
                final PatientProvider patientProvider =
                    Provider.of<PatientProvider>(context, listen: false);
                // _formKey.currentState.validate();
                final Map<String, dynamic> _formData = {
                  'eventName': nameController.text,

                  'startTime':
                      '${widget.timeSlot.date}T${formated.format(DateTime.parse(widget.timeSlot.date + 'T' + widget.timeSlot.startTime + '+00:00').toLocal())}:00', //10.00==>04.30==>10.00
                  //'${widget.timeSlot.date}T${widget.timeSlot.startTime}:00',//04.30==>10.00==>04.30
                  'endTime':
                      '${widget.timeSlot.date}T${formated.format(DateTime.parse(widget.timeSlot.date + 'T' + widget.timeSlot.endTime + '+00:00').toLocal())}:00',
                  //'${widget.timeSlot.date}T${widget.timeSlot.endTime}:00',
                  'fullTitle': '${widget.timeSlot.fullTitle}',
                  'name': nameController.text,
                  //'patientName': patientController.text,
                  //'idno': idController.text,
                  //'age': ageController.text,
                  'address': addressController.text,
                  'mobile': mobileController.text,
                  'doctorname': infolistProvider.currentInfo.docName,
                  'bookingcalendar':
                      infolistProvider.currentInfo.bookingcalendar,
                  'uniqueIdentifier': _identifier,
                  'createDateTime': _now,
                };

                final Map<String, dynamic> successInfo =
                    await patientProvider.getPatient(_formData);
                print(_formData);

                if (successInfo['success']) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReceiptPage(
                              //patient: patient.currentPatient
                              )));
                } else {
                  print("something went wrong");
                }
              }
            },
            color: isEnabled == true ? Colors.teal[700] : Colors.teal[100],
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                width: 95,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Expanded(
                      Text(
                        'Conferm',
                        style: TextStyle(
                          fontSize: 16,
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
            ),
          ),
        ),
        new SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validatepatientName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateIDnumber(String value) {
    if (value.length == 0) {
      return "ID number is Required";
    } else if (value.length != 11) {
      return "ID number must 11 digits";
    }
    return null;
  }

  String validateAge(String value) {
    if (value.length == 0) {
      return "Age is Required";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateAddress(String value) {
    if (value.length == 0) {
      return "Address is Required";
    } else {
      return null;
    }
  }

  bool _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true; //data are valid - save data to out variables
    } else {
      setState(() {
        _autoValidate = true; //all data are not valid - start auto validation.
      });
      return false;
    }
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    cacheName = prefs.getString('name');
    cachePatientName = prefs.getString('patientName');
    cacheIdNo = prefs.getString('idno');
    cacheAge = prefs.getString('age');
    cacheAddress = prefs.getString('address');
    cacheMobile = prefs.getString('mobile');
    cacheBValue = prefs.getString('bValue');

    nameController.text = cacheName;
    cacheBValue == '0' ? patientController.text = cachePatientName : [];
    idController.text = cacheIdNo;
    cacheBValue == '0' ? ageController.text = cacheAge : [];
    addressController.text = cacheAddress;
    mobileController.text = cacheMobile;
  }
}
