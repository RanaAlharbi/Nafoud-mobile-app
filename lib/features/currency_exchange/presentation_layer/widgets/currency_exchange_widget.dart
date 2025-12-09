import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../cubit/currency_exchange_cubit.dart';
import 'currency_country_map_widget.dart';

class CurrencyExchangeWidget extends StatelessWidget {
  const CurrencyExchangeWidget({super.key});

  String _getFlagUrl(String currencyCode) {
    final countryCode = currencyToCountryMap[currencyCode] ?? 'sa';
    return 'https://flagcdn.com/w40/$countryCode.png';
  }

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

  Widget _buildCurrencyFlag(String currencyCode) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: _getFlagUrl(currencyCode),
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey.shade200,
            child: Center(
              child: SizedBox(
                width: 16.sp,
                height: 16.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey.shade200,
            child: Icon(Icons.flag, size: 20.sp, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CurrencyExchangeCubit>(),
      child: BlocBuilder<CurrencyExchangeCubit, CurrencyExchangeState>(
        builder: (context, state) {
          final cubit = context.read<CurrencyExchangeCubit>();

          if (state.currencies == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Amount Card
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(text: state.amount)
                              ..selection = TextSelection.collapsed(offset: state.amount.length),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                            style: TextStyle(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onTap: () {
                              // Clear the field when tapping on "0"
                              if (state.amount == '0') {
                                cubit.changeAmount('');
                              }
                            },
                            onChanged: (value) {
                              cubit.changeAmount(value);
                            },
                            onSubmitted: (value) {
                              if (value.isEmpty) {
                                cubit.changeAmount('0');
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Row(
                          children: [
                            _buildCurrencyFlag(state.fromCurrency),
                            SizedBox(width: 8.w),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: state.fromCurrency,
                                menuMaxHeight: 350.h,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                icon: SvgPicture.asset(
                                  'assets/icons/down_arrow.svg',
                                  width: 9.sp,
                                  height: 9.sp,
                                ),
                                items: state.currencies!.map((currency) {
                                  return DropdownMenuItem<String>(
                                    value: currency.currencyCode,
                                    child: Text(currency.currencyCode),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) cubit.changeFromCurrency(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Swap Button
              Center(
                child: IconButton(
                  onPressed: state.toCurrency != null ? () => cubit.swapCurrencies() : null,
                  icon: SvgPicture.asset(
                    'assets/icons/Transfer.svg',
                    width: 35.sp,
                    height: 35.sp,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Converted Amount Card
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Converted to',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            state.convertedAmount != null
                                ? _formatNumber(state.convertedAmount!)
                                : '0.00',
                            style: TextStyle(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Row(
                          children: [
                            if (state.toCurrency != null) _buildCurrencyFlag(state.toCurrency!),
                            SizedBox(width: 8.w),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: state.toCurrency,
                                hint: const Text('Select   '),
                                menuMaxHeight: 350.h,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                icon: SvgPicture.asset(
                                  'assets/icons/down_arrow.svg',
                                  width: 9.sp,
                                  height: 9.sp,
                                ),
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
                                        child: Text(currency.currencyCode),
                                      );
                                    })
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) cubit.changeToCurrency(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (state.errorMessage != null) ...[
                SizedBox(height: 16.h),
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
            ],
          );
        },
      ),
    );
  }
}
