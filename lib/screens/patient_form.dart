import 'package:doc/models/timeSlot.dart';
import 'package:doc/providers/doctorinfo.dart';
import 'package:provider/provider.dart';
import '../providers/patient.dart';
import 'package:doc/screens/receipt.dart';
import 'package:flutter/material.dart';

class PatientForm extends StatefulWidget {
  final TimeSlot timeSlot;
  PatientForm(this.timeSlot);

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  Map<String, dynamic> _formData = <String, dynamic>{};

  final TextEditingController nameController = TextEditingController();
  final TextEditingController patientController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  //  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String name;
  String patientname;
  String age;
  String phone;

  @override
  Widget build(BuildContext context) {
    final InfolistProvider infolistProvider =
        Provider.of<InfolistProvider>(context, listen: true);
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
      body: Column(
        children: <Widget>[
          // Expanded(
          //   flex: 2,
          // child:
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
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(17.0, 0, 8.0, 0),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal[200])),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Date : ',
                            style: TextStyle(
                              fontFamily: 'Sansation',
                              color: Colors.teal[200],
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            '${widget.timeSlot.date}', //set date
                            style: TextStyle(
                              fontFamily: 'Sansation',
                              color: Colors.teal[100],
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
                        border: Border.all(color: Colors.teal[200])),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Time : ',
                            style: TextStyle(
                              fontFamily: 'Sansation',
                              color: Colors.teal[200],
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            '${widget.timeSlot.startTime}', //set time
                            style: TextStyle(
                              fontFamily: 'Sansation',
                              color: Colors.teal[100],
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
                        Colors.teal[900],
                        Colors.black,
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Please complete the form below',
                              style: TextStyle(
                                  color: Colors.red[400],
                                  fontFamily: 'Louis',
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
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
    // FocusNode myFocusNode = new FocusNode();
    return new Column(
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Who make the reservation?'.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Sansation',
                  color: Colors.teal[200],
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )),
        new TextFormField(
          controller: nameController,
          autofocus: true,
          style: new TextStyle(
            color: Colors.white,
            fontFamily: 'Sansation',
          ),
          decoration: const InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Color(0xFFE0F2F1), //Colors.teal[200]
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color(0xFF80CBC4)), //Colors.teal[200]
            ),
          ),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String value) {
            _formData['Name'] = value;
          },
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Please enter patient details below.'.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Sansation',
                  color: Colors.teal[200],
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )),
        new TextFormField(
          controller: patientController,
          autofocus: true,
          style: new TextStyle(
            color: Colors.white,
            fontFamily: 'Sansation',
          ),
          decoration: const InputDecoration(
            labelText: 'Patient Name',
            labelStyle: TextStyle(
              color: Color(0xFFE0F2F1), //Colors.teal[200]
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color(0xFF80CBC4)), //Colors.teal[200]
            ),
          ),
          keyboardType: TextInputType.text,
          validator: validatepatientName,
          onSaved: (String value) {
            _formData['Patient Name'] = value;
          },
        ),
        new TextFormField(
          controller: idController,
          autofocus: true,
          style: new TextStyle(
            color: Colors.white,
            fontFamily: 'Sansation',
          ),
          decoration: const InputDecoration(
            labelText: 'ID Number',
            labelStyle: TextStyle(
              color: Color(0xFFE0F2F1), //Colors.teal[200]
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color(0xFF80CBC4)), //Colors.teal[200]
            ),
          ),
          keyboardType: TextInputType.text,
          validator: validateIDnumber,
          onSaved: (String value) {
            _formData['IDNumber'] = value;
          },
        ),
        new TextFormField(
          controller: ageController,
          autofocus: true,
          style: new TextStyle(
            color: Colors.white,
            fontFamily: 'Sansation',
          ),
          decoration: const InputDecoration(
            labelText: 'Age',
            labelStyle: TextStyle(
              color: Color(0xFFE0F2F1), //Colors.teal[200]
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color(0xFF80CBC4)), //Colors.teal[200]
            ),
          ),
          keyboardType: TextInputType.text,
          validator: validateAge,
          onSaved: (String value) {
            _formData['Age'] = value;
          },
        ),
        new TextFormField(
          controller: addressController,
          autofocus: true,
          style: new TextStyle(
            color: Colors.white,
            fontFamily: 'Sansation',
          ),
          decoration: const InputDecoration(
            labelText: 'Address',
            labelStyle: TextStyle(
              color: Color(0xFFE0F2F1), //Colors.teal[200]
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
            color: Colors.white,
            fontFamily: 'Sansation',
          ),
          decoration: const InputDecoration(
            labelText: 'Mobile',
            labelStyle: TextStyle(
              color: Color(0xFFE0F2F1), //Colors.teal[200]
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
              if (_validateInputs()) {
                final PatientProvider patient =
                    Provider.of<PatientProvider>(context, listen: false);
                // _formKey.currentState.validate();
                final Map<String, dynamic> _formData = {
                  'eventName':
                      nameController.text + ': Has Booked This Time Slot',
                  'startTime':
                      '${widget.timeSlot.date}T${widget.timeSlot.startTime}:00',
                  'endTime':
                      '${widget.timeSlot.date}T${widget.timeSlot.endTime}:00',
                  'name': nameController.text,
                  'patientName': patientController.text,
                  'idno': idController.text,
                  'age': ageController.text,
                  'address': addressController.text,
                  'mobile': mobileController.text,
                };

                final Map<String, dynamic> successInfo =
                    await patient.createPatient(_formData);
                print(_formData);

                if (successInfo['success']) {
                  print(patient.currentPatient.startTime);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ReceiptPage(patient: patient.currentPatient)));
                } else {
                  print("something went wrong");
                }
              }
            },
            color: Colors.teal[700],
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                width: 80,
                child: Center(
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontFamily: 'Louis',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
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
    } else if (value.length <= 1) {
      return "Age must 2 digits";
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
}
