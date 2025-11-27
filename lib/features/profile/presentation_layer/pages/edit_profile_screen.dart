import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../domain_layer/usecase/profile_usecase.dart';
import '../cubit/profile_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
          } else if (state is ProfileLoaded) {
            // Initialize form with current profile data
            context.read<ProfileCubit>().initializeFormForEditing(state.profile);
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
                      initialValue: formState.fullName,
                      enabled: !formState.isSubmitting,
                      decoration: _buildInputDecoration(
                        labelText: "Full name",
                        hintText: "Puerto Rico",
                        errorText: formState.validationErrors['fullName'],
                      ),
                      onChanged: (value) => cubit.updateFormField('fullName', value),
                    ),
                    const SizedBox(height: 16),

                    // Nickname/Username
                    TextFormField(
                      initialValue: formState.username,
                      enabled: !formState.isSubmitting,
                      decoration: _buildInputDecoration(
                        labelText: "Username",
                        hintText: "puerto_rico (without @)",
                        errorText: formState.validationErrors['username'],
                      ),
                      onChanged: (value) => cubit.updateFormField('username', value),
                    ),
                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      initialValue: formState.email,
                      enabled: false, // Email shouldn't be editable typically
                      decoration: _buildInputDecoration(
                        labelText: "Email",
                        hintText: "youremail@domain.com",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // Phone number with flag icon
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 248, 232, 1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          // Flag icon, change "sa" to the country the user chooses and the flag will change (in the code later on, and the default will be "sa" flag)
                          Image.network(
                            'https://flagcdn.com/w20/sa.png',
                            width: 24,
                            height: 16,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              initialValue: formState.phoneNumber,
                              enabled: !formState.isSubmitting,
                              decoration: const InputDecoration(
                                labelText: "phone number",
                                labelStyle: TextStyle(color: Colors.grey),
                                hintText: "123-456-7890",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              onChanged: (value) => cubit.updateFormField('phoneNumber', value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Country and Genre row
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF4E6),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('Country'),
                                value: formState.selectedCountry,
                                isExpanded: true,

                                // idk how we will work with it, but most likely by making a JSON file containing all contries, but idk where this fill will be
                                items: ['USA', 'UK', 'Canada', 'Saudi Arabia']
                                    .map(
                                      (country) => DropdownMenuItem(
                                        value: country,
                                        child: Text(country),
                                      ),
                                    )
                                    .toList(),
                                onChanged: formState.isSubmitting
                                    ? null
                                    : (value) => cubit.updateCountry(value),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF4E6),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('Genre'),
                                value: formState.selectedGenre,
                                isExpanded: true,
                                items: ['Male', 'Female']
                                    .map(
                                      (genre) => DropdownMenuItem(
                                        value: genre,
                                        child: Text(genre),
                                      ),
                                    )
                                    .toList(),
                                onChanged: formState.isSubmitting
                                    ? null
                                    : (value) => cubit.updateGenre(value),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Address
                    TextFormField(
                      initialValue: formState.address,
                      enabled: !formState.isSubmitting,
                      decoration: _buildInputDecoration(
                        labelText: "Address",
                        hintText: "45 New Avenue, New York",
                      ),
                      onChanged: (value) => cubit.updateFormField('address', value),
                    ),
                    const SizedBox(height: 32),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D2926),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: formState.isSubmitting
                            ? null
                            : () => cubit.validateAndSubmitForm(),
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
