class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String productId;
  final String productTitle;
  final String content;
  final DateTime timestamp;

  const Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.productId,
    this.productTitle = '',
    required this.content,
    required this.timestamp,
  });

  Message copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? receiverId,
    String? productId,
    String? productTitle,
    String? content,
    DateTime? timestamp,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      receiverId: receiverId ?? this.receiverId,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'productId': productId,
      'productTitle': productTitle,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      senderName: json['senderName'] as String? ?? 'User',
      receiverId: json['receiverId'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      productTitle: json['productTitle'] as String? ?? '',
      content: json['content'] as String? ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
