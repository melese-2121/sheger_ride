import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';

// StateNotifier to handle auth state
class AuthController extends StateNotifier<AsyncValue<User?>> {
  final SupabaseService _service;

  AuthController(this._service) : super(const AsyncValue.data(null));

  Future<void> signUp(String email, String password, String fullName) async {
    try {
      state = const AsyncValue.loading();
      final user = await _service.signUp(email: email, password: password, fullName: fullName);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// Riverpod provider
final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
  final service = SupabaseService();
  return AuthController(service);
});
