import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/app_theme.dart';
import '../../data/service_repository.dart';


class ServicesTab extends ConsumerWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(servicesProvider);

    return Scaffold(
      backgroundColor: KairouanColors.limestone,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: KairouanColors.limestone,
            title: const Text(
              'Services',
              style: TextStyle(
                fontFamily: 'Amiri',
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A4D2E),
              ),
            ),
            centerTitle: false,
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.filter_list, color: Color(0xFF1A4D2E)))
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  children: [
                    _buildFilterPill('All', true),
                    _buildFilterPill('Renovation', false),
                    _buildFilterPill('Tech Support', false),
                    _buildFilterPill('Cleaning', false),
                    _buildFilterPill('Wellness', false),
                  ],
                ),
              ),
            ),
          ),
          
          servicesAsync.when(
            loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            error: (err, stack) => SliverToBoxAdapter(child: Center(child: Text('Error: $err'))),
            data: (services) => SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final service = services[index];
                      return _buildServiceTile(
                        service.name, 
                        service.categoryName, 
                        service.summary ?? 'Professional Service',
                        service.imageUrl ?? 'https://randomuser.me/api/portraits/men/32.jpg',
                        double.tryParse(service.rating ?? '5.0') ?? 5.0
                      );
                    },
                    childCount: services.length,
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPill(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? KairouanColors.midnight : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2),
        ),
        boxShadow: isSelected 
          ? [BoxShadow(color: KairouanColors.midnight.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] 
          : [],
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFFD4AF37) : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceTile(String name, String tag, String service, String image, double rating) {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[100]),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: KairouanColors.limestone,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag.toUpperCase(),
                    style: const TextStyle(fontSize: 10, color: Color(0xFF1A4D2E), fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(8),
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Plus Jakarta Sans'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  service,
                  style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.star, color: Color(0xFFD4AF37), size: 20),
              const Gap(4),
              Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
