// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import 'package:time_planner/app/widgets/customBackButton.dart';
import 'package:time_planner/app/widgets/customCircularProgressLoadingIndicator.dart';
import 'package:time_planner/app/widgets/customTextField.dart';
import 'package:time_planner/app/widgets/DropdownRole.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';
import 'package:time_planner/app/widgets/socialMediaButton.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final AuthenticationModuleController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Buat akun baru?",
          style: getBoldTextStyle.copyWith(
            color: Color.fromARGB(255, 29, 79, 164),
          ),
        ),
        leading: CustomBackButton(),
        backgroundColor: Color.fromARGB(255, 227, 251, 255),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 227, 251, 255),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Buat akun.",
                style: getBoldTextStyle.copyWith(
                  fontSize: 20,
                  color: Color.fromARGB(255, 29, 79, 164),
                ),
              ),
              Container(
                child: Text(
                  "Selamat datang, silahkan buat akun untuk menggunakan aplikasi ini!",
                  style: getDefaultTextStyle.copyWith(
                    color:
                        Get.isDarkMode ? greyColor : blackColor.withOpacity(.6),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              getSignupForm(),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return GestureDetector(
                  onTap: controller.onSignupButtonClick,
                  child: Container(
                    height: 55,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      border: Border.all(
                          color: Color.fromARGB(255, 29, 79, 164), width: 3),
                      color: Color.fromARGB(255, 51, 116, 201),
                    ),
                    alignment: Alignment.center,
                    child: controller.showLoginButtonLoadingAnimation.value
                        ? const CustomCircularProgressLoadingIndicator()
                        : Text(
                            'Daftar',
                            style: getBoldTextStyle,
                          ),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column getSignupForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama',
          style: getDefaultTextStyle.copyWith(
            color: Color.fromARGB(255, 29, 79, 164),
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
          TEC: controller.signupUserNameTEC,
          hint: "Masukkan nama pengguna...",
          textInputType: TextInputType.text,
          maxLines: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Sebagai',
          style: getDefaultTextStyle.copyWith(
            color: Color.fromARGB(255, 29, 79, 164),
            fontWeight: FontWeight.w800,
          ),
        ),
        DropdownRole(
          TEC: controller.signupUserRoleTEC,
        ),
        Text(
          'Alamat Email',
          style: getDefaultTextStyle.copyWith(
            color: Color.fromARGB(255, 29, 79, 164),
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
          TEC: controller.signupEmailTEC,
          hint: "Masukkan alamat email...",
          textInputType: TextInputType.text,
          maxLines: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Kata Sandi',
          style: getDefaultTextStyle.copyWith(
            color: Color.fromARGB(255, 29, 79, 164),
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
          TEC: controller.signupPasswordTEC,
          hint: "Masukkan kata sandi...",
          textInputType: TextInputType.text,
          maxLines: 1,
          isPassword: true,
        ),
      ],
    );
  }

  Column getSignupWIthSocialMediaTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Or signup using',
          style: getDefaultTextStyle.copyWith(
            color: Get.isDarkMode ? greyColor : blackColor.withOpacity(.6),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSocialMediaButtons(
              icon: FontAwesomeIcons.facebook,
              onTap: () {},
              color: darkBlueColor,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomSocialMediaButtons(
              icon: FontAwesomeIcons.google,
              onTap: () {},
              color: Colors.red,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomSocialMediaButtons(
              icon: FontAwesomeIcons.apple,
              onTap: () {},
              color: Colors.black,
            )
          ],
        )
      ],
    );
  }
}
