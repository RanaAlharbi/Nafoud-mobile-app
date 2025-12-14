import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain_layer/entity/country_code_entity.dart';

class CountryDropdownWidget extends StatelessWidget {
  final String? selectedCountryCode;
  final List<CountryCodeEntity> countries;
  final bool isSubmitting;
  final Function(String?) onChanged;
  final String? errorText;
  final bool errorSpace;

  const CountryDropdownWidget({
    super.key,
    required this.selectedCountryCode,
    required this.countries,
    required this.isSubmitting,
    required this.onChanged,
    this.errorText,
    this.errorSpace = false,
  });

  @override
  Widget build(BuildContext context) {
    final selected = selectedCountryCode != null
        ? countries.firstWhere(
            (c) => c.code == selectedCountryCode,
            orElse: () => countries.first,
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(250, 244, 230, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: errorText != null ? Colors.red : Colors.grey,
              width: 2,
            ),
          ),
          child: PopupMenuButton<String>(
            constraints: BoxConstraints(maxHeight: 350.h),
            offset: Offset(0, 30.h),
            enabled: !isSubmitting,
            itemBuilder: (context) => countries
                .map(
                  (country) => PopupMenuItem<String>(
                    value: country.code,
                    child: Text(
                      country.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            onSelected: onChanged,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected != null) ...[
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
                  Expanded(
                    child: Text(selected.name, overflow: TextOverflow.ellipsis),
                  ),
                ] else
                  const Expanded(child: Text('Country')),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          )
        else if (errorSpace)
          const SizedBox(height: 20),
      ],
    );
  }
}
