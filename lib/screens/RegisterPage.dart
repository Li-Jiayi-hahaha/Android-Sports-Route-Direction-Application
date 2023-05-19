import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitfeet/Controllers/RegistrationController.dart';
import 'package:fitfeet/Widgets/background-image.dart';
import '../palette.dart';
import '../staticFactory.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final cfmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final weightController = TextEditingController();

  String genderChoose;

  List genderList = [
    "M","F"
  ];

  DateTime _date = DateTime.now();

  Future<void> registerResultDialog(BuildContext context, String msg) async {
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
                              'Registration',
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
                              Text('Please fill in this form:',
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
                                        child: SizedBox(
                                          child: TextFormField(
                                            validator: (String value){
                                              if(value.isEmpty)
                                                return "   Enter a value";
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
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal:20.0),
                                              ),
                                              hintStyle: kBodyText,
                                            ),
                                            style: kBodyText,
                                            keyboardType: TextInputType.number,
                                            textInputAction: TextInputAction.next,
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
                                        Text('Selected Date: ${_date.toString().substring(0,10)}',
                                            style: kBodyText),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text('Enter Your Username:',
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
                                              return "   Enter a value";
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text('Enter Your E-mail:',
                                            style: kBodyText),
                                      ],
                                    ),
                                  ),

                                  //E-mail input
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
                                              return "   Enter a value";
                                            else
                                              return null;
                                          },
                                          controller:emailController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            const EdgeInsets.symmetric
                                              (vertical: 10),
                                            errorStyle: errorText,
                                            hintStyle: kBodyText,
                                          ),
                                          style: kBodyText,
                                          keyboardType: TextInputType.emailAddress,
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text('Enter Your Password:',
                                            style: kBodyText),
                                      ],
                                    ),
                                  ),

                                  //password input
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
                                              return "   Enter a value";
                                            else if(value.length < 7)
                                              return "   Password must contain \n   at least 7 characters";
                                            else
                                              return null;
                                          },
                                          controller: passwordController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            const EdgeInsets.symmetric
                                              (vertical: 10),
                                            errorStyle: errorText,
                                            hintStyle: kBodyText,
                                          ),
                                          obscureText: true,
                                          style: kBodyText,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text('Re-Enter Your Password',
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
                                              return "   Enter a value";
                                            else if(value != passwordController.text.trim())
                                              return "   Password isn't the same";
                                            else
                                              return null;
                                          },
                                          controller: cfmPasswordController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            const EdgeInsets.symmetric
                                              (vertical: 10),
                                            errorStyle: errorText,
                                            hintStyle: kBodyText,
                                          ),
                                          obscureText: true,
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
                                          color:Colors.blue,
                                          borderRadius: BorderRadius.circular(16)),
                                      child: TextButton(onPressed: () async {
                                        setState(() async {
                                          if (_formKey.currentState.validate()) {
                                            RegistrationController contr = new RegistrationController();
                                            List result = await contr.register(usernameController.text.trim(), double.tryParse(weightController.text), emailController.text.trim(), passwordController.text.trim(), genderChoose, _date.toString().substring(0,10));
                                            if(result[0]){
                                              return Navigator.pushNamed(context, '/home');
                                            }
                                            else {
                                              await registerResultDialog(
                                                  context,
                                                  result[1]);
                                            }
                                          }
                                          // return Navigator.pushNamed(context, '/home');
                                        });

                                      },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Text('Register',
                                              style: kBodyText),
                                        ),
                                      ),
                                    ),
                                    // RoundedButton(
                                    //   buttonText: 'Register',
                                    // ),
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
