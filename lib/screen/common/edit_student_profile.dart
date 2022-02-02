import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/user.dart';
import 'package:quran/widgets/app_text_field.dart';

class EditStudentProfile extends StatefulWidget {
  late User user;
  EditStudentProfile({required this.user});

  @override
  _EditStudentProfileState createState() => _EditStudentProfileState();
}

class _EditStudentProfileState extends State<EditStudentProfile> {
  late var _fullNameController;
  late var _birthOfDateController;
  late var _levelController;
  late var _IDCardController;
  late var _addressController;
  late var _teacherController;
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.user.first_name + " " + widget.user.middle_name + ' ' + widget.user.last_name);
    _birthOfDateController = TextEditingController(text: widget.user.birth_date);
    _levelController = TextEditingController(text: widget.user.academic);
    _IDCardController = TextEditingController(text: widget.user.mobile_number.toString());
    _addressController = TextEditingController(text: widget.user.address);
    _teacherController = TextEditingController(text: widget.user.address);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _birthOfDateController.dispose();
    _levelController.dispose();
    _IDCardController.dispose();
    _addressController.dispose();
    _teacherController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                color: Color(0xFF6AC891),
                child: Image.asset('images/app_header.png')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 155),
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
                      SizedBox(height: 60.h),
                      AppTextFiled(controller: _fullNameController, hint: "ادخل الاسم ثلاثي", icon: "images/username_icon.svg", textFiledTitle: "الاسم رباعي"),
                      SizedBox(height: 15.h),
                      AppTextFiled(controller: _birthOfDateController, hint: "ادخل تاريخ الميلاد", icon: "images/calendar2_icon.svg", textFiledTitle: "تاريخ الميلاد", suffixIcon: 'images/calendar2_icon.svg', onSuffixTab: (){return _selectDate(context);},),
                      SizedBox(height: 15.h),
                      AppTextFiled(controller: _levelController, hint: "ادخل المستوى الدراسي", icon: "images/school_icon.svg", textFiledTitle: "المستوى الدراسي"),
                      SizedBox(height: 15.h),
                      AppTextFiled(controller: _IDCardController, hint: "ادخل رقم الهوية", icon: "images/personal_icon.svg", textFiledTitle: "رقم الهوية"),
                      SizedBox(height: 15.h),
                      AppTextFiled(controller: _addressController, hint: "ادخل العنوان", icon: "images/location_icon.svg", textFiledTitle: "العنوان بالتفاصيل"),
                      SizedBox(height: 30.h),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {TeacherGetxController.to.updateTeacher(context: context, user: user);},
                            child: const Text('حفظ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
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
                            child: const Text('الغاء', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),),
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
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 100.h,
                      width: 20.w,
                    ),
                    GestureDetector(
                      onTap: (){Navigator.pop(context);},
                      child: SvgPicture.asset(
                        'images/back_icon.svg',
                        color: Color(0xFFFFFFFF),
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    Spacer(),
                    Center(
                        child: Text(
                          "بيانات الطالب",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: Colors.white),
                        )),
                    Spacer(),
                    SizedBox(width: 20.w,)
                  ],
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage("https://kuttab.sirius-it.dev/storage/" + widget.user.image),
                  radius: 55,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        _birthOfDateController.text = pickedDate.toString().split(' ')[0];
      });
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
    user.id = widget.user.id;
    print('iddd:' + widget.user.id.toString());
    return user;
  }

}
