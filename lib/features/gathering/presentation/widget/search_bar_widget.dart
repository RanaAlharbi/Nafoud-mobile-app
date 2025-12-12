import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/gathering_cubit.dart';
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: CupertinoTextField(
        onChanged: (text) => context.read<GatheringCubit>().search(text),
        placeholder: "Search here...",
        placeholderStyle: GoogleFonts.cairo(
          color: Color(0xFFB6B6B6),
          fontSize: 18,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        prefix: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            CupertinoIcons.search,
            color: Color(0xFF656A53),
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF656A53).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF656A53)),
        ),
      ),
    );
  }
}
