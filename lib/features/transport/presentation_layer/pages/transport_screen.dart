import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/features/transport/presentation_layer/widget/transport_card.dart';
import 'package:final_project/features/transport/presentation_layer/widget/transport_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/transport_cubit.dart';
import '../cubit/transport_state.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return BlocProvider(
      create: (_) => TransportCubit(),
      child: CupertinoPageScaffold(
        backgroundColor: Color(0xFFF1F1F1),
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "transport.title".tr(),
            style: GoogleFonts.cairo(
              fontWeight: .bold,
              color: Color(0xFF3D4032),
              fontSize: 25.92,
            ),
          ),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              context.pop();
            },
            child: Icon(
              isArabic ? CupertinoIcons.arrow_right : CupertinoIcons.arrow_left,
              size: 20,
              color: Color(0xffB6B6B6),
              weight: 1.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 39),
          child: SafeArea(
            child: BlocBuilder<TransportCubit, TransportState>(
              builder: (context, state) {
                if (state is TransportTabChanged) {
                  return Column(
                    children: [
                      TransportTabs(
                        currentIndex: state.index,
                        svgIcons: context.read<TransportCubit>().tabIcons,
                        svgIconsSelected: context
                            .read<TransportCubit>()
                            .tabIconsSelected,
                        labels: context.read<TransportCubit>().tabs,
                        onTap: (i) =>
                            context.read<TransportCubit>().changeTab(i),
                      ),

                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing:
                                    12,
                                childAspectRatio: 1.1,
                              ),
                          itemCount: state.data.length,
                          itemBuilder: (_, i) => TransportCard(
                            name: state.data[i]["name"],                 
                            image: state.data[i]["image"],
                            url: state.data[i]["url"],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: CupertinoActivityIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
