import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              color: Color(0xFF6AC891),
              child: Image.asset('images/app_header.png')),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              width: double.infinity,
              height: 680.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    Container(
                      child: Text(
                        'الحماية والخصوصيه',
                        style: TextStyle(
                          color: Color(0xff103E1C),
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      '''   هذا النص هو مثال لنص يمكن ان يستبدل في نفس  المساحة ,لقد
  تم توليد هذا النص من مولد النص العربي حيث يمكنك ان تولد مثل
  الحروف التي يولدها التطبيق              ''',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.sp,
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
                    height: 100.h,
                    width: 20.w,
                  ),
                  SvgPicture.asset(
                    'images/back_icon.svg',
                    color: Color(0xFFFFFFFF),
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 135.w,
                  ),
                  Center(
                      child: Text(
                    "حسابي",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Colors.white),
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
