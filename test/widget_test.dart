import 'package:flutter_test/flutter_test.dart';
import 'package:peerlink/features/auth/domain/app_user.dart';
import 'package:peerlink/features/products/domain/product_listing.dart';

void main() {
  group('Campus Barter Data Models Unit Tests', () {
    test('AppUser converts to and from JSON correctly', () {
      final user = AppUser(
        id: 'user_123',
        email: 'student@university.edu',
        displayName: 'John Doe',
        campusName: 'North Campus',
        createdAt: DateTime(2025, 1, 1),
      );

      final json = user.toJson();
      final restoredUser = AppUser.fromJson(json);

      expect(restoredUser.id, equals('user_123'));
      expect(restoredUser.email, equals('student@university.edu'));
      expect(restoredUser.displayName, equals('John Doe'));
      expect(restoredUser.campusName, equals('North Campus'));
    });

    test('ProductListing converts to and from JSON correctly', () {
      final product = ProductListing(
        id: 'prod_456',
        sellerId: 'user_123',
        sellerName: 'John Doe',
        title: 'Organic Chemistry Textbook',
        description: 'Hardcover 8th edition in good condition',
        category: 'Textbooks',
        condition: 'Good',
        tradePreferences: 'Graphing Calculator',
        imageUrls: ['https://example.com/image.jpg'],
        createdAt: DateTime(2025, 1, 1),
      );

      final json = product.toJson();
      final restoredProduct = ProductListing.fromJson(json);

      expect(restoredProduct.id, equals('prod_456'));
      expect(restoredProduct.title, equals('Organic Chemistry Textbook'));
      expect(restoredProduct.category, equals('Textbooks'));
      expect(restoredProduct.imageUrls.length, equals(1));
    });
  });
}
