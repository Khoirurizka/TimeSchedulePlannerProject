import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/constants/constants.dart';
import 'package:time_planner/app/widgets/snackbar.dart';
import 'package:time_planner/app/routes/routes.dart';
import 'package:time_planner/app/views/auth/signupScreen.dart';
import 'package:time_planner/app/data/models/userModel.dart';

import '../services/authenticationFunctions.dart';

class AuthenticationModuleController {
  late UserModel userModel;

  TextEditingController loginEmailTEC = TextEditingController();
  TextEditingController loginPasswordTEC = TextEditingController();
  var showLoginButtonLoadingAnimation = false.obs;

  TextEditingController signupEmailTEC = TextEditingController();
  TextEditingController signupPasswordTEC = TextEditingController();
  TextEditingController signupUserNameTEC = TextEditingController();
  TextEditingController signupUserRoleTEC = TextEditingController();
  var showSignupButtonLoadingAnimation = false.obs;

  void onSignupOnLoginPageButtonClick() {
    Get.to(
      () => SignupScreen(),
    );
  }

  onLoginButtonClick() async {
    String email = loginEmailTEC.value.text;
    String password = loginPasswordTEC.value.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      showLoginButtonLoadingAnimation.value = true;
      await Future.delayed(waitTime);
      var result = await AuthenticationFunctions()
          .loginUser(email: email, password: password);
      if (result == "Success") {
        userModel = await AuthenticationFunctions().getUserData();
        loginEmailTEC.text = '';
        loginPasswordTEC.text = '';
        Get.offAllNamed(ROUTES.getHomeScreenRoute);
      } else {
        showCustomSnackBar(
          title: "Gagal",
          message: result.toString(),
        );
      }
      showLoginButtonLoadingAnimation.value = false;
    } else {
      showCustomSnackBar(
        title: "Gagal!",
        message: "Jangan biarkan data pengguna kosong. :(",
      );
    }
  }

  void onSignupButtonClick() async {
    String userName = signupUserNameTEC.value.text;
    String userRole = signupUserRoleTEC.value.text;
    String email = signupEmailTEC.value.text;
    String password = signupPasswordTEC.value.text;
    if (userName.isNotEmpty &&
        userRole.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      showSignupButtonLoadingAnimation.value = true;
      await Future.delayed(const Duration(seconds: 2));
      String result = await AuthenticationFunctions().signUpUser(
          userName: userName,
          userRole: userRole,
          email: email,
          password: password);
      if (result == 'Success') {
        userModel = await AuthenticationFunctions().getUserData();
        signupUserNameTEC.text =
            signupPasswordTEC.text = signupEmailTEC.text = '';
        Get.offAllNamed(ROUTES.getHomeScreenRoute);
      } else {
        showCustomSnackBar(
          title: "Error",
          message: result,
        );
      }
      showSignupButtonLoadingAnimation.value = false;
    } else {
      showCustomSnackBar(
        title: "Gagal mendaftar!!",
        message: "Jangan biarkan data pengguna kosong. :(",
      );
    }
  }

  void logoutUser() {
    FirebaseAuth.instance.signOut();
    Get.offAllNamed(ROUTES.getLoginScreenRoute);
  }

  void deleteUser() async {
    String success = await AuthenticationFunctions().deleteUser();
    if (success == "Berhasil") {
      logoutUser();
      showCustomSnackBar(
        title: "Selamat tinggal! :)",
        message: "Akun mu telah dihapus!",
      );
    }
  }
}
