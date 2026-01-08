import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/app_theme.dart';
import 'package:go_router/go_router.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  String _activeFilter = 'All';

  final List<String> _filters = ['All', 'Services', 'Places', 'Events', 'Artisans'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KairouanColors.limestone,
      body: SafeArea(
        child: Column(
          children: [
            // Header & Search Bar
            _buildSearchHeader(context),
            
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Smart Filters
                    _buildFilters(),
                    const Gap(30),

                    // Quick Categories
                    _buildSectionTitle('Explore by Category'),
                    const Gap(15),
                    _buildCategoriesGrid(),
                    const Gap(30),

                    // Trending
                    _buildSectionTitle('Trending in Kairouan'),
                    const Gap(15),
                    _buildTrendingList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: KairouanColors.midnight.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discover',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 32,
              color: KairouanColors.midnight,
            ),
          ).animate().fadeIn().moveY(begin: 10, end: 0),
          const Gap(5),
          Text(
            'Find the best of Kairouan',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ).animate().fadeIn(delay: 200.ms).moveY(begin: 10, end: 0),
          const Gap(20),
          
          // Search Field
          Container(
            decoration: BoxDecoration(
              color: KairouanColors.limestone,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search services, places...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.search, color: KairouanColors.gold),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: KairouanColors.midnight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.tune, color: Colors.white, size: 20),
                ),
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).scale(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const Gap(10),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isActive = _activeFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => _activeFilter = filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? KairouanColors.midnight : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? Colors.transparent : Colors.grey.withOpacity(0.3),
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: KairouanColors.midnight.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isActive ? KairouanColors.gold : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(delay: 500.ms).slideX();
  }

  Widget _buildCategoriesGrid() {
    final categories = [
      {'icon': Icons.mosque, 'name': 'Culture', 'color': const Color(0xFFE8D5B7)},
      {'icon': Icons.restaurant, 'name': 'Food', 'color': const Color(0xFFF5F1E8)},
      {'icon': Icons.brush, 'name': 'Crafts', 'color': const Color(0xFFE8D5B7)},
      {'icon': Icons.hotel, 'name': 'Stay', 'color': const Color(0xFFF5F1E8)},
      {'icon': Icons.shopping_bag, 'name': 'Shop', 'color': const Color(0xFFE8D5B7)},
      {'icon': Icons.directions_car, 'name': 'Travel', 'color': const Color(0xFFF5F1E8)},
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (cat['color'] as Color).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(cat['icon'] as IconData, color: KairouanColors.midnight, size: 24),
              ),
              const Gap(10),
              Text(
                cat['name'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: KairouanColors.textMain,
                ),
              ),
            ],
          ),
        ).animate().scale(delay: (100 * index).ms);
      },
    );
  }

  Widget _buildTrendingList() {
    final items = [
      {'name': 'Makroudh Workshop', 'tag': 'Food', 'rating': '4.9'},
      {'name': 'Carpet Weaving', 'tag': 'Crafts', 'rating': '4.8'},
      {'name': 'Medina Tour', 'tag': 'Culture', 'rating': '5.0'},
    ];

    return Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/e/e0/Great_Mosque_of_Kairouan_Tunisia.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      item['tag']!,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.show_chart, color: Colors.green, size: 20),
                  const Gap(4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: KairouanColors.gold, size: 14),
                      Text(
                        item['rating']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ).animate().fadeIn().slideX();
      }).toList(),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Tajawal',
        color: KairouanColors.textMain,
      ),
    );
  }
}
