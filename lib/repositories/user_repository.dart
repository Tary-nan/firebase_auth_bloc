import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

const ERROR_EMAIL_ALREADY_IN_USE = "The email address is already in use by another account (:.";

class UserRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  ///
  ///CONSTRUCTOR
  ///
  UserRepository({GoogleSignIn googleSignIn,FirebaseAuth firebaseAuth}):
      _googleSignIn = googleSignIn ?? GoogleSignIn(),
      _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  ///
  /// SIGN IN GOOGLE
  /// 
   
  Future<FirebaseUser> signInWithGoogle()async{
    // get account 
    GoogleSignInAccount account = await _googleSignIn.signIn();
    print("account : $account");
    print("account : ${account.id}");
    print("account : ${account.email}");
    print("account : ${account.displayName}");

    Map<String, String> authHeader = await account.authHeaders;
    GoogleSignInAuthentication auth = await account.authentication;  

    print("account : ${authHeader.keys}");
    print("account : ${authHeader.values}");
    print("account : ${auth.accessToken}");
    print("account : ${auth.idToken}");
    print("account : ${auth.serverAuthCode}");

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );
    print("account : $credential");
    print("account : ${credential.providerId}");
    await _firebaseAuth.signInWithCredential(credential);
    final currentUser = _firebaseAuth.currentUser();
    
    return currentUser;
  }

  ///
  /// METHOD : SINGN IN
  ///
  Future<void> signInWithEmailAndPassword({String email, String password})async 
        => await _firebaseAuth.signInWithEmailAndPassword(
            email: email.trim(), 
            password: password.trim()
      );

  ///
  /// METHOD : SINGN UP
  ///
  Future<void> createUserWithEmailAndPassword({String email, String password})async {
    try{
      return await _firebaseAuth
        .createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    } on PlatformException {
      print(ERROR_EMAIL_ALREADY_IN_USE);
    }
    catch(e){
      print(e.toString());
    }

  }

    ///
    /// METHOD : SINGN OUT
    ///
    Future<void> signOut()async => 
        Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);

    ///
    /// METHOD : Is_Signed_In
    ///
    Future<bool> isSignedIn()async => await _firebaseAuth.currentUser() != null; 

    ///
    /// METHOD : GET CURRENT USER
    ///
    Future<FirebaseUser> getUser() async =>  await _firebaseAuth.currentUser();
  }



  