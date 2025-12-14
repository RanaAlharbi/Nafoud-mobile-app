
import 'package:final_project/features/bookmarks/presentation/cubit/bookmarks_cubit.dart';
import 'package:final_project/features/bookmarks/presentation/cubit/bookmarks_state.dart';
import 'package:final_project/features/bookmarks/presentation/widget/bookmark_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF3F5EF),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFFF3F5EF).withValues(alpha: 0.8),
        middle:  Text(
          "Bookmarks",
          style: GoogleFonts.cairo(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff3D4032),
            ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.arrow_left, color: Color(0xFFB6B6B6)),
          onPressed: () => context.pop(),
        ),
      ),

      child: SafeArea(
        child: BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            if (state is BookmarkLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }

            if (state is BookmarkError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: CupertinoColors.systemRed),
                ),
              );
            }

            if (state is BookmarkLoaded) {
              if (state.events.isEmpty) {
                return const Center(
                  child: Text(
                    "No bookmarks yet",
                    style: TextStyle(
                      color: Color(0xFF656A53),
                      fontSize: 14
                      ),
                  ),
                );
              }

              return CupertinoScrollbar(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.events.length,
                  itemBuilder: (context, index) {
                    return BookmarkCard(event: state.events[index]);
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
