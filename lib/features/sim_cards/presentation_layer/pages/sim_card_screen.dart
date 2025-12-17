import 'package:final_project/features/sim_cards/presentation_layer/widgets/sim_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Sims {
  final String name;
  final String svgAsset;
  final String url;

  Sims(this.name, this.svgAsset, this.url);
}

class SimCardScreen extends StatelessWidget {
  const SimCardScreen({Key? key}) : super(key: key);
  static final List<Sims> sims = [
    Sims(
      'STC',
      'assets/sim_cards/stc.svg',
      'https://www.stc.com.sa/content/stc/sa/en/personal/mobile/self-activation-sim.html',
    ),
    Sims(
      'Mobily',
      'assets/sim_cards/mobily.svg',
      'https://mobily.com.sa/web/en/personal/self-service-activation',
    ),
    Sims('Zain', 'assets/sim_cards/zain.svg', 'https://self.sa.zain.com/new//'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 238, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(240, 240, 238, 1),
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
