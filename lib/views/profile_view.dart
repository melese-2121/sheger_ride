import 'package:flutter/material.dart';
import 'package:sheger_ride/views/profile/edit_profile_view.dart';
import 'package:sheger_ride/views/settings/settings_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Top Profile Header with Theme
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: colorScheme.surface,
                      child: Icon(Icons.person,
                          size: 60, color: colorScheme.primary),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "John Doe",
                      style: textTheme.headlineMedium?.copyWith(color: colorScheme.onPrimary),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "johndoe@example.com",
                      style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Quick Actions Grid with Animation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildActionCard(
                      context: context,
                      icon: Icons.edit,
                      title: "Edit Profile",
                      color: colorScheme.primary,
                      delay: 200,
                        onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditProfileView(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      context: context,
                      icon: Icons.history,
                      title: "Ride History",
                      color: colorScheme.secondary,
                      delay: 400,
                      onTap: () {},
                    ),
                    _buildActionCard(
                      context: context,
                      icon: Icons.settings,
                      title: "Settings",
                      color: colorScheme.tertiary,
                      delay: 600,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsView(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      context: context,
                      icon: Icons.logout,
                      title: "Logout",
                      color: colorScheme.error,
                      delay: 800,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Floating Stats Section with Fade In
              AnimatedOpacity(
                opacity: 1,
                duration: const Duration(seconds: 1),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _StatItem(label: "Rides", value: "124"),
                      _StatItem(label: "Distance", value: "342 km"),
                      _StatItem(label: "Rating", value: "4.8"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
    required int delay,
    required VoidCallback onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: delay + 600),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurface.withOpacity(0.6)),
        ),
      ],
    );
  }
}
