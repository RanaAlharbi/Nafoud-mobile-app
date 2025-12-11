import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:remixicon/remixicon.dart';


// Q/ Why Stateful here? 
// A/ Eng. Fahad said: "You can make (small widgets) as Stateful" + That would save us some time tweaking
class FontSizeSelectorWidget extends StatefulWidget {
  const FontSizeSelectorWidget({super.key});

  @override
  State<FontSizeSelectorWidget> createState() => _FontSizeSelectorWidgetState();
}

class _FontSizeSelectorWidgetState extends State<FontSizeSelectorWidget> {
  int _selectedFontSize = 1; // 0: small, 1: medium, 2: large

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(RemixIcons.font_size_2),
      title: Text("Font Size", style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedFontSize = 0;
              });
              // Logic here - Small Size Font Logic
            },
            child: Container(
              width: 36.w,
              height: 32.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _selectedFontSize == 0
                    ? Colors.grey.shade300
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: Color.fromRGBO(145, 145, 145, 1),
                  width: 1.5.w,
                ),
              ),
              child: Text(
                "Aa",
                style: TextStyle(
                    fontSize: 13.sp, color: Color.fromRGBO(145, 145, 145, 1)),
              ),
            ),
          ),
          Gap(4.w),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedFontSize = 1;
              });
              // Logic here - Medium Size Font Logic
            },
            child: Container(
              width: 36.w,
              height: 32.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _selectedFontSize == 1
                    ? Colors.grey.shade300
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: Color.fromRGBO(145, 145, 145, 1),
                  width: 1.5.w,
                ),
              ),
              child: Text(
                "Aa",
                style: TextStyle(
                    fontSize: 17.sp, color: Color.fromRGBO(145, 145, 145, 1)),
              ),
            ),
          ),
          Gap(4.w),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedFontSize = 2;
              });
              // Logic here - Large Size Font Logic
            },
            child: Container(
              width: 36.w,
              height: 32.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _selectedFontSize == 2
                    ? Colors.grey.shade300
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: Color.fromRGBO(145, 145, 145, 1),
                  width: 1.5.w,
                ),
              ),
              child: Text(
                "Aa",
                style: TextStyle(
                    fontSize: 20.sp, color: Color.fromRGBO(145, 145, 145, 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
