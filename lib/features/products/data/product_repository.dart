import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../domain/product_listing.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _productsCollection =>
      _firestore.collection('products');

  static final List<ProductListing> _demoProducts = [
    ProductListing(
      id: 'demo_1',
      sellerId: 'user_alex',
      sellerName: 'Alex Rivers',
      title: 'Organic Chemistry 8th Ed',
      description: 'Hardcover in great condition, no missing pages or heavy highlighting. Used for CHEM 201.',
      category: 'Textbooks',
      condition: 'Good',
      tradePreferences: 'TI-84 Graphing Calculator',
      imageUrls: ['https://picsum.photos/id/24/600/600'],
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ProductListing(
      id: 'demo_2',
      sellerId: 'user_sarah',
      sellerName: 'Sarah Chen',
      title: 'Anker Soundcore Bluetooth Speaker',
      description: 'Compact 12W wireless speaker with deep bass. Waterproof, perfect for dorm rooms.',
      category: 'Electronics',
      condition: 'Like New',
      tradePreferences: 'Desk Lamp or Monitor Arm',
      imageUrls: ['https://picsum.photos/id/1/600/600'],
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    ProductListing(
      id: 'demo_3',
      sellerId: 'user_marcus',
      sellerName: 'Marcus Vance',
      title: 'Ergonomic Mesh Office Chair',
      description: 'Adjustable lumbar support and headrest. Moving out of North Hall dorm at end of semester.',
      category: 'Dorm Essentials',
      condition: 'Good',
      tradePreferences: 'Noise Canceling Headphones',
      imageUrls: ['https://picsum.photos/id/1060/600/600'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ProductListing(
      id: 'demo_4',
      sellerId: 'user_priya',
      sellerName: 'Priya Patel',
      title: 'Nintendo Switch Game - Zelda TOTK',
      description: 'Cartridge and original case in pristine condition. Finished the game, ready to swap!',
      category: 'Games',
      condition: 'Brand New',
      tradePreferences: 'Mario Kart 8 Deluxe or Pokemon',
      imageUrls: ['https://picsum.photos/id/96/600/600'],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  Stream<List<ProductListing>> watchProducts({
    String? category,
    String? searchQuery,
  }) {
    try {
      Query<Map<String, dynamic>> query =
          _productsCollection.orderBy('createdAt', descending: true);

      if (category != null && category.isNotEmpty && category != 'All') {
        query = query.where('category', isEqualTo: category);
      }

      return query.snapshots().map((snapshot) {
        if (snapshot.docs.isEmpty) {
          return _filterList(_demoProducts, category, searchQuery);
        }

        final items = snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return ProductListing.fromJson(data);
        }).toList();

        return _filterList(items, category, searchQuery);
      }).handleError((error) {
        debugPrint('Firestore stream error, falling back to demo products: $error');
        return _filterList(_demoProducts, category, searchQuery);
      });
    } catch (e) {
      return Stream.value(_filterList(_demoProducts, category, searchQuery));
    }
  }

  List<ProductListing> _filterList(
    List<ProductListing> items,
    String? category,
    String? searchQuery,
  ) {
    var filtered = items;

    if (category != null && category.isNotEmpty && category != 'All') {
      filtered = filtered.where((item) => item.category == category).toList();
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final q = searchQuery.toLowerCase().trim();
      filtered = filtered.where((item) {
        return item.title.toLowerCase().contains(q) ||
            item.description.toLowerCase().contains(q) ||
            item.category.toLowerCase().contains(q);
      }).toList();
    }

    return filtered;
  }

  Future<ProductListing?> getProductById(String id) async {
    try {
      final doc = await _productsCollection.doc(id).get();
      if (!doc.exists || doc.data() == null) {
        return _demoProducts.firstWhere((p) => p.id == id, orElse: () => _demoProducts.first);
      }
      final data = doc.data()!;
      data['id'] = doc.id;
      return ProductListing.fromJson(data);
    } catch (_) {
      return _demoProducts.firstWhere((p) => p.id == id, orElse: () => _demoProducts.first);
    }
  }

  Future<String> createProduct(ProductListing product) async {
    try {
      final docRef = _productsCollection.doc();
      final newProduct = product.copyWith(id: docRef.id);
      await docRef.set(newProduct.toJson());
      return docRef.id;
    } catch (e) {
      debugPrint('Create product offline mode: $e');
      final newId = 'local_${DateTime.now().millisecondsSinceEpoch}';
      _demoProducts.insert(0, product.copyWith(id: newId));
      return newId;
    }
  }

  Future<void> updateProductStatus(String productId, String status) async {
    try {
      await _productsCollection.doc(productId).update({'status': status});
    } catch (_) {}
  }
}
