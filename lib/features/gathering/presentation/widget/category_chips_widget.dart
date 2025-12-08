import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/gathering_cubit.dart';

class CategoryChipsWidget extends StatelessWidget {
  final List<String> categories;
  final BuildContext providerContext;

  const CategoryChipsWidget({
    super.key,
    required this.categories,
    required this.providerContext,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GatheringCubit, GatheringState>(
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  providerContext
                      .read<GatheringCubit>()
                      .fetchEvents(category: category);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF656A53),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemCount: categories.length,
          ),
        );
      },
    );
  }
}
