import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Helper {
  static void showSnackBar(
    BuildContext context, {
    required String text,
    bool error = false,
    String? actionTitle,
    Function()? onPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(

        content: Text(
           text,
          style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          ),),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        elevation: 5,

        duration: Duration(seconds: 3),
        action: actionTitle != null
            ? SnackBarAction(
                onPressed: onPressed ?? () {},
                label: actionTitle,
                textColor: Colors.yellow,
              )
            : null,
        onVisible: () {
          print('VISIBLE - SNACKBAR');
        },

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.zero,
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.zero)),
        // padding: EdgeInsets.all(15),
      ),
    );
  }
}
