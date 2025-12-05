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

  DropdownMenuItem<String> _buildCountryItem(CountryCodeEntity country) {
    return DropdownMenuItem(
      value: country.code,
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: country.flagUrl,
            width: 24,
            height: 16,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 24,
              height: 16,
              color: Colors.grey,
              child: const SizedBox(
                width: 12,
                height: 12,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) {
              return Container(
                width: 24,
                height: 16,
                color: Colors.grey,
                child: const Icon(Icons.flag, size: 16, color: Colors.grey),
              );
            },
            fadeInDuration: const Duration(milliseconds: 300),
            fadeOutDuration: const Duration(milliseconds: 100),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              country.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(250, 244, 230, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: errorText != null ? Colors.red : Colors.grey,
              width: 2,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: const Text('Country'),
              value: selectedCountryCode,
              isExpanded: true,
              menuMaxHeight: 350.h,
              items: countries.map(_buildCountryItem).toList(),
              onChanged: isSubmitting ? null : onChanged,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          )
        else if (errorSpace)
          const SizedBox(height: 20),
      ],
    );
  }
}
