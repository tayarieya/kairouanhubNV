import 'package:flutter/material.dart';
import 'home_tab.dart';
import '../../../../features/services/presentation/screens/services_tab.dart';
import '../../../../features/search/presentation/screens/search_tab.dart';
import '../../../../features/profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index); // Use jumpToPage for instant switch
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access theme data
    final theme = Theme.of(context);
    final kairouanGold = theme.colorScheme.secondary;
    final kairouanMidnight = theme.colorScheme.primary;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeTab(),
          ServicesTab(),
          SearchTab(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kairouanMidnight.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: kairouanGold.withOpacity(0.15),
            labelTextStyle: WidgetStateProperty.all(
              const TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.w600,
                fontFamily: 'Tajawal', // Use Kairouan font
              ),
            ),
          ),
          child: NavigationBar(
            height: 70,
            backgroundColor: Colors.white.withOpacity(0.9), // Slight transparency
            elevation: 0,
            selectedIndex: _currentIndex,
            onDestinationSelected: _onItemTapped,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: kairouanMidnight),
                label: 'Home',
              ),
              NavigationDestination(
                icon: const Icon(Icons.grid_view_outlined),
                selectedIcon: Icon(Icons.grid_view, color: kairouanMidnight),
                label: 'Services',
              ),
              NavigationDestination(
                icon: const Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search, color: kairouanMidnight),
                label: 'Search',
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: kairouanMidnight),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
