import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String textFiledTitle;
  final String icon;
  final String? suffixIcon;
  bool obscureText = false;
  Future<void> Function()? onSuffixTab;

  AppTextFiled({required this.controller,
    required this.hint,
    required this.icon,
    this.onSuffixTab,
    this.suffixIcon,
    this.obscureText = false,
    required this.textFiledTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextFiled title
        Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Colors.green,
              width: 20.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              textFiledTitle,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // Space
        SizedBox(height: 5.h),
        // TextFiled
        Container(
          height: 50.h,
          child: Center(
            child: TextField(
              obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                suffixIcon: GestureDetector(
                  onTap: onSuffixTab ?? (){},
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      suffixIcon ?? '',
                      color: Colors.green,
                    ),
                  ),
                ),
                fillColor: Colors.white,
                hintText: hint,
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFFE4E6EA).withOpacity(0.1),
                    width: 1.w,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xff2CBC67),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
