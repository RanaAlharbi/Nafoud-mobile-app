import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain_layer/entity/country_code_entity.dart';

class CountryCodeDropdownWidget extends StatelessWidget {
  final String? selectedCode;
  final List<CountryCodeEntity> countryCodes;
  final bool isSubmitting;
  final Function(String?) onChanged;
  final bool errorSpace;

  const CountryCodeDropdownWidget({
    super.key,
    required this.selectedCode,
    required this.countryCodes,
    required this.isSubmitting,
    required this.onChanged,
    this.errorSpace = false,
  });

  @override
  Widget build(BuildContext context) {
    final selected = countryCodes.firstWhere(
      (c) => c.code == (selectedCode ?? 'sa'),
      orElse: () => countryCodes.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey, width: 1.5),
          ),
          child: PopupMenuButton<String>(
            offset: Offset(0, 30.h),
            enabled: !isSubmitting,
            constraints: BoxConstraints(maxHeight: 190.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            itemBuilder: (context) => countryCodes
                .map(
                  (country) => PopupMenuItem<String>(
                    value: country.code,
                    child: Text(country.dialCode),
                  ),
                )
                .toList(),
            onSelected: onChanged,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl: selected.flagUrl,
                  width: 24,
                  height: 16,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(width: 24, height: 16, color: Colors.grey),
                  errorWidget: (context, url, error) => Container(
                    width: 24,
                    height: 16,
                    color: Colors.grey,
                    child: const Icon(Icons.flag, size: 16),
                  ),
                ),
                const SizedBox(width: 8),
                Text(selected.dialCode),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
        if (errorSpace) const SizedBox(height: 20),
      ],
    );
  }
}
