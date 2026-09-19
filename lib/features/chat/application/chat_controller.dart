import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/notification_provider.dart';
import '../../../core/services/notification_service.dart';
import '../data/chat_repository.dart';
import '../domain/message.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository();
});

class ChatArgs {
  final String productId;
  final String currentUserId;
  final String peerUserId;

  const ChatArgs({
    required this.productId,
    required this.currentUserId,
    required this.peerUserId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatArgs &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          currentUserId == other.currentUserId &&
          peerUserId == other.peerUserId;

  @override
  int get hashCode =>
      productId.hashCode ^ currentUserId.hashCode ^ peerUserId.hashCode;
}

final chatMessagesStreamProvider =
    StreamProvider.family<List<Message>, ChatArgs>((ref, args) {
  final chatRepo = ref.watch(chatRepositoryProvider);
  return chatRepo.watchMessages(
    productId: args.productId,
    currentUserId: args.currentUserId,
    peerUserId: args.peerUserId,
  );
});

class ChatController extends StateNotifier<AsyncValue<void>> {
  final ChatRepository _chatRepository;
  final NotificationService _notificationService;

  ChatController({
    required ChatRepository chatRepository,
    required NotificationService notificationService,
  })  : _chatRepository = chatRepository,
        _notificationService = notificationService,
        super(const AsyncValue.data(null));

  Future<bool> sendMessage({
    required String senderId,
    required String senderName,
    required String receiverId,
    required String productId,
    required String productTitle,
    required String content,
  }) async {
    if (content.trim().isEmpty) return false;
    try {
      final msg = Message(
        id: '',
        senderId: senderId,
        senderName: senderName,
        receiverId: receiverId,
        productId: productId,
        productTitle: productTitle,
        content: content.trim(),
        timestamp: DateTime.now(),
      );

      await _chatRepository.sendMessage(msg);

      // Trigger trade notification
      await _notificationService.triggerTradeOfferNotification(
        receiverUserId: receiverId,
        itemTitle: productTitle,
        senderName: senderName,
      );

      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final chatControllerProvider =
    StateNotifierProvider<ChatController, AsyncValue<void>>((ref) {
  return ChatController(
    chatRepository: ref.watch(chatRepositoryProvider),
    notificationService: ref.watch(notificationServiceProvider),
  );
});
