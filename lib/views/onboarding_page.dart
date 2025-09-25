import 'package:flutter/material.dart';

typedef OnboardingFinishCallback = void Function();

class OnboardingPage extends StatefulWidget {
  final OnboardingFinishCallback? onFinish;
  const OnboardingPage({super.key, this.onFinish});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardData> _pages = [
    _OnboardData(
      image: 'assets/images/sheger_logo.png',
      title: 'Welcome to Sheger Ride',
      description:
          'Your smart city ride companion. Book rides, plan routes, and explore the city with ease.',
    ),
    _OnboardData(
      image: 'assets/images/onboard_ride.png',
      title: 'Book a Ride',
      description:
          'Find a ride instantly or schedule for later. Safe, reliable, and affordable.',
    ),
    _OnboardData(
      image: 'assets/images/onboard_map.png',
      title: 'Smart Route Planner',
      description:
          'Plan your journey with real-time traffic and route suggestions.',
    ),
    _OnboardData(
      image: 'assets/images/onboard_profile.png',
      title: 'Personalized Experience',
      description:
          'Manage your profile, ride history, and preferences all in one place.',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      if (widget.onFinish != null) {
        widget.onFinish!();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, i) {
                  final data = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(data.image, height: 180),
                        const SizedBox(height: 40),
                        Text(
                          data.title,
                          style: textTheme.headlineMedium?.copyWith(
                            color: colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          data.description,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onBackground.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => _buildDot(i, colorScheme),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int i, ColorScheme colorScheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: _currentPage == i ? 18 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == i
            ? colorScheme.primary
            : colorScheme.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class _OnboardData {
  final String image;
  final String title;
  final String description;
  const _OnboardData({
    required this.image,
    required this.title,
    required this.description,
  });
}
