// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import 'package:time_planner/app/controllers/homeModuleController.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';
import 'package:time_planner/app/services/postFunctions.dart';
import 'package:time_planner/app/data/models/taskModel.dart';
import '../widgets/customBackButton.dart';
import '../widgets/customCircularProgressLoadingIndicator.dart';

class ShowTaskDetailsScreen extends StatelessWidget {
  final TaskModel task;
  ShowTaskDetailsScreen({Key? key, required this.task}) : super(key: key);

  final AuthenticationModuleController authenticationModuleController =
      Get.find();

  final HomeModuleController homeModuleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Kegiatan",
          style: getBoldTextStyle.copyWith(
            color: Color.fromARGB(255, 10, 112, 255),
          ),
        ),
        leading: CustomBackButton(),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
        actions: authenticationModuleController.userModel.userRole != "Admin"
            ? [
                SizedBox(
                  width: 5,
                )
              ]
            : [
                IconButton(
                  onPressed: () {
                    homeModuleController.deleteTodoTask(task.toRole, task.id);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: errorColor,
                    size: 25,
                  ),
                ),
                /* Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Get.theme.colorScheme.primary,
                size: 25,
              ),
            ),
          ),*/
              ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Dispora')
            .doc('jadwal_kegiatan') //firebaseAuth.currentUser!.uid)
            .collection(task.toRole)
            .where(
              'id',
              isEqualTo: task.id,
            )
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomCircularProgressLoadingIndicator();
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              TaskModel taskModel =
                  TaskModel.fromSnap(snapshot.data!.docs[index]);
              return SizedBox(
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kepada",
                          style: getBoldTextStyle.copyWith(
                            color: Color.fromARGB(255, 10, 112, 255),
                          ),
                        ),
                        Text(
                          taskModel.toRole,
                          style: getDefaultTextStyle.copyWith(
                            color: Get.isDarkMode ? whiteColor : blackColor,
                          ),
                        ),
                        Text(
                          'Judul',
                          style: getBoldTextStyle.copyWith(
                            color: Color.fromARGB(255, 10, 112, 255),
                          ),
                        ),
                        Text(
                          taskModel.title,
                          style: getDefaultTextStyle.copyWith(
                            color: Get.isDarkMode ? whiteColor : blackColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Deskripsi',
                          style: getBoldTextStyle.copyWith(
                            color: Color.fromARGB(255, 10, 112, 255),
                          ),
                        ),
                        Text(
                          taskModel.description,
                          style: getDefaultTextStyle.copyWith(
                            color: Get.isDarkMode ? whiteColor : blackColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Tanggal/Waktu',
                          style: getBoldTextStyle.copyWith(
                            color: Color.fromARGB(255, 10, 112, 255),
                          ),
                        ),
                        Text(
                          "${DateFormat('EEEE, d MMMM y', "id_ID").format(taskModel.eventDate)}.",
                          style: getDefaultTextStyle.copyWith(
                            color: Get.isDarkMode
                                ? whiteColor.withOpacity(.6)
                                : blackColor.withOpacity(.6),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Status',
                          style: getBoldTextStyle.copyWith(
                            color: Color.fromARGB(255, 10, 112, 255),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 55,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            color: taskModel.eventDate.isAfter(DateTime.now())
                                ? Color.fromARGB(255, 10, 112, 255)
                                : Get.theme.scaffoldBackgroundColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Akan Dilaksanakan',
                            style: getBoldTextStyle.copyWith(
                              color: taskModel.eventDate.isAfter(DateTime.now())
                                  ? Get.theme.scaffoldBackgroundColor
                                  : Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        /*GestureDetector(
                          onTap: () {
                            PostingFunctions()
                                .changeTaskStatus("Pending", taskModel.id);
                          },
                          child: Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Get.theme.colorScheme.secondary,
                                width: 2,
                              ),
                              color: taskModel.status == "Pending"
                                  ? Get.theme.colorScheme.secondary
                                  : Get.theme.scaffoldBackgroundColor,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Pending',
                              style: getBoldTextStyle.copyWith(
                                color: taskModel.status == "Pending"
                                    ? Get.theme.scaffoldBackgroundColor
                                    : Get.theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),*/
                        Container(
                          height: 55,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            color: taskModel.eventDate.isBefore(DateTime.now())
                                ? Colors.green
                                : Get.theme.scaffoldBackgroundColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Dilaksanakan',
                            style: getBoldTextStyle.copyWith(
                              color:
                                  taskModel.eventDate.isBefore(DateTime.now())
                                      ? Get.theme.scaffoldBackgroundColor
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
