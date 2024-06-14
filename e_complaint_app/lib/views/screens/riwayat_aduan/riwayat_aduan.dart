import 'package:e_complaint_app/models/riwayat_aduan_model.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/riwayat_aduan/aduan_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RiwayatAduan extends StatefulWidget {
  const RiwayatAduan({Key? key}) : super(key: key);

  @override
  State<RiwayatAduan> createState() => _RiwayatAduanState();
}

class _RiwayatAduanState extends State<RiwayatAduan> {
  List<bool> _selectedSegments = [true, false, false, false];
  TextEditingController _searchController = TextEditingController();
  List<Complaint> complaints = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  void _onSegmentSelected(int index) {
    setState(() {
      for (int i = 0; i < _selectedSegments.length; i++) {
        _selectedSegments[i] = i == index;
      }
    });
  }

  Future<void> fetchComplaints() async {
    final response = await http.get(
      Uri.parse(
          'https://capstone-dev.mdrizki.my.id/api/v1/complaints?sort_by=id&sort_type=desc'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM'
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<Complaint> fetchedComplaints = (jsonResponse['data'] as List)
          .map((data) => Complaint.fromJson(data))
          .toList();
      setState(() {
        complaints = fetchedComplaints;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load complaints');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari aduan...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSegmentButton('Semua', 0),
                _buildSegmentButton('Terbaru', 1),
                _buildSegmentButton('Terlama', 2),
                _buildSegmentButton('Terfavorit', 3),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : _getSegmentContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onSegmentSelected(index),
        child: Container(
          alignment: Alignment.center,
          height: 40,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _selectedSegments[index]
                    ? const Color(0xFFEAB308)
                    : Colors.transparent,
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: _selectedSegments[index]
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
              fontWeight: _selectedSegments[index]
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSegmentContent() {
    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        return AduanCard(
          id: complaints[index].id,
          name: complaints[index].name,
          initials: _getInitials(complaints[index].name),
          description: complaints[index].description,
          category: complaints[index].categoryName,
          regency: complaints[index].regencyName,
          status: complaints[index].status,
          profilePhoto: complaints[index].profilePhoto,
          files: complaints[index].files,
          totalLikes: complaints[index].totalLikes,
        );
      },
    );
  }

  String _getInitials(String name) {
    List<String> nameSplit = name.split(' ');
    String initials = '';
    if (nameSplit.length >= 2) {
      initials = nameSplit[0][0] + nameSplit[1][0];
    } else if (nameSplit.isNotEmpty) {
      initials = nameSplit[0][0];
    }
    return initials.toUpperCase();
  }
}
