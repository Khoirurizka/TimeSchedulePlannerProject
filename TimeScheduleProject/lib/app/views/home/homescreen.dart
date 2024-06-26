import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import 'package:time_planner/app/widgets/customCircularProgressLoadingIndicator.dart';
import 'package:time_planner/app/controllers/homeModuleController.dart';
import 'package:time_planner/app/views/home/completedPage.dart';
import 'package:time_planner/app/views/home/dashboardPage.dart';

import '../../widgets/customTextField.dart';
import '../../controllers/authenticationModuleController.dart';
import 'package:time_planner/app/widgets/DropdownRole.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final HomeModuleController controller = Get.find();
  final AuthenticationModuleController authenticationModuleController =
      Get.find();
  @override
  void dispose() {
    Get.delete<HomeModuleController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 32, 77, 135),
          elevation: 0,
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            controller.currentPageIndexOnMainframe.value = value;
          },
          controller: controller.mainframePageController,
          children: [
            DashboardPage(),
            CompletedPage(),
          ],
        ),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
      floatingActionButton:
          authenticationModuleController.userModel.userRole != "Admin"
              ? const SizedBox(
                  height: 10,
                )
              : FloatingActionButton(
                  onPressed: () {
                    showAddATaskDialogPopUp(context);
                  },
                  backgroundColor: Color.fromARGB(255, 32, 77, 135),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Obx getBottomNavigationBar() {
    return Obx(() {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 255, 255, 255), //,
        unselectedItemColor: greyColor,
        backgroundColor: Color.fromARGB(255, 32, 77, 135),
        elevation: 6,
        currentIndex: controller.currentPageIndexOnMainframe.value,
        onTap: (value) {
          controller.currentPageIndexOnMainframe.value = value;
          controller.mainframePageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 400),
            curve: Curves.linearToEaseOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.checklist,
              color: controller.currentPageIndexOnMainframe.value == 0
                  ? Color.fromARGB(255, 255, 255, 255)
                  : greyColor,
            ),
            label: "Jadwal",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: controller.currentPageIndexOnMainframe.value == 1
                  ? Color.fromARGB(255, 255, 255, 255)
                  : greyColor,
            ),
            label: "Selesai",
          ),
        ],
      );
    });
  }

  void showAddATaskDialogPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Tambahkan kegiatan",
          style: getBoldTextStyle.copyWith(
            color: Color.fromARGB(255, 32, 77, 135),
            fontSize: 20,
          ),
        ),
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        content: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kepada',
                style: getBoldTextStyle.copyWith(
                  color: Color.fromARGB(255, 32, 77, 135),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              DropdownRole(
                TEC: controller.toRoleTEC,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Judul',
                style: getBoldTextStyle.copyWith(
                  color: Color.fromARGB(255, 32, 77, 135),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                TEC: controller.addATaskTitleTEC,
                hint: "Masukkan judul",
                textInputType: TextInputType.text,
                maxLines: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Diskripsi',
                style: getBoldTextStyle.copyWith(
                  color: Color.fromARGB(255, 32, 77, 135),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                TEC: controller.addATaskDescriptionTEC,
                hint: "Masukkan diskripsi",
                textInputType: TextInputType.text,
                maxLines: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Tanggal/Waktu',
                style: getBoldTextStyle.copyWith(
                  color: Color.fromARGB(255, 32, 77, 135),
                ),
              ),
              Obx(() {
                return controller.showSelectedDate.value
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('EEEE, d MMMM y HH:mm', "id_ID")
                                    .format(controller.selectedEventDate.value),
                                style: getDefaultTextStyle.copyWith(
                                  color: Get.isDarkMode
                                      ? whiteColor.withOpacity(.6)
                                      : blackColor.withOpacity(.6),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.showSelectedDate.value = false;
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Get.theme.colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /*GestureDetector(
                                onTap: () {
                                  controller.selectedEventDate.value =
                                      DateTime.now();
                                  controller.showSelectedDate.value = true;
                                },
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromARGB(255, 32, 77, 135),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Hari ini",
                                    style: getBoldTextStyle,
                                  ),
                                ),
                              ),*/
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.selectDate(context);
                                },
                                child: Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromARGB(255, 32, 77, 135),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Pilih tanggal/waktu",
                                    style: getBoldTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
              }),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
              alignment: Alignment.center,
              child: Text(
                'Batal',
                style: getBoldTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Obx(() {
            return GestureDetector(
              onTap: controller.saveATask,
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 52, 204, 111),
                ),
                alignment: Alignment.center,
                child: controller.showLoadingAnimationInAddATaskPopup.value
                    ? const CustomCircularProgressLoadingIndicator()
                    : Text(
                        'Simpan',
                        style: getBoldTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
