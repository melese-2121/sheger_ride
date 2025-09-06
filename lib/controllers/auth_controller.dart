import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheger_ride/services/supabase_service.dart' show SupabaseService;
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends StateNotifier<AsyncValue<User?>> {
  final SupabaseService _service;

  AuthController(this._service) : super(const AsyncValue.data(null)) {
    _checkAuth();
  }

  void _checkAuth() {
    final session = _service.client.auth.currentSession;
    if (session != null) {
      state = AsyncValue.data(session.user);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String countryCode,
  }) async {
    state = const AsyncValue.loading();
    try {
      final user = await _service.signUp(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        countryCode: countryCode,
      );
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final user = await _service.login(
        email: email,
        password: password,
      );
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

Future<void> logout() async {
  await _service.client.auth.signOut();
  state = const AsyncValue.data(null);
}
}
