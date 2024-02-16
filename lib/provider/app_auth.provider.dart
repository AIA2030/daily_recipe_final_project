
import 'dart:io';
import 'package:daily_recipes_final/pages/login_pages/register.dart';
import 'package:daily_recipes_final/pages/login_pages/sign_in.dart';
import 'package:daily_recipes_final/pages/main_pages/login_page.dart';
import 'package:daily_recipes_final/utils/toast_message_status.dart';
import 'package:daily_recipes_final/widgets/toast_message.widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
class Utils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class AppAuthProvider extends ChangeNotifier {
  String? _userName;
  String? get userName => _userName;
  String? _profileImageUrl;
  String? get profileImageUrl => _profileImageUrl;

  GlobalKey<FormState>? formKey;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? nameController;
  bool obsecureText = true;

  void providrInit() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  void providerDispose() {
    formKey = null;
    emailController = null;
    passwordController = null;
    nameController = null;
    obsecureText = false;
  }

  void toggleObsecure() {
    obsecureText = !obsecureText;
    notifyListeners();
  }

  void openRegisterPage(BuildContext context) {
    providerDispose();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  void openLoginPage(BuildContext context) {
    providerDispose();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const SignInPage()));
  }

  Future<void> logIn(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        OverlayLoadingProgress.start();
        var credentials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController!.text,
            password: passwordController!.text);


        if (credentials.user != null) {
          updateUserDisplayName(credentials.user!.displayName ?? "Default Username", context);
          OverlayLoadingProgress.stop();
          providerDispose();
          OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'You Login Successfully',
              toastMessageStatus: ToastMessageStatus.success,
            ),
          );

          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        }

        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();

      if (e.code == 'user-not-found') {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'User not found',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'wrong-password') {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'Wrong password provided for that user.',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'user-disabled') {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'This email account was disabled',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'invalid-credential') {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'Invalid credential',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'General Error',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(textMessage: 'General Error $e');
    }
  }

  Future<void> register(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        OverlayLoadingProgress.start();
        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailController!.text,
            password: passwordController!.text);

        if (credentials.user != null) {
          await credentials.user?.updateDisplayName(nameController!.text);
          updateUserDisplayName(nameController!.text, context);
          await FirebaseFirestore.instance.collection('users').doc(credentials.user!.uid).set({
            'displayName': nameController!.text,
            'email': emailController!.text,
            "profileImageUrl":'',
          });
          OverlayLoadingProgress.stop();
          providerDispose();
          OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'You Login Successfully',
              toastMessageStatus: ToastMessageStatus.success,
            ),
          );
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        }
        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();

      if (e.code == 'user-not-found') {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'User not found',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'wrong-password') {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'Wrong password provided for that user.',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == "user-disabled") {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'This email account was disabled',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == "invalid-credential") {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'Invalid credential',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'General Error',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(textMessage: 'General Error $e');
    }
  }


  void setUserName(String name) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'displayName': name});
        _userName = name;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating username: $e');
    }
  }

  void setUserImage(String newImageFile) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(newImageFile);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'profileImageUrl': newImageFile});
        _userName = newImageFile;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating username: $e');
    }
  }


  void updateUserDisplayName(String newName, BuildContext context) {
    try {
      Provider.of<AppAuthProvider>(context, listen: false).setUserName(newName);
    } catch (e) {
      print('Error updating user display name: $e');
    }
  }

  void updateUserDisplayImage(String newImageUrl, BuildContext context) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'profileImageUrl': newImageUrl});

        _profileImageUrl = newImageUrl;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating user profile image: $e');
    }
  }



  Future<void> updateUserData({
    required String newName,
    required File? newImageFile,

  }) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (newName.isNotEmpty) {
          await user.updateDisplayName(newName);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'displayName': newName});
        }
        notifyListeners();
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(textMessage: 'General Error $e');
    }
  }

  Future<void> uploadProfileImage(File imageFile, BuildContext context) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String imageName = 'profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference storageReference = FirebaseStorage.instance.ref().child(imageName);
        await storageReference.putFile(imageFile);
        String downloadUrl = await storageReference.getDownloadURL();

        updateUserDisplayImage(downloadUrl, context); // Update profile image URL

        notifyListeners();
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(textMessage: 'General Error $e');
    }
  }

  Future<void> resetPass(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController!.text.trim(),
      );

      Navigator.of(context).popUntil((route) => route.isFirst);
      Utils.showSnackBar(context, 'Password Reset Email Sent');
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(context, e.message ?? 'An error occurred');
    } catch (e) {
      print('General Error: $e');
      Utils.showSnackBar(context, 'General Error: $e');
    }
  }


  void signOut(BuildContext context) async {
    OverlayLoadingProgress.start();
    await Future.delayed(const Duration(seconds: 1));
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LogInPage()),
            (route) => false,
      );
    }
    OverlayLoadingProgress.stop();
  }
}
