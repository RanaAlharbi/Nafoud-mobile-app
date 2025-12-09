import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransportCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String image;

  const TransportCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Container(
        width: 180.w,
        height: 150.h,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ClipOval(
              child: Container(
                width: 66,
                height: 67,
                color: CupertinoColors.white,
                child: SvgPicture.asset(
                  image,
                  width: 70.w,
                  height: 70.h,
                  fit: BoxFit.cover, 
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
