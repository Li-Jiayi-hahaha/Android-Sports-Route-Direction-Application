import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfeet/NonDAOBoundary/DatabaseInterface.dart';

class FirebaseDBImpl implements DatabaseInterface{



  Future<String> register(String email, String pw) async{
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: pw
      );
      return 'pass';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Creating user account failed: The password provided is too weak.";
      }
      else if (e.code == 'email-already-in-use'){
        return "Creating user account failed: The account already exists for that email.";
      }
      else{
        String formattedErrorCode = e.code.replaceAll('-',' ');
        formattedErrorCode = formattedErrorCode[0].toUpperCase();
        return "Creating user account failed: $formattedErrorCode";
      }
    }
  }
  Future<String> login(String email, String pw) async{
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: pw,
      );
      return 'pass';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Failed to sign-in: \n Account with inputted email does not exist.";
      }
      else if (e.code == 'wrong-password'){
        return "Failed to sign-in: \n Wrong password";
      }
      else{
        String formattedErrorCode = e.code.replaceAll('-',' ');
        formattedErrorCode = formattedErrorCode[0].toUpperCase();
        return 'Failed to sign-in:$formattedErrorCode';
      }
    }
  }
  Future<String> reAuthenticateUser(String email, String pw) async {
    EmailAuthCredential cred = EmailAuthProvider.credential(
        email: email, password: pw);
    try {
      await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(
          cred);
      return 'pass';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return "Failed to sign-in: Wrong password";
      }
      else {
        String formattedErrorCode = e.code.replaceAll('-',' ');
        formattedErrorCode = formattedErrorCode[0].toUpperCase();
        return "Authentication failed: $formattedErrorCode";
      }
    }
  }

  Future<String> verifyEmail() async{
    try {
      await FirebaseAuth.instance.currentUser.sendEmailVerification();
      return 'Verification email has been sent!';
    } on FirebaseAuthException catch(e){
      String formattedErrorCode = e.code.replaceAll('-',' ');
      formattedErrorCode = formattedErrorCode[0].toUpperCase();
      return "Sending verification email failed: $formattedErrorCode";
    }
  }

  Future<String> changeEmail(String email) async{
    try {
        await FirebaseAuth.instance.currentUser.updateEmail(email);
        return 'pass';
      } on FirebaseAuthException catch (e) {
       String formattedErrorCode = e.code.replaceAll('-',' ');
       formattedErrorCode = formattedErrorCode[0].toUpperCase();
        return "Email update failed: $formattedErrorCode";
    }
  }
  Future<String> changePassword(String pw) async{
    try {
      await FirebaseAuth.instance.currentUser.updatePassword(pw);
      return "pass";
    }
    on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return "Password update failed: The password provided is too weak.";
      }
      else{
      String formattedErrorCode = e.code.replaceAll('-',' ');
      formattedErrorCode = formattedErrorCode[0].toUpperCase();
      return "Password update failed: $formattedErrorCode";
      }
    }
  }
  Future<String> sendResetPasswordEmail(String email) async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        return "Failed to sent password reset email: account with inputted email does not exist.";
      }
      else{
        String formattedErrorCode = e.code.replaceAll('-',' ');
        formattedErrorCode = formattedErrorCode[0].toUpperCase();
        return "Failed to sent password reset email: $formattedErrorCode";
      }
    }
  }

  String getUID() {
    return FirebaseAuth.instance.currentUser.uid;
  }

  Future<void> signOut() async{
    return await FirebaseAuth.instance.signOut();

  }

}