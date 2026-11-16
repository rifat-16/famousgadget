import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/animations/animations.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class PromoBannerCarousel extends StatefulWidget {
  final VoidCallback onShopNow;

  const PromoBannerCarousel({
    super.key,
    required this.onShopNow,
  });

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  late final PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> _banners = [
    {
      'tag': 'WINTER DEAL',
      'title': 'Up to 40% Off Smart Watches',
      'image':
          'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400&auto=format&fit=crop&q=80',
      'icon': Icons.watch_rounded,
      'gradient': AppColors.bannerGradient,
    },
    {
      'tag': 'TOP AUDIO',
      'title': 'Active Noise Canceling Earbuds',
      'image':
          'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=400&auto=format&fit=crop&q=80',
      'icon': Icons.headphones_rounded,
      'gradient': const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
      ),
    },
    {
      'tag': 'HOT FLAGSHIP',
      'title': 'Next-Gen Smartphones On Sale',
      'image':
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400&auto=format&fit=crop&q=80',
      'icon': Icons.phone_android_rounded,
      'gradient': const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2E1065), Color(0xFF0F172A)],
      ),
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;
      final nextIndex = (_currentIndex + 1) % _banners.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      child: SizedBox(
        height: 168.0,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _banners.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final banner = _banners[index];
            return Container(
              decoration: BoxDecoration(
                gradient: banner['gradient'] as Gradient,
                borderRadius: AppRadius.radiusAll24,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x200B1220),
                    offset: Offset(0, 8),
                    blurRadius: 16,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(AppSpacing.s20),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.cardWhite,
                                borderRadius: AppRadius.radiusAll8,
                              ),
                              child: Text(
                                banner['tag'] as String,
                                style: AppTextStyles.badgeText.copyWith(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primaryOrange,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.s6),
                            Text(
                              banner['title'] as String,
                              style: AppTextStyles.outfitTitleSmall.copyWith(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w800,
                                color: AppColors.cardWhite,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Bounceable(
                              onTap: widget.onShopNow,
                              scaleFactor: 0.92,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s16,
                                  vertical: AppSpacing.s8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryOrange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Shop Now',
                                  style: AppTextStyles.badgeText.copyWith(
                                    color: AppColors.cardWhite,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s12),
                            // Animated Expanding Pill Dots indicator
                            Row(
                              children: List.generate(
                                _banners.length,
                                (dotIndex) {
                                  final isActive = _currentIndex == dotIndex;
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOutCubic,
                                    margin: const EdgeInsets.only(right: 4.0),
                                    width: isActive ? 18.0 : 6.0,
                                    height: 6.0,
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? AppColors.primaryOrange
                                          : Colors.white38,
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s8),
                  // Banner Image
                  ClipRRect(
                    borderRadius: AppRadius.radiusAll12,
                    child: Container(
                      width: 100,
                      height: 128,
                      color: Colors.white12,
                      child: Image.network(
                        banner['image'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          banner['icon'] as IconData,
                          size: 48,
                          color: AppColors.cardWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
