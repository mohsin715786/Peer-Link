import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../data/product_repository.dart';
import '../data/storage_repository.dart';
import '../domain/product_listing.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final storageRepositoryProvider = Provider<StorageRepository>((ref) {
  return StorageRepository();
});

final selectedCategoryProvider = StateProvider<String>((ref) => 'All');
final searchQueryProvider = StateProvider<String>((ref) => '');

final productFeedStreamProvider = StreamProvider<List<ProductListing>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  final category = ref.watch(selectedCategoryProvider);
  final query = ref.watch(searchQueryProvider);

  return repository.watchProducts(
    category: category,
    searchQuery: query,
  );
});

class ProductController extends StateNotifier<AsyncValue<void>> {
  final ProductRepository _productRepository;
  final StorageRepository _storageRepository;

  ProductController({
    required ProductRepository productRepository,
    required StorageRepository storageRepository,
  })  : _productRepository = productRepository,
        _storageRepository = storageRepository,
        super(const AsyncValue.data(null));

  Future<bool> createProduct({
    required String title,
    required String description,
    required String category,
    required String condition,
    required String tradePreferences,
    required String sellerId,
    required String sellerName,
    List<XFile> images = const [],
  }) async {
    state = const AsyncValue.loading();
    try {
      // Create initial listing to get ID
      final initialProduct = ProductListing(
        id: '',
        sellerId: sellerId,
        sellerName: sellerName,
        title: title,
        description: description,
        category: category,
        condition: condition,
        tradePreferences: tradePreferences,
        createdAt: DateTime.now(),
      );

      final productId = await _productRepository.createProduct(initialProduct);

      // Upload images if any
      List<String> imageUrls = [];
      if (images.isNotEmpty) {
        imageUrls = await _storageRepository.uploadProductImages(images, productId);
        final updatedProduct = initialProduct.copyWith(
          id: productId,
          imageUrls: imageUrls,
        );
        await _productRepository.createProduct(updatedProduct);
      }

      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final productControllerProvider =
    StateNotifierProvider<ProductController, AsyncValue<void>>((ref) {
  return ProductController(
    productRepository: ref.watch(productRepositoryProvider),
    storageRepository: ref.watch(storageRepositoryProvider),
  );
});
