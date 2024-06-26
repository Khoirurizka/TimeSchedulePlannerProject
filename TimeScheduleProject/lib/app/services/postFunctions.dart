import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_planner/app/data/models/taskModel.dart';
import 'package:uuid/uuid.dart';
import '../controllers/authenticationModuleController.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/data/models/taskModel.dart';

class PostingFunctions {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final AuthenticationModuleController authenticationModuleController =
      Get.find();

  Future<String> addATask(
      {required String toRole,
      required String title,
      required String description,
      required DateTime eventDate,
      required String status}) async {
    try {
      String taskId = const Uuid().v1();
      TaskModel taskModel = TaskModel.name(
        id: taskId,
        toRole: toRole,
        title: title,
        description: description,
        eventDate: eventDate,
        status: status,
      );
      firebaseFirestore
          /*  .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('tasks')
          .doc(taskId)
          .set(taskModel.toJson());*/
          .collection('Dispora')
          .doc('jadwal_kegiatan') //firebaseAuth.currentUser!.uid)
          .collection(taskModel.toRole)
          .doc(taskId)
          .set(taskModel.toJson());
      /*   firebaseFirestore
          /*  .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('tasks')
          .doc(taskId)
          .set(taskModel.toJson());*/
          .collection('Dispora')
          .doc('jadwal_kegiatan') //firebaseAuth.currentUser!.uid)
          .collection("Admin")
          .doc(taskId)
          .set(taskModel.toJson());*/
      return "Success";
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return "An error occurred while trying to store your task! Please try again later.";
    }
  }

  changeTaskStatus(String status, String taskId) {
    firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId)
        .update({'status': status});
  }

  Future<void> deleteTodoTask(String toRole, String taskId) async {
    await firebaseFirestore
        .collection('Dispora')
        .doc('jadwal_kegiatan')
        .collection(toRole)
        .doc(taskId)
        .delete();
    return;
  }

  Future<void> deleteUserData() async {
    firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .get()
        .then(
      (snapshot) async {
        TaskModel tempTaskModel;
        for (var element in snapshot.docs) {
          tempTaskModel = TaskModel.fromSnap(element);
          await deleteTodoTask(tempTaskModel.toRole, tempTaskModel.id);
        }
      },
    );
  }
}
