import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import 'package:time_planner/app/widgets/customCircularProgressLoadingIndicator.dart';
import 'package:time_planner/app/widgets/customTextField.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';
import 'package:time_planner/app/widgets/socialMediaButton.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final AuthenticationModuleController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "DINAS PEMUDA, OLAHRAGA\nDAN PARIWISATA",
              textAlign: TextAlign.center,
              style: getBoldTextStyle.copyWith(
                color: Color.fromARGB(
                    255, 12, 12, 62), // Get.theme.colorScheme.primary,
                fontSize: 20,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 108, 183, 254),
        elevation: 0,
      ),*/
      backgroundColor: Color.fromARGB(255, 227, 251, 255),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Selamat Datang,",
                      style: getBoldTextStyle.copyWith(
                        fontSize: 25,
                        color: Color.fromARGB(255, 32, 77, 135),
                      ),
                    ),
                    Text(
                      "Silahkan masuk menggunakan email atau mendaftar untuk menggunakan jadwal kegiatan Dinas Pemuda dan Olahraga.",
                      style: getDefaultTextStyle.copyWith(
                          color: Get.isDarkMode
                              ? greyColor
                              : blackColor.withOpacity(.6),
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    getLoginForm(),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Obx(() {
                        return GestureDetector(
                          onTap: controller.onLoginButtonClick,
                          child: Container(
                            height: 55,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                25,
                              ),
                              border: Border.all(
                                  color: Color.fromARGB(255, 29, 79, 164),
                                  width: 3),
                              color: Color.fromARGB(255, 51, 116, 201),
                            ),
                            alignment: Alignment.center,
                            child: controller
                                    .showLoginButtonLoadingAnimation.value
                                ? const CustomCircularProgressLoadingIndicator()
                                : Text(
                                    'Masuk',
                                    style: getBoldTextStyle,
                                  ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: controller.onSignupOnLoginPageButtonClick,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Belum memiliki akun? ",
                      style: getDefaultTextStyle.copyWith(
                        color: Get.isDarkMode
                            ? greyColor
                            : blackColor.withOpacity(.6),
                      ),
                    ),
                    TextSpan(
                      text: "Silahkan Daftar!",
                      style: getDefaultTextStyle.copyWith(
                        color: Color.fromARGB(255, 32, 77, 135),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Column getSocialMediaTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Or login with',
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

  Widget getLoginForm() {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email ',
            style: getDefaultTextStyle.copyWith(
              color: Color.fromARGB(255, 32, 77, 135),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            TEC: controller.loginEmailTEC,
            hint: "alamat email",
            textInputType: TextInputType.emailAddress,
            maxLines: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Password',
            style: getDefaultTextStyle.copyWith(
              color: Color.fromARGB(255, 32, 77, 135),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            TEC: controller.loginPasswordTEC,
            hint: "password",
            textInputType: TextInputType.emailAddress,
            maxLines: 1,
            isPassword: true,
          )
        ],
      ),
    );
  }
}
