import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheger_ride/services/supabase_service.dart' show SupabaseService;
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends StateNotifier<AsyncValue<User?>> {
  final SupabaseService _service;

  AuthController(this._service) : super(const AsyncValue.data(null));

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
}
