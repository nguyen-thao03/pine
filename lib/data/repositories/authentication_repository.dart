import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pine_admin_panel/routes/routes.dart';
import 'package:pine_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:pine_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:pine_admin_panel/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Firebase Auth Instance
  final _auth = FirebaseAuth.instance;

  // Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  // Get IsAuthenticated User
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady() {
    _auth.setPersistence(Persistence.LOCAL);
  }

  // Function to determine the relevant screen and redirect accordingly

  void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      final userDoc = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          String role = userData['Role'] ?? 'user';
          GetStorage().write('Role', role);
          if (role == 'admin') {
            Get.offAllNamed(PRoutes.dashboard);
          } else if (role == 'staff') {
            Get.offAllNamed(PRoutes.staffDashboard);
          } else {
            Get.offAllNamed(PRoutes.login);
          }
        }
      }
    } else {
      Get.offAllNamed(PRoutes.login);
    }
  }


  // LOGIN
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final userId = userCredential.user?.uid;
      if (userId != null) {
        final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
        if (userDoc.exists) {
          final userData = userDoc.data();
          if (userData != null) {
            String role = userData['Role'] ?? 'user';
            print("User role: $role");
            GetStorage().write('Role', role);
          }
        }
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw PFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw PFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const PFormatException();
    } on PlatformException catch (e) {
      throw PPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã có lỗi xảy ra. Vui lòng thử lại';
    }
  }


  // REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw PFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw PFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const PFormatException();
    } on PlatformException catch (e) {
      throw PPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã có lỗi xảy ra. Vui lòng thử lại';
    }
  }

  // REGISTER USER BY ADMIN

  // EMAIL VERIFICATION

  // FORGOT PASSWORD

  // RE AUTHENTICATE USER

  // LOGOUT USER
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(PRoutes.login);
      GetStorage().remove('activeItem');
    } on FirebaseAuthException catch (e) {
      throw PFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw PFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const PFormatException();
    } on PlatformException catch (e) {
      throw PPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã có lỗi xảy ra. Vui lòng thử lại';
    }
  }

  // DELETE USER
}
