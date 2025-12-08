import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/currency_exchange_cubit.dart';

class CurrencyExchangeWidget extends StatelessWidget {
  const CurrencyExchangeWidget({super.key});

  String _formatNumber(double number) {
    // Split number into integer and decimal parts
    final parts = number.toStringAsFixed(2).split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    // Add dots every 3 digits from right to left for thousands separator
    String formattedInteger = '';
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formattedInteger += '.';
      }
      formattedInteger += integerPart[i];
    }

    // Return formatted number with comma as decimal separator
    return '$formattedInteger,$decimalPart';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CurrencyExchangeCubit>(),
      child: BlocBuilder<CurrencyExchangeCubit, CurrencyExchangeState>(
        builder: (context, state) {
          final cubit = context.read<CurrencyExchangeCubit>();

          return Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      cubit.changeAmount('0');
                    } else {
                      cubit.changeAmount(value);
                    }
                  },
                ),

                SizedBox(height: 16.h),

                if (state.currencies == null)
                  const Center(child: CircularProgressIndicator())
                else
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: state.fromCurrency,
                        isExpanded: true,
                        items: state.currencies!.map((currency) {
                          return DropdownMenuItem<String>(
                            value: currency.currencyCode,
                            child: Text('${currency.currencyCode} - ${currency.currencyName}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) cubit.changeFromCurrency(value);
                        },
                      ),
                    ),
                  ),

                Center(
                  child: IconButton(
                    onPressed: state.toCurrency != null ? () => cubit.swapCurrencies() : null,
                    icon: const Icon(Icons.swap_vert),
                    color: Colors.orange,
                    iconSize: 32.sp,
                  ),
                ),

                if (state.currencies == null)
                  const Center(child: CircularProgressIndicator())
                else
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: state.toCurrency,
                        hint: const Text('Select Currency'),
                        isExpanded: true,
                        items: state.currencies!
                            .where((currency) {
                              if (state.fromCurrency == 'SAR') {
                                return currency.currencyCode != 'SAR';
                              }
                              return currency.currencyCode == 'SAR';
                            })
                            .map((currency) {
                              return DropdownMenuItem<String>(
                                value: currency.currencyCode,
                                child: Text('${currency.currencyCode} - ${currency.currencyName}'),
                              );
                            })
                            .toList(),
                        onChanged: (value) {
                          if (value != null) cubit.changeToCurrency(value);
                        },
                      ),
                    ),
                  ),

                if (state.convertedAmount != null && state.toCurrency != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${_formatNumber(double.parse(state.amount))} ${state.fromCurrency}',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8.h),
                        Icon(Icons.arrow_downward, size: 20.sp, color: Colors.orange),
                        SizedBox(height: 8.h),
                        Text(
                          '${_formatNumber(state.convertedAmount!)} ${state.toCurrency}',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (state.errorMessage != null)
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      state.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
