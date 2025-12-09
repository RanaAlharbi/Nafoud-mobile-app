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
    return BlocProvider(
      create: (_) => TransportCubit(),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle:  Text("Transport", style: GoogleFonts.cairo(
            fontWeight: .bold,
            color: Color(0xFF3D4032),
            fontSize: 25.6
          )),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              context.pop();
            },
            child: const Icon(
              CupertinoIcons.arrow_left,
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
                final cubit = context.read<TransportCubit>();
          
                if (state is TransportTabChanged) {
                  return Column(
                    children: [
                      TransportTabs(
                        icons: cubit.icons,
                        labels: cubit.tabs,
                        currentIndex: state.index,
                        onTap: cubit.changeTab,
                      ),
          
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                childAspectRatio: 0.95,
                              ),
                          itemCount: state.data.length,
                          itemBuilder: (_, i) => TransportCard(
                            name: state.data[i]["name"],
                            subtitle: state.data[i]["subtitle"],
                            image: state.data[i]["image"],
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
