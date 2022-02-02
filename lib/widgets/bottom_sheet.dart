import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/attendance.dart';

import 'app_text_field.dart';

class BottomSheets {
  void showThanksDialog(BuildContext context, String state) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            title: Container(
              child: Center(
                child: Text(
                  'شكرا لك , تم تأكيد $state بنجاح',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            content: Container(
              height: 50,
              child: Center(
                child: Text(
                  'هذا النص هو مثال لنص يمكن ان يستبدل في نفس المساحة',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {Navigator.pop(context);},
                child: Text(
                  'الرئيسيه',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Color(0xff2CBC67),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
