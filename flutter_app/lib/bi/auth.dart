

import 'package:firebase_auth/firebase_auth.dart';

class LoginFire {

  final FirebaseAuth _auth;

  LoginFire(this._auth);

  Future<bool> //<String>
   signIn({required email , required password}) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch(e){
      return false;
    }
    
  }

}