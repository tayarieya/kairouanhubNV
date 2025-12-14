class Category {
  final int id;
  final String name;
  final String? description;

  Category({required this.id, required this.name, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class Service {
  final int id;
  final int categoryId;
  final String name;
  final String? summary;
  final bool isActive;

  Service({
    required this.id,
    required this.categoryId,
    required this.name,
    this.summary,
    required this.isActive,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      summary: json['summary'],
      isActive: json['is_active'] ?? false,
    );
  }
}

class JobRequest {
  final int id;
  final int clientId;
  final int categoryId;
  final int serviceId;
  final int? providerId;
  final String details;
  final String city;
  final String? scheduledDate;
  final String status;
  final Category? category;
  final Service? service;

  JobRequest({
    required this.id,
    required this.clientId,
    required this.categoryId,
    required this.serviceId,
    this.providerId,
    required this.details,
    required this.city,
    this.scheduledDate,
    required this.status,
    this.category,
    this.service,
  });

  factory JobRequest.fromJson(Map<String, dynamic> json) {
    return JobRequest(
      id: json['id'],
      clientId: json['client_id'],
      categoryId: json['category_id'],
      serviceId: json['service_id'],
      providerId: json['provider_id'],
      details: json['details'],
      city: json['city'],
      scheduledDate: json['scheduled_date'],
      status: json['status'],
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      service: json['service'] != null ? Service.fromJson(json['service']) : null,
    );
  }
}
