import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'data/home_repository.dart';
import 'presentation/providers/home_provider.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(featuredServicesProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        label: const Text('AI Concierge', style: TextStyle(color: Colors.white)),
      ),
      body: CustomScrollView(
        slivers: [
          // 1. Parallax/Hero Header
          SliverAppBar(
            expandedHeight: 340,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/e0/Great_Mosque_of_Kairouan_Tunisia.jpg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _AnimatedEntry(
                          delay: 200,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4AF37),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'PREMIER COLLECTION',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        _AnimatedEntry(
                          delay: 400,
                          child: const Text(
                            'Experience the \nSoul of Kairouan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Playfair Display',
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Sticky Search Bar
          SliverPersistentHeader(
            delegate: _StickySearchBarDelegate(),
            pinned: true,
          ),

          // 3. Content Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Features
                  _AnimatedEntry(
                    delay: 600,
                    child: Row(
                      children: [
                        Expanded(child: _buildFeatureTile(Icons.verified_outlined, 'Trusted', 'Elite Pros')),
                        const Gap(15),
                        Expanded(child: _buildFeatureTile(Icons.bolt_outlined, 'Fast', 'Instant Book')),
                        const Gap(15),
                        Expanded(child: _buildFeatureTile(Icons.shield_outlined, 'Secure', 'Guaranteed')),
                      ],
                    ),
                  ),
                  const Gap(40),

                  // Categories
                  _AnimatedEntry(
                    delay: 700,
                    child: _buildSectionHeader('Explore Categories', 'Curated for you'),
                  ),
                  const Gap(20),
                  _AnimatedEntry(
                     delay: 750,
                     child: SizedBox(
                      height: 110,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategoryCard('Culture', Icons.mosque_outlined),
                          _buildCategoryCard('Food', Icons.restaurant_outlined),
                          _buildCategoryCard('Crafts', Icons.brush_outlined),
                          _buildCategoryCard('Stay', Icons.hotel_outlined),
                          _buildCategoryCard('Transport', Icons.directions_car_filled_outlined),
                        ],
                      ),
                    ),
                  ),
                  const Gap(40),

                  // Featured Listings (Dynamic)
                  _AnimatedEntry(
                    delay: 800,
                    child: _buildSectionHeader('Trending Now', 'Highest rated experiences'),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),

          // 4. Dynamic List with Skeletons
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: servicesAsync.when(
              loading: () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildSkeletonCard(),
                  childCount: 3,
                ),
              ),
              error: (err, stack) => SliverToBoxAdapter(child: Text('Error: $err')),
              data: (services) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final service = services[index];
                    return _AnimatedEntry(
                      delay: 900 + (index * 100),
                      child: _buildWideListingCard(context, service),
                    );
                  },
                  childCount: services.length,
                ),
              ),
            ),
          ),
          
          const SliverGap(80),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Playfair Display',
          ),
        ),
        const Gap(5),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF1A4D2E), size: 28),
          const Gap(10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
             height: 70,
             width: 70,
             decoration: BoxDecoration(
               color: const Color(0xFFFAFAF9),
               borderRadius: BorderRadius.circular(20),
               border: Border.all(color: const Color(0xFF1A4D2E).withOpacity(0.1)),
             ),
             child: Icon(icon, color: const Color(0xFF1A4D2E), size: 30),
          ),
          const Gap(10),
          Text(
            title,
            style: const TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildWideListingCard(BuildContext context, ServiceModel service) {
    return GestureDetector(
      onTap: () {
        context.go('/home/service/${service.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: service.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFD4AF37), size: 14),
                        const Gap(4),
                        Text(service.rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          service.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Playfair Display',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(5),
                        Text(
                          service.location,
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    service.price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A4D2E),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonCard() {
    // Custom simple shimmer since we might not have the package installed
    // A grey box to represent loading
    return Container(
      height: 280,
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: CircularProgressIndicator(color: const Color(0xFF1A4D2E).withOpacity(0.5)),
      ),
    );
  }
}

// Custom Animation Widget
class _AnimatedEntry extends StatefulWidget {
  final Widget child;
  final int delay;

  const _AnimatedEntry({required this.child, required this.delay});

  @override
  State<_AnimatedEntry> createState() => _AnimatedEntryState();
}

class _AnimatedEntryState extends State<_AnimatedEntry> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}


class _StickySearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Color(0xFF1A4D2E)),
              const Gap(10),
              Text(
                'Search Kairouan...',
                style: TextStyle(color: Colors.grey[400]),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFAFAF9),
                ),
                child: const Icon(Icons.tune, size: 18, color: Color(0xFF1A4D2E)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
