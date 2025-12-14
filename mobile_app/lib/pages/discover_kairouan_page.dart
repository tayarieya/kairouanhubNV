import 'dart:ui';
import 'package:flutter/material.dart';

/// PAGE 2 — REDESIGNED: Discover Kairouan
/// Features: Hero Header, Local Services Grid, Hidden Places Scroll, CTA Button
class DiscoverKairouanPage extends StatefulWidget {
  const DiscoverKairouanPage({super.key});

  @override
  State<DiscoverKairouanPage> createState() => _DiscoverKairouanPageState();
}

class _DiscoverKairouanPageState extends State<DiscoverKairouanPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== HERO HEADER ====================
            _buildHeroHeader(context),
            
            const SizedBox(height: 40),
            
            // ==================== LOCAL SERVICES SECTION ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildLocalServicesSection(context),
            ),
            
            const SizedBox(height: 50),
            
            // ==================== HIDDEN PLACES SECTION ====================
            _buildHiddenPlacesSection(context),
            
            const SizedBox(height: 40),
            
            // ==================== SHOW MORE PLACES CTA ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildShowMoreButton(context),
            ),
            
            const SizedBox(height: 100), // Space for page indicator
          ],
        ),
      ),
    );
  }

  // ==================== HERO HEADER WITH BACKGROUND ====================
  Widget _buildHeroHeader(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: 320,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Image Placeholder (Kairouan streets/architecture)
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: const Color(0xFF00838F),
              ),
              child: Center(
                child: Icon(
                  Icons.location_city,
                  size: 120,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            
            // Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Icon badge
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.explore, color: Colors.white, size: 32),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Discover Kairouan',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Hidden places and local services you should know',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: 17,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== LOCAL SERVICES SECTION ====================
  Widget _buildLocalServicesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.room_service, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              'Local Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Services Grid (2 columns)
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _buildServiceCard(
              icon: Icons.local_taxi,
              title: 'Transport',
              subtitle: 'Taxis & Buses',
              gradient: [const Color(0xFF42A5F5), const Color(0xFF1976D2)],
            ),
            _buildServiceCard(
              icon: Icons.medical_services,
              title: 'Healthcare',
              subtitle: 'Clinics & Pharmacies',
              gradient: [const Color(0xFFEF5350), const Color(0xFFC62828)],
            ),
            _buildServiceCard(
              icon: Icons.shopping_bag,
              title: 'Shopping',
              subtitle: 'Markets & Stores',
              gradient: [const Color(0xFFAB47BC), const Color(0xFF7B1FA2)],
            ),
            _buildServiceCard(
              icon: Icons.local_cafe,
              title: 'Cafés',
              subtitle: 'Coffee & Tea Houses',
              gradient: [const Color(0xFF8D6E63), const Color(0xFF5D4037)],
            ),
            _buildServiceCard(
              icon: Icons.school,
              title: 'Education',
              subtitle: 'Schools & Libraries',
              gradient: [const Color(0xFF26C6DA), const Color(0xFF00838F)],
            ),
            _buildServiceCard(
              icon: Icons.local_gas_station,
              title: 'Gas Stations',
              subtitle: 'Fuel Services',
              gradient: [const Color(0xFFFF7043), const Color(0xFFD84315)],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.85 + (0.15 * value),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: gradient[0].withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: gradient),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: gradient[0].withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(icon, color: Colors.white, size: 32),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1A237E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ==================== HIDDEN PLACES SECTION (Horizontal Scroll) ====================
  Widget _buildHiddenPlacesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.location_on, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Hidden Places in Kairouan',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Secret spots locals love',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        // Horizontal Scroll List
        SizedBox(
          height: 280,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildHiddenPlaceCard(
                title: 'Ancient Cisterns',
                description: 'Underground water reservoirs from the 9th century',
                gradient: [const Color(0xFF667EEA), const Color(0xFF764BA2)],
              ),
              _buildHiddenPlaceCard(
                title: 'Old Pottery Workshop',
                description: 'Traditional ceramics made by local artisans',
                gradient: [const Color(0xFF4ECDC4), const Color(0xFF44A08D)],
              ),
              _buildHiddenPlaceCard(
                title: 'Secret Garden Oasis',
                description: 'Hidden green paradise in the heart of medina',
                gradient: [const Color(0xFF66BB6A), const Color(0xFF388E3C)],
              ),
              _buildHiddenPlaceCard(
                title: 'Historic Hammam',
                description: 'Traditional bathhouse still in operation',
                gradient: [const Color(0xFFFFD93D), const Color(0xFFFFA726)],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHiddenPlaceCard({
    required String title,
    required String description,
    required List<Color> gradient,
  }) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder with gradient
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                // Pattern overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
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
                Center(
                  child: Icon(
                    Icons.image,
                    size: 60,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber[700], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== SHOW MORE PLACES CTA BUTTON ====================
  Widget _buildShowMoreButton(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_location, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  const Text(
                    'Show More Places',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
