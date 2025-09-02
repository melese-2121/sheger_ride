import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheger_ride/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_controller.dart';

/// Provide a single instance of SupabaseService
final supabaseServiceProvider = Provider<SupabaseService>((ref) {
  return SupabaseService();
});

/// AuthController provider
final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
  final service = ref.watch(supabaseServiceProvider);
  return AuthController(service);
});
