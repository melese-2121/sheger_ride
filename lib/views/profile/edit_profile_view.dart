import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? countryCode;
  String? fullPhoneNumber;

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Column(
        children: [
          // Header with curved gradient
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: colorScheme.surface,
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage("assets/profile_placeholder.png"),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: MediaQuery.of(context).size.width / 2 - 70,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: pick new profile image
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.surface,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(Icons.edit, color: colorScheme.primary),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _fullNameController,
                      hint: "Full Name",
                      icon: Icons.person,
                      theme: theme,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _emailController,
                      hint: "Email",
                      icon: Icons.email,
                      theme: theme,
                    ),
                    const SizedBox(height: 16),

                    IntlPhoneField(
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon:
                            Icon(Icons.phone, color: colorScheme.onSurface),
                        hintStyle: TextStyle(color: colorScheme.onSurface),
                        filled: true,
                        fillColor: colorScheme.surfaceVariant,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      initialCountryCode: 'ET',
                      style: TextStyle(color: colorScheme.onSurface),
                      dropdownIcon:
                          Icon(Icons.arrow_drop_down, color: colorScheme.onSurface),
                      onChanged: (phone) {
                        fullPhoneNumber = phone.completeNumber;
                        countryCode = phone.countryCode;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _passwordController,
                      hint: "Password",
                      icon: Icons.lock,
                      obscureText: _obscurePassword,
                      theme: theme,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: colorScheme.onSurface,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Save button with animation
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: update user in Supabase
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [colorScheme.primary, colorScheme.secondary],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Save Changes",
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required ThemeData theme,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    final colorScheme = theme.colorScheme;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: colorScheme.onSurface),
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
        filled: true,
        fillColor: colorScheme.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return "Enter $hint";
        return null;
      },
    );
  }
}
