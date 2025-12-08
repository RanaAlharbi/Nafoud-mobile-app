import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/router.dart';

class FloatingAddButton extends StatelessWidget {
  final BuildContext providerContext;

  const FloatingAddButton({super.key, required this.providerContext});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 110,
      right: 25,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF656A53),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: CupertinoButton(
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(60),
          child: const Icon(
            CupertinoIcons.add,
            color: CupertinoColors.white,
            size: 34,
          ),
          onPressed: () {
            providerContext.push(AppRoutes.addEventScreen);
          },
        ),
      ),
    );
  }
}
