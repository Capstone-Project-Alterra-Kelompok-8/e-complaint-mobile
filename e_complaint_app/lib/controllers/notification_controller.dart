import 'package:e_complaint_app/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_complaint_app/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  List<NotificationModel> _allNotifications = [];
  List<NotificationModel> _filteredNotifications = [];
  bool _isLoaded = false;
  String _errorMessage = '';

  List<NotificationModel> get notifications => _filteredNotifications;
  bool get isLoaded => _isLoaded;
  String get errorMessage => _errorMessage;

  Future<void> getNotification() async {
    try {
      final response = await _notificationService.getNotification();
      print('Response: $response');

      if (response != null && response.statusCode == 200) {
        _allNotifications.clear();
        final Map<String, dynamic> responseData = response.data;

        if (responseData.containsKey('data')) {
          final List<dynamic> notificationData = responseData['data'];

          notificationData.forEach((item) {
            final notification = NotificationModel.fromJson(item);
            _allNotifications.add(notification);
          });
          _errorMessage = '';
          print('Notifications loaded successfully');
          _filteredNotifications = _allNotifications;
        } else {
          _errorMessage = 'Data field is missing in the response';
        }
      } else {
        _errorMessage = 'Failed to load Notification: ${response?.statusCode}';
        print('Response is empty or request failed: ${response?.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('Error: $e');
    } finally {
      _isLoaded = true;
      notifyListeners();
    }
  }

  void filterNotifications(String category) {
    switch (category) {
      case 'like':
        _filteredNotifications = _allNotifications.where((n) => n.like != null).toList();
        break;
      case 'comment':
        _filteredNotifications = _allNotifications.where((n) => n.discussion != null).toList();
        break;
      case 'all':
      default:
        _filteredNotifications = _allNotifications;
        break;
    }
    notifyListeners();
  }
}
