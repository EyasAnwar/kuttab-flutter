import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:quran/getx_controller/login_getx_controller.dart';
import 'package:quran/models/login.dart';
import 'package:quran/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginGetxController _loginGetsController = Get.put(LoginGetxController());
  late var _schoolNumberController;
  late var _usernameController;
  late var _passwordController;

  @override
  void initState() {
    super.initState();
    _loginGetsController;
    _schoolNumberController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _schoolNumberController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('images/logo.png'),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 5)
                    ]
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 70.h,),
                      // Image
                      SvgPicture.asset(
                        'images/logo.svg',
                        color: Colors.green,
                        width: 170,
                      ),
                      SizedBox(height: 30.h,),
                      // Title
                      Text(
                        'أهلا بك في تطبيق كتاب',
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 22.sp,
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      // Subtitle
                      Text(
                        'سجل دخول الان ',
                        style: TextStyle(
                          color: Color(0xff2CBC67),
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        ),
                      ),
                      SizedBox(height: 10.h,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h,),
                      AppTextFiled(controller: _schoolNumberController, hint: "ادخل رقم المدرسة", icon: "images/school_icon.svg", textFiledTitle: "رقم المدرسة"),
                      SizedBox(height: 15.h,),
                      AppTextFiled(controller: _usernameController, hint: "ادخل اسم المستخدم", icon: "images/username_icon.svg", textFiledTitle: "رقم المستخدم"),
                      SizedBox(height: 15.h,),
                      AppTextFiled(controller: _passwordController, hint: "ادخل كلمة السر", icon: "images/lock_icon.svg", obscureText: true ,textFiledTitle: "كلمة السر"),
                      SizedBox(height: 30.h,),
                      // Button
                      ElevatedButton(
                        onPressed: () {LoginGetxController.to.login(context: context, login: Login(username: _schoolNumberController.text + _usernameController.text, password: _passwordController.text));},
                        child: Text('الدخول', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          primary: const Color(0xFF2CBC67),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // TextFiled
              ],
            ),
          ],
        ),
      ),
    );
  }
}
