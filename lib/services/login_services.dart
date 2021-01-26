import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationService {
  static Future<String> signInWithEmail({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No se encontró el usuario."; // Agregar error -> usuario no encontrado
      } else if (e.code == 'wrong-password') {
        return "La password ingresada es incorrecta."; // Agregar error -> password incorrecta
      } else if (e.code == 'invalid-email') {
        return "El email ingresado no es válido."; // Agregar error -> email mal formado
      } else {
        return "Error de conexión";
      }
    } catch (e) {
      return "Error";
    }
  }

  static Future<String> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return e.toString();
    }
  }

  void logOut() {}
}
