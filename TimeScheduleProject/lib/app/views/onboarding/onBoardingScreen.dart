// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/controllers/introductionModuleController.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import 'package:time_planner/app/widgets/pageIndicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final IntroductionModuleController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getPageText(),
            const SizedBox(
              height: 10,
            ),
            getPageIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Get.theme.colorScheme.primary,
        onPressed: controller.onNextButtonClick,
        child: const Icon(
          FontAwesomeIcons.arrowRight,
          color: whiteColor,
        ),
      ),
    );
  }

  Widget getPageText() {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.currentPageIndex.value == 0
                  ? "Selamat Datang di Aplikasi Jadwal Kegiatan Dinas Pemuda, Olahraga, dan Pariwisata!"
                  : controller.currentPageIndex.value == 1
                      ? "Kelola Waktu dengan Mudah dan Efisien."
                      : controller.currentPageIndex.value == 2
                          ? "Tingkatkan Kedisiplinan, Raih Sukses, Prestasi Maksimal."
                          : controller.currentPageIndex.value == 3
                              ? "Selamat Datang"
                              : "",
              style: getBoldTextStyle.copyWith(
                  color: Get.theme.colorScheme.primary, fontSize: 16),
            ),
            SizedBox(
              height: 100,
              child: Text(
                controller.currentPageIndex.value == 0
                    ? "Aplikasi ini dirancang untuk membantu dalam manajemen jadwal kegiatan yang berkaitan dengan kegiatan Dinas Pemuda, Olahraga, dan Pariwisata. "
                    : controller.currentPageIndex.value == 1
                        ? "Pengembangan aplikasi ini bertujuan untuk memudahkan kemudahan dalam mengatur dan mengakses informasi terkait jadwal kegiatan yang relevan dengan bidang tersebut."
                        : controller.currentPageIndex.value == 2
                            ? "Dengan menggunakan aplikasi ini diharapkan pengguna dapat mengatur jadwal dengan lebih baik, sehingga dapat sukses dengan prestasi maksimal."
                            : controller.currentPageIndex.value == 3
                                ? "Salam Olahraga..."
                                : "",
                style: getDefaultTextStyle.copyWith(
                  color: greyColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getPageIndicator() {
    return Obx(
      () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPageIndicator(
              indicatorPosition: 0,
              currentPageIndex: controller.currentPageIndex.value,
            ),
            const SizedBox(
              width: 5,
            ),
            CustomPageIndicator(
              indicatorPosition: 1,
              currentPageIndex: controller.currentPageIndex.value,
            ),
            const SizedBox(
              width: 5,
            ),
            CustomPageIndicator(
              indicatorPosition: 2,
              currentPageIndex: controller.currentPageIndex.value,
            ),
            const SizedBox(
              width: 5,
            ),
            CustomPageIndicator(
              indicatorPosition: 3,
              currentPageIndex: controller.currentPageIndex.value,
            ),
          ],
        );
      },
    );
  }
}
