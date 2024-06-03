import 'package:e_complaint_app/views/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/riwayat_aduan/aduan_card.dart';
import 'package:flutter/material.dart';

class RiwayatAduan extends StatefulWidget {
  const RiwayatAduan({Key? key}) : super(key: key);

  @override
  State<RiwayatAduan> createState() => _RiwayatAduanState();
}

class _RiwayatAduanState extends State<RiwayatAduan> {
  List<bool> _selectedSegments = [true, false, false, false];
  TextEditingController _searchController = TextEditingController();

  void _onSegmentSelected(int index) {
    setState(() {
      for (int i = 0; i < _selectedSegments.length; i++) {
        _selectedSegments[i] = i == index;
      }
    });
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
            child: _getSegmentContent(),
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
    if (_selectedSegments[0]) {
      return ListView(
        children: const [
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
        ],
      );
    } else if (_selectedSegments[1]) {
      return ListView(
        children: const [
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
        ],
      );
    } else if (_selectedSegments[2]) {
      return ListView(
        children: const [
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
        ],
      );
    } else if (_selectedSegments[3]) {
      return ListView(
        children: const [
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
          AduanCard(),
        ],
      );
    }
    return const Text('Select a segment');
  }
}
