import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class StudentReportScreen extends StatefulWidget {
  const StudentReportScreen({Key? key}) : super(key: key);

  @override
  _StudentReportScreenState createState() => _StudentReportScreenState();
}

class _StudentReportScreenState extends State<StudentReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              color: Color(0xFF6AC891),
              child: Image.asset('images/app_header.png')
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              width: double.infinity,
              height: 680,
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
                    Row(
                      children: [
                        Text(
                          'المدة',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '13/12/2001',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                'images/calendar2_icon.svg',
                                color: Colors.green,
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side:
                                BorderSide(color: Colors.grey, width: 1)),
                          ),
                        ),
                        Text('    -    '),
                        ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '13/12/2001',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                'images/calendar2_icon.svg',
                                color: Colors.green,
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side:
                                BorderSide(color: Colors.grey, width: 1)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Color(0xFFE4E6EA)),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xFFE4E6EA)),
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFF4F4F4),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "اسم الحلقة",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                                Divider(indent: 1),
                                Text(
                                  "مساعد المحفظ",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                Divider(indent: 1),
                                Text(
                                  "مساعد المحفظ",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                Divider(indent: 1),
                                Text(
                                  "مساعد المحفظ",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                Divider(indent: 1),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "عدد الطلاب",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 208,
                            child: Column(
                              children: [
                                Text(
                                  "اسم الحلقة",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                Divider(indent: 1),
                                Text(
                                  "مساعد المحفظ",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                Divider(indent: 1),
                                Text(
                                  "مساعد المحفظ",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                Divider(indent: 1),
                                Text(
                                  "مساعد المحفظ",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                Divider(indent: 1),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "0",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    height: 120,
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: (){Navigator.pop(context);},
                    child: SvgPicture.asset(
                      'images/back_icon.svg',
                      color: Color(0xFFFFFFFF),
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "تقرير مدة",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
