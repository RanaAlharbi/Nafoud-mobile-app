import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  // To make the code a lot shorter & cleaner
  InputDecoration _buildInputDecoration({
    required String labelText,
    required String hintText,
  }) {
    return InputDecoration(
      hint: Text(hintText, style: TextStyle(color: Colors.grey)),
      labelText: labelText,
      floatingLabelStyle: TextStyle(color: Colors.grey),
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
    return Scaffold(
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

      body: SafeArea(
        child: Form(
          key: null, //_formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              // Full name
              TextFormField(
                controller: null, //fullNameController,
                decoration: _buildInputDecoration(
                  labelText: "Full name",
                  hintText: "Puerto Rico",
                ),
              ),
              const SizedBox(height: 16),

              // Nick name
              TextFormField(
                controller: null, // nickNameController,
                decoration: _buildInputDecoration(
                  labelText: "Nick name",
                  hintText: "puerto_rico",
                ),
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: null, //emailController,
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
                        controller: null, //phoneController,
                        decoration: const InputDecoration(
                          labelText: "phone number",
                          labelStyle: TextStyle(color: Colors.grey),
                          hintText: "123-456-7890",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        keyboardType: TextInputType.phone,
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF4E6),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text('Country'),
                          value: null, // selectedCountry,
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
                          onChanged: (value) {
                            if (value != null) {
                              // setState(() {
                              //   selectedCountry = value;
                              // });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF4E6),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text('Genre'),
                          value: null, // selectedGenre,
                          isExpanded: true,
                          items: ['Male', 'Female']
                              .map(
                                (genre) => DropdownMenuItem(
                                  value: genre,
                                  child: Text(genre),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              // setState(() {
                              //   selectedGenre = value;
                              // });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Address
              TextFormField(
                // controller: addressController,
                decoration: _buildInputDecoration(
                  labelText: "Address",
                  hintText: "45 New Avenue, New York",
                ),
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
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   // Handle submit
                    // }
                  },
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      fontSize: 19
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
