import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:time_planner/app/data/theme/theme.dart';

const List<String> list = <String>[
  'Admin',
  'kepala Dinas',
  'Sekretaris',
  'Bidang Kepemudaan',
  'Bidang Keolahragaan',
  'Bidang Pariwisata',
];

class DropdownRole extends StatefulWidget {
  final TextEditingController TEC;

  const DropdownRole({Key? key, required this.TEC}) : super(key: key);

  @override
  State<DropdownRole> createState() => _DropdownRoleState();
}

class _DropdownRoleState extends State<DropdownRole> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: DropdownMenu<String>(
        // menuHeight: 5,
        controller: widget.TEC,
        //width: 300,
        textStyle:
            TextStyle(color: Get.isDarkMode ? darkPrimaryColor : blackColor),
        initialSelection: list.first,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: Divider.createBorderSide(
              context,
              color: greyColor,
              width: .5,
            ),
            borderRadius: BorderRadius.circular(
              7,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: Divider.createBorderSide(
              context,
              color: Get.theme.colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(
              7,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: Divider.createBorderSide(
              context,
              color: greyColor,
              width: .5,
            ),
            borderRadius: BorderRadius.circular(
              7,
            ),
          ),
          fillColor: greyColor.withOpacity(.1),
          filled: true,
          contentPadding: const EdgeInsets.all(
            10,
          ),
        ),
        onSelected: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
