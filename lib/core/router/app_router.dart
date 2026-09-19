import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/sign_up_screen.dart';
import '../../features/products/domain/product_listing.dart';
import '../../features/products/presentation/add_product_screen.dart';
import '../../features/products/presentation/feed_screen.dart';
import '../../features/products/presentation/product_detail_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String feed = '/feed';
  static const String productDetails = '/product-details';
  static const String addProduct = '/add-product';
  static const String chat = '/chat';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.feed,
      builder: (context, state) => const FeedScreen(),
    ),
    GoRoute(
      path: AppRoutes.productDetails,
      builder: (context, state) {
        final product = state.extra as ProductListing;
        return ProductDetailScreen(product: product);
      },
    ),
    GoRoute(
      path: AppRoutes.addProduct,
      builder: (context, state) => const AddProductScreen(),
    ),
    GoRoute(
      path: AppRoutes.chat,
      builder: (context, state) {
        final chatParams = state.extra as Map<String, dynamic>? ?? {};
        return ChatScreen(
          productId: chatParams['productId'] ?? '',
          productTitle: chatParams['productTitle'] ?? '',
          peerUserId: chatParams['peerUserId'] ?? '',
          peerName: chatParams['peerName'] ?? 'Campus Peer',
        );
      },
    ),
  ],
);
