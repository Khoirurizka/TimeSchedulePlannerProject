// ignore_for_file: unused_local_variable

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/services/postFunctions.dart';
import 'dart:async';
import '../widgets/snackbar.dart';

class HomeModuleController {
  var currentPageIndexOnMainframe = 0.obs;
  PageController mainframePageController = PageController(initialPage: 0);
  TextEditingController toRoleTEC = TextEditingController();

  TextEditingController addATaskTitleTEC = TextEditingController();
  TextEditingController addATaskDescriptionTEC = TextEditingController();
  TextEditingController searchTEC = TextEditingController();
  var selectedEventDate = DateTime.now().obs;
  var showSelectedDate = false.obs;
  var showLoadingAnimationInAddATaskPopup = false.obs;
  var showSearchResults = false.obs;

  selectDate(BuildContext context) async {
    var eventDate = await showDatePicker(
        context: context,
        locale: const Locale("id", "ID"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1998),
        lastDate: DateTime(2200),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                surface: Color.fromARGB(255, 255, 255, 255),
                primary: Color.fromARGB(
                    255, 136, 190, 255), // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Color.fromARGB(255, 32, 77, 135), // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor:
                      Color.fromARGB(255, 32, 77, 135), // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
    if (eventDate != null) {
      var eventTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          Localizations.override(
            context: context,
            locale: Locale('id', 'ID'),
            child: child,
          );
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                surface: Color.fromARGB(255, 255, 255, 255),
                primary: Color.fromARGB(
                    255, 136, 190, 255), // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Color.fromARGB(255, 32, 77, 135), // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor:
                      Color.fromARGB(255, 32, 77, 135), // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (eventTime != null) {
        selectedEventDate.value = DateTime(
          eventDate.year,
          eventDate.month,
          eventDate.day,
          eventTime.hour,
          eventTime.minute,
        );
        showSelectedDate.value = true;
      }
    }
  }

  saveATask() async {
    String toRole = toRoleTEC.value.text;
    String title = addATaskTitleTEC.value.text;
    String description = addATaskDescriptionTEC.value.text;
    String status = "Active";
    if (toRole.isNotEmpty &&
        title.isNotEmpty &&
        description.isNotEmpty &&
        showSelectedDate.value == true) {
      showLoadingAnimationInAddATaskPopup.value = true;
      await Future.delayed(const Duration(seconds: 2));
      String postedSuccessfully = await PostingFunctions().addATask(
        toRole: toRole,
        title: title,
        description: description,
        eventDate: selectedEventDate.value,
        status: status,
      );
      showLoadingAnimationInAddATaskPopup.value = false;
      if (postedSuccessfully == "Success") {
        addATaskTitleTEC.text = "";
        addATaskDescriptionTEC.text = "";
        showSelectedDate.value = false;
        Get.back();
        showCustomSnackBar(
          title: "Berhasil! :)",
          message: "Jadwalmu berhasil disimpan.",
        );
      } else {
        showLoadingAnimationInAddATaskPopup.value = false;
        showCustomSnackBar(
          title: "Gagal",
          message: "Terjadi error saat menyimpan jadwalmu.",
        );
      }
    } else {
      showCustomSnackBar(
        title: "Gagal",
        message: "Tidak boleh ada data yang kosong! :(",
      );
    }
  }

  void deleteTodoTask(String toRole, String id) async {
    await PostingFunctions().deleteTodoTask(toRole, id);
    Get.back();
    showCustomSnackBar(
      title: "Kegiatan dihapus",
      message: "Kegiatan mu telah dihapus.",
    );
  }

  void clearScreenInSearchPage() {
    showSearchResults.value = false;
    searchTEC.text = '';
  }

  void deleteUserData() async {
    await PostingFunctions().deleteUserData();
    showCustomSnackBar(
        title: "Berhasil! :)", message: "Penghapusan telah berhasil");
  }
}
