import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/router.dart';
import '../../domain_layer/entity/country_code_entity.dart';
import '../../domain_layer/usecase/profile_usecase.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/country_code_dropdown_widget.dart';
import '../widgets/country_dropdown_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  // Cache the country codes Future to prevent rebuilding
  static Future<List<CountryCodeEntity>>? _countryCodesFuture;

  // Load country codes from JSON (cached)
  Future<List<CountryCodeEntity>> _loadCountryCodes() {
    _countryCodesFuture ??= _loadCountryCodesFromAsset();
    return _countryCodesFuture!;
  }

  // Load country codes from asset
  Future<List<CountryCodeEntity>> _loadCountryCodesFromAsset() async {
    final String response = await rootBundle.loadString(
      'Assets/jsons/country_code.json',
    );
    final List<dynamic> data = json.decode(response);
    return data.map((json) => CountryCodeEntity.fromJson(json)).toList();
  }

  // To make the code a lot shorter & cleaner
  InputDecoration _buildInputDecoration({
    required String labelText,
    required String hintText,
    String? errorText,
  }) {
    return InputDecoration(
      hint: Text(hintText, style: TextStyle(color: Colors.grey)),
      labelText: labelText,
      floatingLabelStyle: TextStyle(color: Colors.grey),
      errorText: errorText,
      filled: true,
      fillColor: Color.fromRGBO(255, 248, 232, 1),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(GetIt.I.get<ProfileUsecase>())..loadProfile(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate back after successful update
            context.pop();
          } else if (state is AccountDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.orange,
              ),
            );
            // Navigate to sign-in screen after account deletion
            context.go(AppRoutes.signInScreen);
          } else if (state is ProfileLoaded) {
            // Initialize form with current profile data
            context.read<ProfileCubit>().initializeFormForEditing(
              state.profile,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: BackButton(),
            title: Text(
              "Edit profile",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            centerTitle: true,
          ),

          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is! ProfileFormState) {
                return Center(child: Text('Loading...'));
              }

              final formState = state;
              final cubit = context.read<ProfileCubit>();

              return SafeArea(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    // Full name
                    TextFormField(
                      key: const ValueKey('fullName'),
                      initialValue: formState.fullName,
                      enabled: !formState.isSubmitting,
                      decoration: _buildInputDecoration(
                        labelText: "Full name",
                        hintText: "Puerto Rico",
                        errorText: formState.validationErrors['fullName'],
                      ),
                      onChanged: (value) =>
                          cubit.updateFormField('fullName', value),
                    ),
                    const SizedBox(height: 16),

                    // Nickname/Username (non-editable)
                    TextFormField(
                      initialValue: formState.username,
                      enabled: false,
                      decoration: _buildInputDecoration(
                        labelText: "Username",
                        hintText: "puerto_rico (without @)",
                        errorText: formState.validationErrors['username'],
                      ),
                      onChanged: (value) =>
                          cubit.updateFormField('username', value),
                    ),
                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      key: const ValueKey('email'),
                      initialValue: formState.email,
                      enabled: !formState.isSubmitting,
                      decoration: _buildInputDecoration(
                        labelText: "Email",
                        hintText: "youremail@domain.com",
                        errorText: formState.validationErrors['email'],
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) =>
                          cubit.updateFormField('email', value),
                    ),
                    const SizedBox(height: 16),

                    // Country code dropdown and Phone number
                    FutureBuilder<List<CountryCodeEntity>>(
                      future: _loadCountryCodes(),
                      builder: (context, snapshot) {
                        // Show loading state while loading country codes
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Row(
                            children: [
                              // Loading placeholder for country code dropdown
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 248, 232, 1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: const SizedBox(
                                  width: 80,
                                  height: 20,
                                  child: Center(
                                    child: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  decoration: _buildInputDecoration(
                                    labelText: "Phone number",
                                    hintText: "123-456-7890",
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        final countryCodes = snapshot.data ?? [];

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Country code dropdown with flag
                            CountryCodeDropdownWidget(
                              selectedCode: formState.phoneCountryCode,
                              countryCodes: countryCodes,
                              isSubmitting: formState.isSubmitting,
                              errorSpace: formState.validationErrors['phoneNumber'] != null,
                              onChanged: (value) {
                                if (value != null) {
                                  // Find the country and get its dial code
                                  final country = countryCodes.firstWhere(
                                    (c) => c.code == value,
                                    orElse: () => countryCodes.first,
                                  );
                                  // Update both country code and dial code
                                  cubit.updateFormField(
                                    'phoneCountryCode',
                                    value,
                                  );
                                  cubit.updateFormField(
                                    'dialCode',
                                    country.dialCode,
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 12),
                            // Phone number field
                            Expanded(
                              child: TextFormField(
                                key: const ValueKey('phoneNumber'),
                                initialValue: formState.phoneNumber,
                                enabled: !formState.isSubmitting,
                                decoration: _buildInputDecoration(
                                  labelText: "Phone number",
                                  hintText: "123-456-7890",
                                  errorText:
                                      formState.validationErrors['phoneNumber'],
                                ),
                                keyboardType: TextInputType.phone,
                                onChanged: (value) =>
                                    cubit.updateFormField('phoneNumber', value),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Nationality and Gender row
                    FutureBuilder<List<CountryCodeEntity>>(
                      future: _loadCountryCodes(),
                      builder: (context, snapshot) {
                        final countries = snapshot.data ?? [];

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child:
                                  snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(250, 244, 230, 1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: const SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : CountryDropdownWidget(
                                      selectedCountryCode:
                                          formState.nationality,
                                      countries: countries,
                                      isSubmitting: formState.isSubmitting,
                                      onChanged: (value) =>
                                          cubit.updateNationality(value),
                                      errorText: formState.validationErrors['nationality'],
                                    ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(250, 244, 230, 1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: formState.validationErrors['gender'] != null
                                            ? Colors.red
                                            : Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: const Text('Gender'),
                                        value: formState.gender,
                                        isExpanded: true,
                                        items: ['Male', 'Female']
                                            .map(
                                              (gender) => DropdownMenuItem(
                                                value: gender,
                                                child: Text(gender),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: formState.isSubmitting
                                            ? null
                                            : (value) => cubit.updateGender(value),
                                      ),
                                    ),
                                  ),
                                  if (formState.validationErrors['gender'] != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, top: 8),
                                      child: Text(
                                        formState.validationErrors['gender']!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Address
                    TextFormField(
                      key: const ValueKey('address'),
                      initialValue: formState.address,
                      enabled: !formState.isSubmitting,
                      decoration: _buildInputDecoration(
                        labelText: "Address",
                        hintText: "45 New Avenue, New York",
                      ),
                      onChanged: (value) =>
                          cubit.updateFormField('address', value),
                    ),
                    const SizedBox(height: 32),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(45, 41, 38, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: formState.isSubmitting
                            ? null
                            : () => cubit.validateAndSubmitForm(
                                formState.dialCode,
                              ),
                        child: formState.isSubmitting
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'SUBMIT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  fontSize: 19,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
