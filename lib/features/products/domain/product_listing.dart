class ProductListing {
  final String id;
  final String sellerId;
  final String sellerName;
  final String title;
  final String description;
  final String category;
  final String condition;
  final String tradePreferences;
  final List<String> imageUrls;
  final String status;
  final DateTime createdAt;

  const ProductListing({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.title,
    required this.description,
    required this.category,
    required this.condition,
    required this.tradePreferences,
    this.imageUrls = const [],
    this.status = 'available',
    required this.createdAt,
  });

  ProductListing copyWith({
    String? id,
    String? sellerId,
    String? sellerName,
    String? title,
    String? description,
    String? category,
    String? condition,
    String? tradePreferences,
    List<String>? imageUrls,
    String? status,
    DateTime? createdAt,
  }) {
    return ProductListing(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      tradePreferences: tradePreferences ?? this.tradePreferences,
      imageUrls: imageUrls ?? this.imageUrls,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'title': title,
      'description': description,
      'category': category,
      'condition': condition,
      'tradePreferences': tradePreferences,
      'imageUrls': imageUrls,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ProductListing.fromJson(Map<String, dynamic> json) {
    return ProductListing(
      id: json['id'] as String? ?? '',
      sellerId: json['sellerId'] as String? ?? '',
      sellerName: json['sellerName'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      condition: json['condition'] as String? ?? 'Good',
      tradePreferences: json['tradePreferences'] as String? ?? 'Open to offer',
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      status: json['status'] as String? ?? 'available',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
