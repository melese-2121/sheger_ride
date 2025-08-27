import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  /// Sign up a new user
  Future<User> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final user = await client.auth.signUp(
        email: email,
        password: password,
        // 'data' is the correct parameter to send extra user info
        data: {'full_name': fullName},
      );

      if (user.user == null) {
        throw Exception('Signup failed. No user returned.');
      }

      return user.user!;
    } on AuthException catch (e) {
      // Supabase auth errors
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }
}
