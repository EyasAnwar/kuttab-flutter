import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextInputType textInputType;
  final String hint;
  final double? height;
  final double? width;
  final int? minLines;
  final int? maxLines;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? enable;
  final bool readOnly;

  final Color? hintColor;
  TextAlign textAlign;
   EdgeInsetsGeometry? contentPadding= EdgeInsets.only(left: 12.w,top: 10.h,bottom: 10.h);

  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final bool obscureText;
  final TextEditingController? controller;
  final double hintSize;

  AppTextField({Key? key,
    this.contentPadding ,
    this.textAlign = TextAlign.start,
    required this.controller,
    this.textInputType = TextInputType.text,
    required this.hint,
    this.obscureText = false,
    this.height,
    this.prefixIcon,
    this.enable,
    this.hintColor,
    this.hintSize = 15, this.onChanged, this.width, this.suffixIcon, this.minLines, this.maxLines=1, this.onTap, this.readOnly = false,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        // color: AppColors.lightTextFieldColor,
        color: AppColors.lightFillFieldHintColor,


          borderRadius: BorderRadius.circular(15.h)),
      child: TextField(
          onChanged: onChanged,
          textAlign: textAlign,
          enabled: enable,
          controller: controller,
          keyboardType: textInputType,
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readOnly,
          onTap:onTap,



          decoration: InputDecoration(

            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon,
                    color: Color(
                      0xFF0D0E56,
                    ))
                : null,
            suffixIcon:suffixIcon != null
                ? Icon(suffixIcon,
                color: AppColors.mainColor)
                : null,
            hintStyle: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: hintColor),
            hintText: (hint),


            contentPadding:  EdgeInsetsDirectional.only(
              start: 10.w,
              end: 15.w,

              //bottom: 18.h,
            ),

            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none
          )),
    );
  }
}
