import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('FCM Background message received: ${message.messageId}');
}

class NotificationService {
  final FirebaseMessaging _messaging;
  final FirebaseFirestore _firestore;

  NotificationService({
    FirebaseMessaging? messaging,
    FirebaseFirestore? firestore,
  })  : _messaging = messaging ?? FirebaseMessaging.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> initialize(BuildContext context) async {
    try {
      // 1. Request Permission
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted FCM permission');
      }

      // 2. Configure Background Handler
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // 3. Foreground Options
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // 4. Foreground Message Listener
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;
        if (notification != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.notifications_active, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title ?? 'Campus Barter Trade Alert',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (notification.body != null)
                          Text(
                            notification.body!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              backgroundColor: AppTheme.primaryColor,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      });

      // 5. Message Opened App Listener
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('App opened from notification: ${message.data}');
      });
    } catch (e) {
      debugPrint('FCM Notification initialization note: $e');
    }
  }

  Future<void> saveTokenToUser(String userId) async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        try {
          await _firestore.collection('users').doc(userId).update({
            'fcmToken': token,
            'lastTokenUpdate': DateTime.now().toIso8601String(),
          });
        } catch (_) {}
      }

      _messaging.onTokenRefresh.listen((newToken) async {
        try {
          await _firestore.collection('users').doc(userId).update({
            'fcmToken': newToken,
            'lastTokenUpdate': DateTime.now().toIso8601String(),
          });
        } catch (_) {}
      });
    } catch (e) {
      debugPrint('Error saving FCM token: $e');
    }
  }

  Future<void> triggerTradeOfferNotification({
    required String receiverUserId,
    required String itemTitle,
    required String senderName,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(receiverUserId)
          .collection('notifications')
          .add({
        'title': 'New Trade Offer!',
        'body': '$senderName sent a barter offer on your item "$itemTitle"',
        'createdAt': DateTime.now().toIso8601String(),
        'isRead': false,
      });
    } catch (e) {
      debugPrint('Error triggering notification record: $e');
    }
  }
}
