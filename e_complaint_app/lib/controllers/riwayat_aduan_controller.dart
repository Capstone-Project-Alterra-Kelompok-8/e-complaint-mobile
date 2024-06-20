import 'package:e_complaint_app/models/riwayat_aduan_model.dart';
import 'package:e_complaint_app/services/riwayat_aduan_service.dart';
import 'package:flutter/material.dart';

class RiwayatAduanController with ChangeNotifier {
  List<bool> _selectedSegments = [true, false, false, false];
  TextEditingController _searchController = TextEditingController();
  List<Complaint> complaints = [];
  List<Complaint> allComplaints = [];
  bool isLoading = true;
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  final RiwayatAduanService _aduankuService = RiwayatAduanService();

  List<bool> get selectedSegments => _selectedSegments;
  TextEditingController get searchController => _searchController;

  RiwayatAduanController() {
    _searchController.addListener(_onSearchChanged);
  }

  void fetchComplaints() async {
    isLoading = true;
    notifyListeners();

    try {
      allComplaints = await _aduankuService.fetchComplaints();
      complaints = allComplaints;
    } catch (e) {
      print('Failed to load complaints: $e');
      _errorMessage = 'Failed to load complaints: $e';
      complaints = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _onSearchChanged() {
    final keyword = _searchController.text.toLowerCase();
    if (keyword.isEmpty) {
      complaints = allComplaints;
    } else {
      complaints = allComplaints.where((complaint) {
        return complaint.name.toLowerCase().contains(keyword) ||
            complaint.description.toLowerCase().contains(keyword) ||
            complaint.categoryName.toLowerCase().contains(keyword) ||
            complaint.regencyName.toLowerCase().contains(keyword);
      }).toList();
    }
    notifyListeners();
  }

  void onSegmentSelected(int index) {
    for (int i = 0; i < _selectedSegments.length; i++) {
      _selectedSegments[i] = i == index;
    }
    sortComplaints(index);
    notifyListeners();
  }

  void sortComplaints(int index) {
    switch (index) {
      case 0:
        complaints.sort((a, b) => a.id.compareTo(b.id));
        break;
      case 1:
        complaints.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case 2:
        complaints.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case 3:
        complaints.sort((a, b) => b.totalLikes.compareTo(a.totalLikes));
        break;
    }
  }

  String getInitials(String name) {
    List<String> nameSplit = name.split(' ');
    String initials = '';
    if (nameSplit.length >= 2) {
      initials = nameSplit[0][0] + nameSplit[1][0];
    } else if (nameSplit.isNotEmpty) {
      initials = nameSplit[0][0];
    }
    return initials.toUpperCase();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
