import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
              height: 680.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 280.h,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 90,),
                      child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset('images/kottab_logo.svg',color: Colors.green,)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child:   Text('تطبيق كتاب',style: TextStyle(
                      color: Color(0xff103E1C),
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                    ),

                      textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50,left: 7,right: 7),
                    child: Text('''   هذا النص هو مثال لنص يمكن ان يستبدل في نفس  المساحة ,لقد
  تم توليد هذا النص من مولد النص العربي حيث يمكنك ان تولد مثل
                              الحروف التي يولدها التطبيق    ''',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.sp,
                    ),),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 120.h,
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
                        "حول التطبيق",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: Colors.white),
                      )),
                  Spacer(),
                  SizedBox(width: 20.w,)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
