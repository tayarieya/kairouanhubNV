import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'search_chatbot_page.dart';
import 'discover_kairouan_page.dart';
import 'food_destinations_page.dart';
import 'user_account_page.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  final PageController _pageController = PageController();
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView with all 4 pages
          PageView(
            controller: _pageController,
            children: const [
              SearchChatbotPage(),
              DiscoverKairouanPage(),
              FoodDestinationsPage(),
              UserAccountPage(),
            ],
          ),
          
          // Page Indicator at the bottom
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: WormEffect(
                    dotColor: Colors.white.withOpacity(0.4),
                    activeDotColor: Colors.white,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
