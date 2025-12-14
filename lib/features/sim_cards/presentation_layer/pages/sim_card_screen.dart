import 'package:final_project/features/sim_cards/presentation_layer/widgets/sim_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SimProvider {
  final String name;
  final String svgAsset;
  final String url;

  SimProvider(this.name, this.svgAsset, this.url);
}

class SimCardScreen extends StatelessWidget {
  const SimCardScreen({Key? key}) : super(key: key);
  static final List<SimProvider> sims = [
    SimProvider(
      'STC',
      'assets/sim_cards/Logo-4.svg',
      'https://www.stc.com.sa/',
    ),
    SimProvider(
      'Mobily',
      'assets/sim_cards/mobily.svg',
      'https://www.mobily.com.sa/',
    ),
    SimProvider(
      'Zain',
      'assets/sim_cards/zain.svg',
      'https://www.sa.zain.com/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SIM Card",
          style: TextStyle(
            fontWeight: .bold,
            color: Color.fromRGBO(30, 30, 30, 1),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/arrow_left.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: sims.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 180 / 138,
          ),
          itemBuilder: (context, index) {
            final sim = sims[index];
            return SimCardWidget(
              logoPath: sim.svgAsset,
              label: sim.name,
              redirectUrl: sim.url,
            );
          },
        ),
      ),
    );
  }
}
