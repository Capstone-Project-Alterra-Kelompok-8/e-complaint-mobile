import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:e_complaint_app/models/news_model.dart';
import 'package:e_complaint_app/services/news_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NewsController extends ChangeNotifier {
  final NewsService _newsService = NewsService();
  List<NewsModel> _news = [];
  String _errorMessage = '';
  bool _isLoaded = false;
  List<NewsModel> _filteredNews = [];

  List<NewsModel> get news => _filteredNews.isEmpty ? _news : _filteredNews;
  String get errorMessage => _errorMessage;
  bool get isLoaded => _isLoaded;

  Future<void> getNews() async {
    try {
      final response = await _newsService.getNews();

      if (response != null && response.statusCode == 200) {
        _news.clear();
        final Map<String, dynamic> responseData = response.data;

        if (responseData.containsKey('data') && responseData['data'] is List) {
          final List<dynamic> newsData = responseData['data'];
          for (var item in newsData) {
            if (item is Map<String, dynamic>) {
              final news = NewsModel.fromJson(item);
              _news.add(news);
            }
          }

          _errorMessage = ''; // Clear error message if successful
          print('News loaded successfully: $_news');
        } else {
          _errorMessage = 'Data field is missing or not a list in the response';
          print('Data field is missing or not a list in the response');
        }
      } else if (response?.statusCode == 404) {
        _errorMessage = response.data['message'] ?? 'Not found';
        print('Error: ${response.data['message']}');
      } else {
        _errorMessage = 'Failed to load news: ${response?.statusCode}';
        print('Failed to load news: ${response?.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('Error: $e');
    } finally {
      _isLoaded = true; // Only update status if request is completed
      notifyListeners();
    }
  }

  void filterNews(String query) {
    if (query.isEmpty) {
      _filteredNews = _news;
    } else {
      _filteredNews = _news
          .where((news) => news.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  List<NewsModel> getLatestNews(int count) {
    List<NewsModel> sortedNews = List.from(_news)
      ..sort((a, b) => b.id.compareTo(a.id));
    return sortedNews.take(count).toList();
  }
}


class NewsCommentController extends ChangeNotifier {
  final NewsCommentService _newsCommentService = NewsCommentService();
  List<NewsCommentModel> _newsComments = [];
  String _errorMessage = '';
  bool _isLoaded = false;

  List<NewsCommentModel> get newsComments => _newsComments;
  String get errorMessage => _errorMessage;
  bool get isLoaded => _isLoaded;

  Future<void> getNewsComment(String newsId) async {
    try {
      final response = await _newsCommentService.getNewsComment(newsId);

      if (response != null && response.statusCode == 200) {
        _newsComments.clear();
        final Map<String, dynamic> responseData = response.data;
        if (responseData.containsKey('data')) {
          final List<dynamic> newsCommentData = responseData['data'];
          for (var item in newsCommentData) {
            if (item is Map<String, dynamic>) {
              final newsComment = NewsCommentModel.fromJson(item);
              _newsComments.add(newsComment);
            }
          }
          _errorMessage = ''; // Clear error message if successful
          print('Comments loaded successfully: $_newsComments');
        } else {
          _errorMessage = 'Data field is missing in the response';
          print('Data field is missing in the response');
        }
      } else if (response?.statusCode == 404) {
        _errorMessage = response.data['message'];
        print('Error: ${response.data['message']}');
      } else {
        _errorMessage = 'Failed to load news comments: ${response?.statusCode}';
        print('Failed to load news comments: ${response?.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('Error: $e');
    } finally {
      _isLoaded = true; // Only update status if request is completed
      notifyListeners();
    }
  }

   Future<void> postNewsComment(String newsId, String comment) async {
    try {
      final response = await _newsCommentService.postNewsComment(newsId, comment);
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        await getNewsComment(newsId); // Refresh comments after posting a new one
        _errorMessage = ''; // Clear error message if successful
        print('Comment posted successfully');
      } else {
        _errorMessage = 'Failed to post comment: ${response?.statusCode}';
        print('Failed to post comment: ${response?.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('Error: $e');
    } finally {
      notifyListeners();
    }
  }


  Future<void> saveComments(List<NewsCommentModel> comments) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> commentsJson = comments.map((comment) => jsonEncode(comment.toJson())).toList();
    await prefs.setStringList('comments', commentsJson);
  }

  Future<void> loadComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? commentsJson = prefs.getStringList('comments');

    if (commentsJson != null) {
      _newsComments = commentsJson.map((commentJson) => NewsCommentModel.fromJson(jsonDecode(commentJson))).toList();
    } else {
      _newsComments = [];
    }

    notifyListeners();
  }
}