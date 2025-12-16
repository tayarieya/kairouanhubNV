import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String serviceId; // In a real app, use this to fetch details

  const ServiceDetailsScreen({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. Full Screen Hero Image
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white), onPressed: (){}),
              IconButton(icon: const Icon(Icons.share, color: Colors.white), onPressed: (){}),
            ],
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
                    bottom: 30,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('TOP RATED', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                        ),
                        const Gap(10),
                        const Text(
                          'Grand Mosque Tours',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Playfair Display',
                          ),
                        ),
                        const Gap(5),
                         Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white70, size: 16),
                            const Gap(5),
                            const Text('Medina Center, Kairouan', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          // 2. Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Provider Info
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
                      ),
                      const Gap(15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hosted by Ahmed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('Certified Guide • 5 Years Exp', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: const Color(0xFFFAFAF9), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.chat_bubble_outline, color: Color(0xFF1A4D2E)),
                      )
                    ],
                  ),
                  const Divider(height: 40),

                  // Description
                  const Text('About this Experience', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const Gap(10),
                  Text(
                    'Discover the spiritual heart of Tunisia. This guided tour takes you through the architectural marvel of the Great Mosque, explaining hits history dating back to 670 AD. Includes access to the minaret view.',
                    style: TextStyle(color: Colors.grey[600], height: 1.6),
                  ),
                  
                  const Gap(30),
                  
                  // Gallery
                  const Text('Gallery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const Gap(15),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildGalleryItem('https://images.unsplash.com/photo-1581578731117-104f8a7d472b?q=80&w=2670&auto=format&fit=crop'),
                        _buildGalleryItem('https://images.unsplash.com/photo-1626509653295-24d1a629b392?q=80&w=2670&auto=format&fit=crop'),
                        _buildGalleryItem('https://images.unsplash.com/photo-1556911220-e15b29be8c8f?q=80&w=2670&auto=format&fit=crop'),
                      ],
                    ),
                  ),

                  const Gap(100), // Spacing for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          children: [
             const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('20 TND', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF1A4D2E))),
                Text('/ person', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const Gap(20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A4D2E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Book Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryItem(String url) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
      ),
    );
  }
}
