import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = false;
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
                    height: 40.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child:   Row(
                      children: [
                        Text('الاشعارات',style: TextStyle(

                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width: 250.w,),

                        Switch(
                            activeColor: Colors.green,
                            value: isSwitched,

                            onChanged: (value){
                              setState(() {
                                isSwitched = value;

                              });

                            }),

                      ],
                    ),
                  ),
                  Divider(
                    indent: 0,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child:   Row(
                      children: [
                        Text('اللغه',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width: 290.w,),
                        Text('الانجليزيه',style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal
                        ),),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 0,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child:   Row(
                      children: [
                        Text('المساعده',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width: 290.w,),
                        SvgPicture.asset(
                          'images/xz.svg',
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 0,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child:   Row(
                      children: [
                        Text('الخصوصيه',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width: 277.w,),
                        SvgPicture.asset(
                          'images/xz.svg',
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 0,
                    color: Colors.grey,),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child:   Row(
                      children: [
                        Text('الاصدار',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                        Text('1.0.0',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),

                      ],
                    ),
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
                        "الاعدادات",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
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
