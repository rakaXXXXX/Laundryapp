import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:laundry_app/core/constants/app_colors.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<Promo> _promos = [
    Promo(
      title: 'Get 30% Off',
      description: 'On your first laundry order',
      color: AppColors.lightPrimary,
      gradient: AppColors.primaryGradient,
    ),
    Promo(
      title: 'Free Pickup',
      description: 'On orders above \$30',
      color: AppColors.lightAccent,
      gradient: LinearGradient(
        colors: [AppColors.lightAccent, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    Promo(
      title: 'Express Service',
      description: '3-hour delivery guarantee',
      color: Colors.purple,
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.pink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _promos.length,
            itemBuilder: (context, index) {
              final promo = _promos[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: promo.gradient,
                  boxShadow: [
                    BoxShadow(
                      color: promo.color.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Decorative elements
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      left: -30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            promo.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            promo.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Claim Now',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: promo.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: _pageController,
          count: _promos.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColors.lightPrimary,
            dotColor: AppColors.lightTextSecondary.withOpacity(0.3),
            dotHeight: 8,
            dotWidth: 8,
            spacing: 6,
            expansionFactor: 3,
          ),
        ),
      ],
    );
  }
}

class Promo {
  final String title;
  final String description;
  final Color color;
  final Gradient gradient;

  Promo({
    required this.title,
    required this.description,
    required this.color,
    required this.gradient,
  });
}