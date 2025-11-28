import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain_layer/entity/country_code_entity.dart';

class CountryCodeDropdownWidget extends StatelessWidget {
  final String? selectedCode;
  final List<CountryCodeEntity> countryCodes;
  final bool isSubmitting;
  final Function(String?) onChanged;

  const CountryCodeDropdownWidget({
    super.key,
    required this.selectedCode,
    required this.countryCodes,
    required this.isSubmitting,
    required this.onChanged,
  });

  // Build country code dropdown item with cached image
  DropdownMenuItem<String> _buildCountryCodeItem(CountryCodeEntity country) {
    return DropdownMenuItem(
      value: country.code,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl: country.flagUrl,
            width: 24,
            height: 16,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 24,
              height: 16,
              color: Colors.grey[300],
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
                color: Colors.grey[300],
                child: const Icon(Icons.flag, size: 16, color: Colors.grey),
              );
            },
            fadeInDuration: const Duration(milliseconds: 300),
            fadeOutDuration: const Duration(milliseconds: 100),
          ),
          const SizedBox(width: 8),
          Text(country.dialCode),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 248, 232, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCode ?? 'sa',
          isExpanded: false,
          items: countryCodes.map(_buildCountryCodeItem).toList(),
          onChanged: isSubmitting ? null : onChanged,
        ),
      ),
    );
  }
}
