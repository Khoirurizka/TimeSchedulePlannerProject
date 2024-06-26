// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';

import '../../data/models/taskModel.dart';
import '../../data/theme/theme.dart';
import '../../widgets/customCircularProgressLoadingIndicator.dart';
import '../../widgets/todoCard.dart';

class CompletedPage extends StatelessWidget {
  CompletedPage({Key? key}) : super(key: key);

  final AuthenticationModuleController authenticationModuleController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: authenticationModuleController.userModel.userRole ==
                      "Admin"
                  ? [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Kegiatan kepala Dinas ',
                            style: getBoldTextStyle.copyWith(
                              color: Get.isDarkMode
                                  ? getPrimaryColor
                                  : darkBlueColor,
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Dispora')
                            .doc('jadwal_kegiatan')
                            .collection("kepala Dinas")
                            .where('eventDate', isLessThan: DateTime.now())
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CustomCircularProgressLoadingIndicator();
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Text(
                              'Belum ada kegiatan yang dilaksanakan',
                              style: getDefaultTextStyle.copyWith(
                                  color: greyColor, fontSize: 12),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemBuilder: (context, index) {
                              TaskModel taskModel = TaskModel.fromSnap(
                                  snapshot.data!.docs[index]);
                              return ToDoCard(
                                task: taskModel,
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //Secretaris
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Kegiatan Sekretaris ',
                            style: getBoldTextStyle.copyWith(
                              color: Get.isDarkMode
                                  ? getPrimaryColor
                                  : darkBlueColor,
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Dispora')
                            .doc('jadwal_kegiatan')
                            .collection("Sekretaris")
                            .where('eventDate', isLessThan: DateTime.now())
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CustomCircularProgressLoadingIndicator();
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Text(
                              'Belum ada kegiatan yang dilaksanakan',
                              style: getDefaultTextStyle.copyWith(
                                  color: greyColor, fontSize: 12),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemBuilder: (context, index) {
                              TaskModel taskModel = TaskModel.fromSnap(
                                  snapshot.data!.docs[index]);
                              return ToDoCard(
                                task: taskModel,
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //Bidang Kepemudaan
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Kegiatan Bidang Kepemudaan ',
                            style: getBoldTextStyle.copyWith(
                              color: Get.isDarkMode
                                  ? getPrimaryColor
                                  : darkBlueColor,
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Dispora')
                            .doc('jadwal_kegiatan')
                            .collection("Bidang Kepemudaan")
                            .where('eventDate', isLessThan: DateTime.now())
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CustomCircularProgressLoadingIndicator();
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Text(
                              'Belum ada kegiatan yang dilaksanakan',
                              style: getDefaultTextStyle.copyWith(
                                  color: greyColor, fontSize: 12),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemBuilder: (context, index) {
                              TaskModel taskModel = TaskModel.fromSnap(
                                  snapshot.data!.docs[index]);
                              return ToDoCard(
                                task: taskModel,
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //Bidang Keolahragaan
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Kegiatan Bidang Keolahragaan ',
                            style: getBoldTextStyle.copyWith(
                              color: Get.isDarkMode
                                  ? getPrimaryColor
                                  : darkBlueColor,
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Dispora')
                            .doc('jadwal_kegiatan')
                            .collection("Bidang Keolahragaan")
                            .where('eventDate', isLessThan: DateTime.now())
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CustomCircularProgressLoadingIndicator();
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Text(
                              'Belum ada kegiatan yang dilaksanakan',
                              style: getDefaultTextStyle.copyWith(
                                  color: greyColor, fontSize: 12),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemBuilder: (context, index) {
                              TaskModel taskModel = TaskModel.fromSnap(
                                  snapshot.data!.docs[index]);
                              return ToDoCard(
                                task: taskModel,
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //Bidang Pariwisata
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Kegiatan Bidang Pariwisata ',
                            style: getBoldTextStyle.copyWith(
                              color: Get.isDarkMode
                                  ? getPrimaryColor
                                  : darkBlueColor,
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Dispora')
                            .doc('jadwal_kegiatan')
                            .collection("Bidang Pariwisata")
                            .where('eventDate', isLessThan: DateTime.now())
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CustomCircularProgressLoadingIndicator();
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Text(
                              'Belum ada kegiatan yang dilaksanakan',
                              style: getDefaultTextStyle.copyWith(
                                  color: greyColor, fontSize: 12),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemBuilder: (context, index) {
                              TaskModel taskModel = TaskModel.fromSnap(
                                  snapshot.data!.docs[index]);
                              return ToDoCard(
                                task: taskModel,
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]
                  : [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Kegiatan Selesai',
                            style: getBoldTextStyle.copyWith(
                              color: Get.isDarkMode
                                  ? getPrimaryColor
                                  : darkBlueColor,
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Dispora')
                            .doc('jadwal_kegiatan')
                            .collection(authenticationModuleController
                                .userModel.userRole)
                            .where('eventDate', isLessThan: DateTime.now())
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CustomCircularProgressLoadingIndicator();
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Text(
                              'Belum ada kegiatan yang dilaksanakan',
                              style: getDefaultTextStyle.copyWith(
                                  color: greyColor, fontSize: 12),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemBuilder: (context, index) {
                              TaskModel taskModel = TaskModel.fromSnap(
                                  snapshot.data!.docs[index]);
                              return ToDoCard(
                                task: taskModel,
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}
