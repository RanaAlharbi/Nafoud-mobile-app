import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/currency_exchange_cubit.dart';

class CurrencyExchangeWidget extends StatelessWidget {
  const CurrencyExchangeWidget({super.key});

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
                  key: ValueKey(state.amount),
                  controller: TextEditingController(text: state.amount)
                    ..selection = TextSelection.collapsed(offset: state.amount.length),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  ),
                  onChanged: (value) => cubit.changeAmount(value),
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

                SizedBox(height: 12.h),

                Center(
                  child: IconButton(
                    onPressed: state.toCurrency != null ? () => cubit.swapCurrencies() : null,
                    icon: const Icon(Icons.swap_vert),
                    color: Colors.orange,
                    iconSize: 32.sp,
                  ),
                ),

                SizedBox(height: 12.h),

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

                SizedBox(height: 20.h),

                if (state.convertedAmount != null && state.toCurrency != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${double.parse(state.amount).toStringAsFixed(4)} ${state.fromCurrency}',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8.h),
                        Icon(Icons.arrow_downward, size: 20.sp, color: Colors.blue),
                        SizedBox(height: 8.h),
                        Text(
                          '${state.convertedAmount!.toStringAsFixed(4)} ${state.toCurrency}',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
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
