import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitfeet/Controllers/UpdateUserProfile.dart';
import 'package:fitfeet/Widgets/background-image.dart';
import '../palette.dart';
import 'package:fitfeet/staticFactory.dart';

class AccountUpdatePage extends StatefulWidget {
  @override
  _AccountUpdatePageState createState() => _AccountUpdatePageState();
}

class _AccountUpdatePageState extends State<AccountUpdatePage> {

  Future<void> detailsResultDialog(BuildContext context, String msg) async {
    return await showDialog(context: context,
        builder: (context){
          return AlertDialog(
            content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Text(msg,
                              style: kBodyTextBlack),
                        ],
                      ),
                    ),
                    //Password input
                  ],
                )),
            actions: <Widget>[
              TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              )],
          );
        });
  }

  Future<void> passwordVerificationDialog(BuildContext context, String destination) async {
    return await showDialog(context: context,
        builder: (context){
          return AlertDialog(
            content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Text('Enter Your Password:',
                              style: kBodyTextBlack),
                        ],
                      ),
                    ),
                    //Password input
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: SizedBox(
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.symmetric
                              (vertical: 10),
                            errorStyle: errorText,
                            hintStyle: kBodyTextBlack,
                          ),
                          obscureText: true,
                          style: kBodyTextBlack,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                  ],
                )),
            actions: <Widget>[
              TextButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    //if password correct
                    UpdateUserProfileController contr = new UpdateUserProfileController();
                    List result = await contr.reAuthenticateUser(passwordController.text.trim());
                    if (result[0]) {
                      setState((){
                        if (_formKey.currentState.validate()) {
                          if(destination == "password"){
                            Navigator.pushNamed(context, '/PwUpdate');
                          }
                          else if(destination == "email")
                          {
                            Navigator.pushNamed(context, '/EmailUpdate');
                          }
                        }});
                    }
                    else{
                      await passwordIncorrectDialog(context);
                      Navigator.of(context).pop();
                    }
                    //else
                  }
              )],
          );
        });
  }
  Future<void> passwordIncorrectDialog(BuildContext context) async {
    return await showDialog(context: context,
        builder: (context){
          return AlertDialog(
            content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Text('Incorrect Password',
                              style: kBodyTextBlack),
                        ],
                      ),
                    ),
                  ],
                )),
            actions: <Widget>[
              TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              )],
          );
        });
  }


  var _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final weightController = TextEditingController();
  final passwordController = TextEditingController();

  String genderChoose;

  List genderList = [
    "M","F"
  ];

  DateTime _date = DateTime.now();

  bool checkWeight(String string){
    final number = double.tryParse(string);
    if (number < 20.0 || number > 200.0){
      return true;
    }
    else{
      return false;
    }
  }

  Future<Null> _selectDate (BuildContext context) async{
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1947),
      lastDate: DateTime(2030),
    );

    if(_datePicker != null && _datePicker != _date){
      setState(() {
        _date = _datePicker;
        print(
          _date.toString(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children : [
                    Container(
                      height: 150,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'Account',
                              style: kHeading,
                            ),
                          ),
                          Center(
                            child: Text(
                              'Update',
                              style: kHeading,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric
                            (horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Choose detail to Update',
                                  style: kBodyText),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text('Gender:',
                                          style: kBodyText),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.only(left: 16, right: 16),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.white, width: 1),
                                              color: Colors.grey[600].withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: DropdownButton(
                                            hint: Text("Select Gender",
                                                style: kBodyText),
                                            dropdownColor: Colors.black,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize:44,
                                            iconEnabledColor: Colors.white,
                                            style: kBodyText,
                                            value: genderChoose,
                                            onChanged: (newValue) {
                                              print(newValue);
                                              setState(() {
                                                genderChoose = newValue;
                                              });
                                            },
                                            items: genderList.map((valueItem) {
                                              return DropdownMenuItem(
                                                value: valueItem,
                                                child: Text(valueItem),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Weight:    ',
                                          style: kBodyText),
                                      Container(
                                        width: 220,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.white, width: 1),
                                          color: Colors.grey[600].withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(16),),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                          child: SizedBox(
                                            child: TextFormField(
                                              validator: (String value){
                                                if(value.isEmpty)
                                                  return null;
                                                else if(checkWeight(value))
                                                  return "   Enter a number \n   between 20 and 200";
                                                else
                                                  return null;
                                              },
                                              controller: weightController,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets.symmetric
                                                  (vertical: 10),
                                                errorStyle: errorText,
                                                hintStyle: kBodyText,
                                              ),
                                              style: kBodyText,
                                              keyboardType: TextInputType.number,
                                              textInputAction: TextInputAction.next,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                        child: Row(
                                          children: [
                                            Text('Date Of Birth:      ',
                                                style: kBodyText),
                                          ],
                                        ),
                                      ),
                                      RaisedButton(
                                        onPressed: (){
                                          setState(() {
                                            _selectDate(context);
                                          });
                                        },
                                        color: Color(0xFFC41A3B),
                                        child: Text("Date Picker", style: TextStyle(color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text('Selected Date: ${_date.toString().substring(0,10)}'
                                            '\n\nIf Date is today date has not been selected',
                                            style: kBodyText),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text('Change Username:',
                                            style: kBodyText),
                                      ],
                                    ),
                                  ),

                                  //username input
                                  Container(
                                    width: 370,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 1),
                                      color: Colors.grey[600].withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                      child: SizedBox(
                                        child: TextFormField(
                                          validator: (String value){
                                            if(value.isEmpty)
                                              return null;
                                            else if(value.length < 3)
                                              return "   Enter more than 3 Characters";
                                            else
                                              return null;
                                          },
                                          controller: usernameController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            const EdgeInsets.symmetric
                                              (vertical: 10),
                                            errorStyle: errorText,
                                            hintStyle: kBodyText,
                                          ),
                                          style: kBodyText,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color:Colors.red,
                                          borderRadius: BorderRadius.circular(16)),
                                      child: TextButton(onPressed: () async {
                                        await passwordVerificationDialog(context, "email");
                                      },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Text('Change E-mail',
                                              style: kBodyText),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color:Colors.red,
                                          borderRadius: BorderRadius.circular(16)),
                                      child: TextButton(onPressed: () async {
                                        await passwordVerificationDialog(context, "password");
                                      },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Text('Change Password',
                                              style: kBodyText),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color:Colors.blue,
                                          borderRadius: BorderRadius.circular(16)),
                                      child: TextButton(onPressed: () {
                                        setState(() async {
                                          if (_formKey.currentState.validate()) {
                                            UpdateUserProfileController contr = new UpdateUserProfileController();
                                            List result = await contr.updateHandler(usernameController.text.trim(), genderChoose, _date.toString().substring(0,10), double.tryParse(weightController.text));
                                            await detailsResultDialog(context, result[1]);
                                            return Navigator.pushNamed(context, '/home');
                                          }
                                          // return Navigator.pushNamed(context, '/home');
                                        });
                                      },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Text('Update',
                                              style: kBodyText),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ]
                              )
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}