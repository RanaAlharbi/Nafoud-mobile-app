import 'package:final_project/features/currency_exchange/presentation_layer/widgets/currency_exchange_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(241, 241, 241, 1),
        title: Text(
          "Currency",
          style: TextStyle(
            fontWeight: .bold,
            color: Color.fromRGBO(61,64,50, 1),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/arrow_left.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(children: [CurrencyExchangeWidget()]),
          ),
        ),
      ),
    );
  }
}
