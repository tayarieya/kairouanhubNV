import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

/// PAGE 1 — REDESIGNED: Explore Kairouan with Modern UI
/// Features: Background image, Glassmorphism, Animations, Services, Food Banner, Places
class SearchChatbotPage extends StatefulWidget {
  const SearchChatbotPage({super.key});

  @override
  State<SearchChatbotPage> createState() => _SearchChatbotPageState();
}

class _SearchChatbotPageState extends State<SearchChatbotPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ==================== BACKGROUND IMAGE WITH GRADIENT OVERLAY ====================
          _buildBackgroundImage(),
          
          // ==================== MAIN SCROLLABLE CONTENT ====================
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  
                  // ========== HEADER WITH ICON + TITLE ==========
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildHeader(context),
                    ),
                  ),
                  
                  const Gap(30),
                  
                  // ========== SEARCH BAR + CHATBOT SECTION (GLASSMORPHISM) ==========
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildSearchAndChatbotSection(context),
                    ),
                  ),
                  
                  const Gap(40),
                  
                  // ========== SERVICES OF THE SITE ==========
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildServicesSection(context),
                  ),
                  
                  const Gap(40),
                  
                  // ========== FOOD ADVERTISING BANNER ==========
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildFoodBanner(context),
                  ),
                  
                  const Gap(40),
                  
                  // ========== WONDERFUL PLACES IN KAIROUAN (Horizontal Scroll) ==========
                  _buildWonderfulPlacesSection(context),
                  
                  const Gap(100), // Space for page indicator
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== BACKGROUND IMAGE WITH GRADIENT ====================
  Widget _buildBackgroundImage() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1A237E).withOpacity(0.7),
            const Color(0xFF0D47A1).withOpacity(0.5),
            Colors.white.withOpacity(0.9),
            Colors.white,
          ],
          stops: const [0.0, 0.4, 0.7, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Actual Image of Great Mosque
          CachedNetworkImage(
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/e/e0/Great_Mosque_of_Kairouan_Tunisia.jpg",
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: const Color(0xFF1565C0).withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
               color: const Color(0xFF1565C0).withOpacity(0.3),
               child: const Center(child: Icon(Icons.mosque, size: 80, color: Colors.white24)),
            ),
          ),
          // Gradient overlay for readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HEADER WITH ICON + TITLE ====================
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Colorful icon button
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667EEA).withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.explore, color: Colors.white, size: 28),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Kairouan',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A237E),
                    ),
                  ),
                  const Gap(4),
                  Text(
                    'Discover the sacred city',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.favorite_border, color: Colors.red[300], size: 28),
          ],
        ),
      ),
    );
  }

  // ==================== SEARCH BAR + CHATBOT (GLASSMORPHISM) ====================
  Widget _buildSearchAndChatbotSection(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search places, food, services...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.blue[700], size: 26),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.filter_list, color: Colors.grey[400]),
                  ),
                ),
              ),
              
              const Gap(20),
              
              // Chatbot Widget
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF667EEA).withOpacity(0.9),
                      const Color(0xFF764BA2).withOpacity(0.9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // AI Avatar with Lottie Animation
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      // Using a network Lottie for demonstration. In production, use local assets.
                      child: Lottie.network(
                        'https://assets2.lottiefiles.com/packages/lf20_M9p23l.json', 
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.psychology, color: Colors.white, size: 28),
                      ),
                    ),
                    const Gap(14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Assistant',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            'Ask me anything about Kairouan',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.mic, color: Colors.white, size: 24),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== SERVICES OF THE SITE ====================
  Widget _buildServicesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services of the Site',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A237E),
          ),
        ),
        const Gap(20),
        
        // Services Grid
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
          children: [
            _buildServiceCard(
              icon: Icons.restaurant,
              label: 'Restaurants',
              colors: [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)],
            ),
            _buildServiceCard(
              icon: Icons.hotel,
              label: 'Hotels',
              colors: [const Color(0xFF4ECDC4), const Color(0xFF44A08D)],
            ),
            _buildServiceCard(
              icon: Icons.local_taxi,
              label: 'Transport',
              colors: [const Color(0xFF667EEA), const Color(0xFF764BA2)],
            ),
            _buildServiceCard(
              icon: Icons.tour,
              label: 'Tours',
              colors: [const Color(0xFFFFA726), const Color(0xFFFF6F00)],
            ),
            _buildServiceCard(
              icon: Icons.shopping_bag,
              label: 'Shopping',
              colors: [const Color(0xFFAB47BC), const Color(0xFF7B1FA2)],
            ),
            _buildServiceCard(
              icon: Icons.local_cafe,
              label: 'Cafés',
              colors: [const Color(0xFF66BB6A), const Color(0xFF388E3C)],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String label,
    required List<Color> colors,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: colors[0].withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 36),
                const Gap(10),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==================== FOOD ADVERTISING BANNER ====================
  Widget _buildFoodBanner(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.orange, // Fallback color
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B6B).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Food Image
          Positioned.fill(
             child: ClipRRect(
               borderRadius: BorderRadius.circular(25),
               child: CachedNetworkImage(
                 imageUrl: "https://www.willflyforfood.net/wp-content/uploads/2019/06/tunisian-food-couscous.jpg",
                 fit: BoxFit.cover,
               ),
             ),
          ),
          
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Taste Kairouan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),
                Text(
                  'Explore authentic local cuisine',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                const Gap(16),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.restaurant_menu),
                  label: const Text('Discover Food'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFFF6B6B),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== WONDERFUL PLACES (Horizontal Scroll) ====================
  Widget _buildWonderfulPlacesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(Icons.place, color: Colors.blue[700], size: 28),
              const Gap(8),
              Text(
                'Wonderful Places in Kairouan',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
            ],
          ),
        ),
        const Gap(16),
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildPlaceCard(
                title: 'Great Mosque',
                subtitle: 'UNESCO Heritage',
                gradient: [const Color(0xFF4ECDC4), const Color(0xFF44A08D)],
              ),
              _buildPlaceCard(
                title: 'Aghlabid Basins',
                subtitle: '9th Century Reservoirs',
                gradient: [const Color(0xFF667EEA), const Color(0xFF764BA2)],
              ),
              _buildPlaceCard(
                title: 'Bir Barrouta',
                subtitle: 'Ancient Well',
                gradient: [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)],
              ),
              _buildPlaceCard(
                title: 'Medina',
                subtitle: 'Old Town Markets',
                gradient: [const Color(0xFFFFA726), const Color(0xFFFF6F00)],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceCard({
    required String title,
    required String subtitle,
    required List<Color> gradient,
  }) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Placeholder pattern
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.location_city, color: Colors.white, size: 28),
                ),
                const Gap(12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
