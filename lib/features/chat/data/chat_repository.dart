import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/message.dart';

class ChatRepository {
  final FirebaseFirestore _firestore;

  ChatRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  String _getRoomId(String userId1, String userId2, String productId) {
    final sortedUserIds = [userId1, userId2]..sort();
    return '${productId}_${sortedUserIds[0]}_${sortedUserIds[1]}';
  }

  Stream<List<Message>> watchMessages({
    required String productId,
    required String currentUserId,
    required String peerUserId,
  }) {
    final roomId = _getRoomId(currentUserId, peerUserId, productId);
    return _firestore
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Message.fromJson(data);
      }).toList();
    });
  }

  Future<void> sendMessage(Message message) async {
    final roomId = _getRoomId(message.senderId, message.receiverId, message.productId);
    final roomRef = _firestore.collection('chats').doc(roomId);

    await _firestore.runTransaction((transaction) async {
      final msgRef = roomRef.collection('messages').doc();
      final msgData = message.copyWith(id: msgRef.id).toJson();

      transaction.set(msgRef, msgData);
      transaction.set(
        roomRef,
        {
          'lastMessage': message.content,
          'lastUpdated': message.timestamp.toIso8601String(),
          'participants': [message.senderId, message.receiverId],
          'productId': message.productId,
          'productTitle': message.productTitle,
        },
        SetOptions(merge: true),
      );
    });
  }
}
