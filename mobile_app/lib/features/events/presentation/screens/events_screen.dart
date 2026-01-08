import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/app_theme.dart';
import 'package:go_router/go_router.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KairouanColors.limestone,
      appBar: AppBar(
        title: const Text('Happening in Kairouan', style: TextStyle(fontFamily: 'Amiri', fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: KairouanColors.limestone,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month, color: KairouanColors.midnight)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Featured Event
            _buildFeaturedEvent(context),
            const Gap(30),
            
            // Upcoming List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Upcoming Events',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                    color: KairouanColors.textMain,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All', style: TextStyle(color: KairouanColors.gold)),
                ),
              ],
            ),
            const Gap(15),
            
            _buildEventCard(
              title: 'Mouled Festival 2024',
              date: '15',
              month: 'SEP',
              location: 'Okba Mosque',
              image: 'https://upload.wikimedia.org/wikipedia/commons/e/e0/Great_Mosque_of_Kairouan_Tunisia.jpg',
              price: 'Free',
            ),
            _buildEventCard(
              title: 'Carpet Exhibition',
              date: '22',
              month: 'OCT',
              location: 'Medina Expo Center',
              image: 'https://upload.wikimedia.org/wikipedia/commons/e/e0/Great_Mosque_of_Kairouan_Tunisia.jpg',
              price: '10 TND',
            ),
            _buildEventCard(
              title: 'Sufi Music Night',
              date: '05',
              month: 'NOV',
              location: 'Sidi Sahbi',
              image: 'https://upload.wikimedia.org/wikipedia/commons/e/e0/Great_Mosque_of_Kairouan_Tunisia.jpg',
              price: '25 TND',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedEvent(BuildContext context) {
    return Container(
      height: 380,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
              imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/e0/Great_Mosque_of_Kairouan_Tunisia.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
          // Top Tag
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: KairouanColors.gold,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'HIGHLIGHT',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ramadan Nights in Medina',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                  ),
                ),
                const Gap(8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                    const Gap(5),
                    const Text('March 10 - April 9', style: TextStyle(color: Colors.white70)),
                    const Gap(15),
                    const Icon(Icons.location_on, color: Colors.white70, size: 16),
                    const Gap(5),
                    const Text('Old City', style: TextStyle(color: Colors.white70)),
                  ],
                ),
                const Gap(15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text('View Details'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }

  Widget _buildEventCard({required String title, required String date, required String month, required String location, required String image, required String price}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Date Column
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: KairouanColors.midnight.withOpacity(0.05),
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: KairouanColors.midnight,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  month,
                  style: const TextStyle(
                    color: KairouanColors.gold,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
                      const Gap(4),
                      Text(
                        location,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: KairouanColors.limestone,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: KairouanColors.gold.withOpacity(0.3)),
                    ),
                    child: Text(
                      price,
                      style: const TextStyle(
                        color: KairouanColors.midnight,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().slideX().fadeIn();
  }
}
