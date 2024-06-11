import 'package:flutter/material.dart';
import 'package:e_complaint_app/models/news_model.dart';
import 'package:e_complaint_app/services/news_service.dart';

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

      print('getNews response: $response');

      if (response != null && response.statusCode == 200) {
        _news.clear();
        final Map<String, dynamic> responseData = response.data;
        if (responseData.containsKey('data')) {
          final List<dynamic> newsData = responseData['data'];
          newsData.forEach((item) {
            final news = NewsModel.fromJson(item);
            _news.add(news);
          });

          print('getNews berhasil dimuat');
          print(': $_news');
        } else {
          _errorMessage = 'Data field is missing in the response';
        }
      } else {
        _errorMessage = 'Failed to load news: ${response?.statusCode}';
        print('Response kosong atau tidak berhasil: ${response?.statusCode}');
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
}


  // Future<void> getNews() async {
  //   try {
  //     List<NewsModel> news = await _newsService.getNews();
  //     _news = news;
  //     _errorMessage = ''; // Clear any previous error message
  //     notifyListeners();
  //   } catch (error) {
  //     if (error is DioError) {
  //       if (error.response?.statusCode == 401) {
  //         _errorMessage = 'Unauthorized. Please check your credentials.';
  //       } else {
  //         _errorMessage = 'Error fetching news: ${error.message}';
  //       }
  //     } else {
  //       _errorMessage = 'Unexpected error: $error';
  //     }
  //     notifyListeners(); // Notify listeners of the error state
  //   }
  // }