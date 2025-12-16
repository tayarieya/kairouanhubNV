import 'package:flutter_riverpod/flutter_riverpod.dart';

// Model for a featured service
class ServiceModel {
  final String id;
  final String name;
  final String category;
  final String rating;
  final String imageUrl;
  final String location;
  final String price;

  ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.imageUrl,
    required this.location,
    required this.price,
  });
}

// Repository to simulate API calls
class HomeRepository {
  Future<List<ServiceModel>> getFeaturedServices() async {
    // Simulate network delay for "Skeleton" showcase
    await Future.delayed(const Duration(seconds: 2));

    return [
      ServiceModel(
        id: '1',
        name: 'Grand Mosque Tours',
        category: 'Culture',
        rating: '5.0',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/e0/Great_Mosque_of_Kairouan_Tunisia.jpg',
        location: 'Medina Center',
        price: '20 TND',
      ),
      ServiceModel(
        id: '2',
        name: 'Dar Hassine Cleaners',
        category: 'Cleaning',
        rating: '4.8',
        imageUrl: 'https://images.unsplash.com/photo-1581578731117-104f8a7d472b?q=80&w=2670&auto=format&fit=crop',
        location: 'City Wide',
        price: '30 TND/hr',
      ),
      ServiceModel(
        id: '3',
        name: 'Makroudh El Bey',
        category: 'Food',
        rating: '4.9',
        imageUrl: 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?q=80&w=2670&auto=format&fit=crop',
        location: 'Rue des Souks',
        price: '15 TND/kg',
      ),
      ServiceModel(
        id: '4',
        name: 'Kairouan Carpets',
        category: 'Shopping',
        rating: '4.7',
        imageUrl: 'https://images.unsplash.com/photo-1626509653295-24d1a629b392?q=80&w=2670&auto=format&fit=crop',
        location: 'Industrial Zone',
        price: 'Varies',
      ),
    ];
  }
}

final homeRepositoryProvider = Provider((ref) => HomeRepository());
