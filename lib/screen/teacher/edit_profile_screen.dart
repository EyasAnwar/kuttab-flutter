import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/api/api_settings.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/user.dart';
import 'package:quran/widgets/app_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  late User user;
  EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _birthOfDateController;
  late TextEditingController _levelController;
  late TextEditingController _IDCardController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.user.first_name + " " + widget.user.last_name);
    _birthOfDateController = TextEditingController(text: widget.user.birth_date);
    _levelController = TextEditingController(text: widget.user.academic);
    _IDCardController = TextEditingController(text: widget.user.mobile_number.toString());
    _addressController = TextEditingController(text: widget.user.address);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _birthOfDateController.dispose();
    _levelController.dispose();
    _IDCardController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            /** Image header **/
            Container(
                color: Color(0xFF6AC891),
                child: Image.asset('images/app_header.png')),
            /** Body **/
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      /** User image **/
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage('https://kuttab.sirius-it.dev/storage' + widget.user.image),
                            radius: 55,
                          ),
                          /** Edit user image icon **/
                          Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: Container(
                              padding: EdgeInsets.all(7),
                              width: 30.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: SvgPicture.asset(
                                'images/camera_icon.svg',
                                color: Colors.green,
                                width: 20.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      /** User name **/
                      AppTextFiled(
                          controller: _fullNameController,
                          hint: "ادخل الاسم ثلاثي",
                          icon: "images/username_icon.svg",
                          textFiledTitle: "الاسم ثلاثي"),
                      SizedBox(height: 20.h),
                      /** User birthdate **/
                      AppTextFiled(
                          controller: _birthOfDateController,
                          hint: "ادخل تاريخ الميلاد",
                          icon: "images/cake_icon.svg",
                          textFiledTitle: "تاريخ الميلاد"),
                      SizedBox(height: 20.h),
                      /** User academic **/
                      AppTextFiled(
                          controller: _levelController,
                          hint: "ادخل المستوى الدراسي",
                          icon: "images/academic_icon.svg",
                          textFiledTitle: "المستوى الدراسي"),
                      SizedBox(height: 20.h),
                      /** User ID cart **/
                      AppTextFiled(
                          controller: _IDCardController,
                          hint: "ادخل رقم الهوية",
                          icon: "images/personal_icon.svg",
                          textFiledTitle: "رقم الهوية"),
                      SizedBox(height: 20.h),
                      /** User address **/
                      AppTextFiled(
                          controller: _addressController,
                          hint: "ادخل العنوان",
                          icon: "images/location_icon.svg",
                          textFiledTitle: "العنوان بالتفاصيل"),
                      SizedBox(height: 30.h,),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {TeacherGetxController.to.updateTeacher(context: context, user: user);},
                            child: Text('حفظ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(250, 50),
                              primary: const Color(0xFF2CBC67),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {Navigator.pop(context);},
                            child: Text('الغاء', style: TextStyle(color: Colors.green, fontSize: 16.sp),),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 50),
                              primary: const Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: Colors.green)
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h,),
                    ],
                  ),
                ),
              ),
            ),
            /** Header **/
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 120.h,
                      width: 20.w,
                    ),
                    GestureDetector(
                      onTap: () {Navigator.pop(context);},
                      child: SvgPicture.asset(
                        'images/back_icon.svg',
                        color: Color(0xFFFFFFFF),
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "بيانات الطالب",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: Colors.white),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  User get user{
    User user = User();
    user.first_name = _fullNameController.text.split(' ')[0];
    user.middle_name = _fullNameController.text.split(' ')[1];
    user.last_name = _fullNameController.text.split(' ')[2];
    user.birth_date = _birthOfDateController.text;
    user.academic = _levelController.text;
    user.mobile_number = int.parse(_IDCardController.text);
    user.address = _addressController.text;
    return user;
  }

}
