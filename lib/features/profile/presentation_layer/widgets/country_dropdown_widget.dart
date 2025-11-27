import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain_layer/entity/country_code_entity.dart';

class CountryDropdownWidget extends StatelessWidget {
  final String? selectedCountryCode;
  final List<CountryCodeEntity> countries;
  final bool isSubmitting;
  final Function(String?) onChanged;

  const CountryDropdownWidget({
    super.key,
    required this.selectedCountryCode,
    required this.countries,
    required this.isSubmitting,
    required this.onChanged,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF4E6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text('Country'),
          value: selectedCountryCode,
          isExpanded: true,
          items: countries.map(_buildCountryItem).toList(),
          onChanged: isSubmitting ? null : onChanged,
        ),
      ),
    );
  }
}
