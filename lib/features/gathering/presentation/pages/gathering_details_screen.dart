import 'package:final_project/core/shared/utils/share_utils.dart';
import 'package:final_project/features/gathering/presentation/widget/event_header_section.dart';
import 'package:final_project/features/gathering/presentation/widget/event_info_section.dart';
import 'package:final_project/features/gathering/presentation/widget/event_map_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/gathering_cubit.dart';

import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';

class GatheringDetailsScreen extends StatelessWidget {
  final GatheringEntity event;

  const GatheringDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    context.read<GatheringCubit>().loadParticipants(event.id!);

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          event.category,
          style:  GoogleFonts.cairo(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3D4032),
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context, "refresh"),
          child: const Icon(CupertinoIcons.arrow_left, color: Color(0xFFB6B6B6),),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.share, color: Color(0xFFB6B6B6)),
          onPressed: () => ShareUtils.shareEvent(event),
        ),
      ),

      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40,top: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventHeaderSection(event: event),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D4032),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  event.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Color(0xFF4D4D4D),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D4032),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: EventInfoSection(event: event),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: EventMapSection(event: event),
              ),

              const SizedBox(height: 30),

              Center(
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 12,
                  ),
                  color: const Color(0xFF656A53),
                  borderRadius: BorderRadius.circular(14),
                  onPressed: () =>
                      context.read<GatheringCubit>().joinEvent(event.id!),
                  child: const Text(
                    "Joining",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
