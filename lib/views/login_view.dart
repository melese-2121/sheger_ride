import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheger_ride/controllers/auth_providers.dart';
import 'package:sheger_ride/utils/app_toast.dart';
import 'package:sheger_ride/views/dashboard_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheger_ride/views/signup_view.dart';
import 'package:sheger_ride/widgets/app_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authControllerProvider.notifier)
          .login(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (prev, next) async {
      next.whenOrNull(
        data: (user) async {
          if (user != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('is_logged_in', true);
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
            }
          }
        },
        error: (e, _) {
          AppToast.showError(context, AppToast.cleanMessage(e));
        },
      );
    });

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        color: colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "appLogo",
                  child: Image.asset('assets/icons/app_icon.png', width: 140),
                ),
                const SizedBox(height: 50),

                Text(
                  "Welcome Back 👋",
                  style: textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Login to continue your ride",
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 40),

                // Email input
                TextFormField(
                  controller: _emailController,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onBackground,
                  ),
                  decoration: _inputDecoration(context, "Email", Icons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password input
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onBackground,
                  ),
                  decoration: _inputDecoration(
                    context,
                    "Password",
                    Icons.lock,
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: colorScheme.onBackground.withOpacity(0.7),
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                AppButton(
                  label: "Login",
                  isLoading: authState.isLoading,
                  onPressed: _login,
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpPage()),
                    );
                  },
                  child: Text(
                    "Don’t have an account? Sign up",
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onBackground.withOpacity(0.7),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context,
    String hint,
    IconData icon, {
    Widget? suffix,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return InputDecoration(
      prefixIcon: Icon(icon, color: colorScheme.onBackground.withOpacity(0.7)),
      suffixIcon: suffix,
      filled: true,
      fillColor: colorScheme.surface.withOpacity(0.9),
      hintText: hint,
      hintStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.onBackground.withOpacity(0.5),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
