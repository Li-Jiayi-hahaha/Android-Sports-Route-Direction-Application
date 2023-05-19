import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitfeet/screens/SelectRouteScreen.dart';
import 'package:fitfeet/Widgets/MapInNavigation.dart';
import 'package:fitfeet/staticFactory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitfeet/DAO/UserProfileDAO.dart';
import 'package:fitfeet/screens/HomeScreen.dart';
import 'package:fitfeet/screens/LoginPage.dart';
import 'DAO/ExerciseRecordsDAO.dart';
import 'globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitfeet/screens/RegisterPage.dart';
import 'package:fitfeet/screens/AccountUpdate.dart';
import 'package:fitfeet/screens/PasswordUpdate.dart';
import 'package:fitfeet/screens/EmailUpdate.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Fitfeet",
      theme: ThemeData(
        canvasColor: Colors.transparent,
        textTheme: GoogleFonts.josefinSansTextTheme(Theme.of(context).
        textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/login' : (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/update': (context) => AccountUpdatePage(),
        '/EmailUpdate': (context) => EmailUpdatePage(),
        '/PwUpdate': (context) => PasswordUpdatePage(),
        '/inputRouteInfo': (context) => InputRouteInfo(),
        //'/navigation': (context) => MapInNavigation(),

      },
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong!');
          }
          else if (snapshot.hasData){
            InitializationController initializationController = new InitializationController();
            bool loggedIn = initializationController.isLoggedIn();
            if (loggedIn == true){
              return HomePage();
            }
            else{
              return LoginPage();
            }
            //in loading page check authentication status
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },),

    );}
}

class InitializationController{
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoggedIn(){
    User user = _auth.currentUser;
    if (user == null){
      return false;
    }
    else{
      _createUserProfile();
      return true;
    }
  }


  Future<void> _createUserProfile() async{
    UserProfileDAO userProfileDAO = StaticFactory.createUserProfileDAO();
    await userProfileDAO.getRecord();
    ExerciseRecordDAO exerciseRecordDAO = StaticFactory.createExerciseRecordDAO();
    await exerciseRecordDAO.getAllRecords();

  }
}
/*import 'package:flutter/material.dart';
import 'package:software_engineering_login/lib_UI/screens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Entities/UserProfile.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
UserProfile userProfile;*/

/*
void checkAuthenticationState() async{
  _auth
      .authStateChanges()
      .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}
*/

// Import the firebase_core plugin


/*
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}
*/

/*
class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('You have an error! ${snapshot.error.toString()}');
          return Text('Something went wrong!');
        }

        // Once complete, show your application
        else if (snapshot.connectionState == ConnectionState.done) {
          _auth
              .authStateChanges()
              .listen((User user) {
            if (user == null) {
              return LoginPage();
            }
          });
          return HomePage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        else {
          return Center(
            child:CircularProgressIndicator(),
          );
        }
      },
    );
  }
}*/
