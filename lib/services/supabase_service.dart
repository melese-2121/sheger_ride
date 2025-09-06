import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  Future<User> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String countryCode,
    String role = 'user',
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      final user = response.user;
      if (user == null) {
        throw Exception('Signup failed. No user returned.');
      }

      await client.from('users').insert({
        'user_id': user.id,
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'country_code': countryCode,
        'created_at': DateTime.now().toIso8601String(),
      });

      return user;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }
}
