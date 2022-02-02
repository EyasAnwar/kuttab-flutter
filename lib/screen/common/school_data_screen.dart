import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/school.dart';

class SchoolDataScreen extends StatefulWidget {
  late School school;
  SchoolDataScreen({required School this.school});

  @override
  _SchoolDataScreenState createState() => _SchoolDataScreenState();
}

class _SchoolDataScreenState extends State<SchoolDataScreen> {
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
            padding: const EdgeInsets.only(top: 160),
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
              child: Column(
                children: [
                  SizedBox(height: 60,),
                  Text(
                    widget.school.name,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 60,),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Color(0xFFE4E6EA)),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'images/location_icon.svg',
                                  color: Colors.green,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(widget.school.address, style: TextStyle(fontSize: 17.sp, color: Color(0xFF000000)), ),
                              ],
                            ),
                            Divider(
                              indent: 1,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'images/about_icon.svg',
                                  color: Colors.green,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('نص يمكن استبداله', style: TextStyle(fontSize: 17.sp, color: Color(0xFF000000)), ),
                              ],
                            ),
                            Divider(
                              indent: 1,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'images/mobile_icon.svg',
                                  color: Colors.green,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('لا يوجد رقم جوال', style: TextStyle(fontSize: 17.sp, color: Color(0xFF000000)), ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100,
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
                  Center(
                      child: Text(
                        "المركز",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                      )),
                  Spacer(),
                  SizedBox(width: 20,)
                ],
              ),
              CircleAvatar(
                backgroundImage: NetworkImage("https://kuttab.sirius-it.dev/" + widget.school.logo),
                radius: 55,
              ),
            ],
          ),
        ],
      )
    );
  }
}
