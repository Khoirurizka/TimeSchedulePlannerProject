// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';
import 'package:time_planner/app/controllers/homeModuleController.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import 'package:time_planner/app/data/theme/themeService.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/customBackButton.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final AuthenticationModuleController authenticationModuleController =
      Get.find();
  final HomeModuleController homeModuleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 32, 77, 135),
                    Color.fromARGB(255, 111, 237, 251),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          FontAwesomeIcons.arrowLeft,
                          size: 15,
                          color: Colors.white,
                        ),
                      )),
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    authenticationModuleController.userModel.userName,
                    style: getBoldTextStyle.copyWith(
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    authenticationModuleController.userModel.email,
                    style: getSubtitleTextStyle.copyWith(height: .9),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    /* Text(
                      'Settings',
                      style: getBoldTextStyle.copyWith(
                        fontSize: 20,
                        color: Get.isDarkMode ? whiteColor : darkBlueColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Theme:",
                          style: getDefaultTextStyle.copyWith(
                            color: Get.isDarkMode
                                ? whiteColor.withOpacity(.8)
                                : blackColor.withOpacity(.8),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Switch(
                            value: Get.isDarkMode,
                            onChanged: (_) {
                              ThemeService().changeThemeMode();
                            },
                            activeColor: Get.theme.colorScheme.primary,
                            inactiveTrackColor: Get.theme.colorScheme.secondary,
                            inactiveThumbColor: Get.theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: greyColor,
                      height: 1,
                    ),*/
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Account',
                      style: getBoldTextStyle.copyWith(
                        fontSize: 20,
                        color: Get.isDarkMode ? whiteColor : darkBlueColor,
                      ),
                    ),
                    /*GestureDetector(
                      onTap: () {
                        homeModuleController.deleteUserData();
                      },
                      child: Text(
                        "Delete user data",
                        style: getDefaultTextStyle.copyWith(
                          color: Get.isDarkMode
                              ? darkPrimaryColor
                              : lightPrimaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),*/
                    GestureDetector(
                      onTap: () {
                        authenticationModuleController.deleteUser();
                      },
                      child: Text(
                        "Delete account",
                        style: getDefaultTextStyle.copyWith(
                          color: Color.fromARGB(255, 32, 77, 135),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: authenticationModuleController.logoutUser,
              child: Text(
                'Logout',
                style: getBoldTextStyle.copyWith(
                  color: Colors.red,
                  fontSize: 20,
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
}
