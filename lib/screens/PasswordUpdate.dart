import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitfeet/Controllers/UpdateUserProfile.dart';
import 'package:fitfeet/Widgets/background-image.dart';
import 'package:fitfeet/staticFactory.dart';
import '../palette.dart';

class PasswordUpdatePage extends StatefulWidget {
  @override
  _PasswordUpdatePageState createState() => _PasswordUpdatePageState();
}

class _PasswordUpdatePageState extends State<PasswordUpdatePage> {
  var _formKey = GlobalKey<FormState>();

  final cfmPasswordController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> passwordResultDialog(BuildContext context, [bool pass, String msg]) async {
    if(pass){
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
                            Text('Password updated',
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
    else{
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
                              'Update',
                              style: kHeading,
                            ),
                          ),
                          Center(
                            child: Text(
                              'Password',
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text('Enter New Password:',
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
                                        Text('Re-Enter New Password',
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
                                      child: TextButton(onPressed: () {
                                        setState(() async {
                                          if (_formKey.currentState.validate()) {
                                            UpdateUserProfileController contr = new UpdateUserProfileController();
                                            List result = await contr.changePassword(passwordController.text.trim());
                                            await passwordResultDialog(context, result[0], result[1]);
                                            return Navigator.pushNamed(context, '/home');
                                          }
                                          // return Navigator.pushNamed(context, '/home');
                                        });
                                        return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text("hi"),
                                            );
                                          },
                                        );
                                      },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Text('Update',
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