import 'package:e_complaint_app/controllers/riwayat_aduan_controller.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/riwayat_aduan/components/aduan_card.dart';
import 'package:e_complaint_app/views/screens/riwayat_aduan/components/filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RiwayatAduan extends StatefulWidget {
  final int initialSegment;
  const RiwayatAduan({Key? key, required this.initialSegment})
      : super(key: key);

  @override
  _RiwayatAduanState createState() => _RiwayatAduanState();
}

class _RiwayatAduanState extends State<RiwayatAduan> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          Provider.of<RiwayatAduanController>(context, listen: false);
      controller.onSegmentSelected(widget.initialSegment);
      controller.fetchComplaints();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RiwayatAduanController(widget.initialSegment)..fetchComplaints(),
      child: Scaffold(
        appBar: CurvedAppBar(),
        body: Consumer<RiwayatAduanController>(
          builder: (context, controller, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari aduan...',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: ImageIcon(
                          AssetImage('assets/images/icon_filter.png'),
                        ),
                        onPressed: () {
                          _showFilterSheet(context);
                        },
                      ),
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
                      _buildSegmentButton(context, 'Semua', 0),
                      _buildSegmentButton(context, 'Terbaru', 1),
                      _buildSegmentButton(context, 'Terlama', 2),
                      _buildSegmentButton(context, 'Terfavorit', 3),
                    ],
                  ),
                ),
                Expanded(
                  child: controller.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : controller.errorMessage.isNotEmpty
                          ? Center(child: Text(controller.errorMessage))
                          : _getSegmentContent(controller),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Filter(
          onCategorySelected: (category) {
            setState(() {
              _selectedCategory = category;
            });
          },
          initialCategory: _selectedCategory,
        );
      },
    );
  }

  Widget _buildSegmentButton(BuildContext context, String text, int index) {
    final controller =
        Provider.of<RiwayatAduanController>(context, listen: false);
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.onSegmentSelected(index),
        child: Container(
          alignment: Alignment.center,
          height: 40,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: controller.selectedSegments[index]
                    ? const Color(0xFFEAB308)
                    : Colors.transparent,
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: controller.selectedSegments[index]
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
              fontWeight: controller.selectedSegments[index]
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSegmentContent(RiwayatAduanController controller) {
    final complaints = _selectedCategory == null
        ? controller.complaints
        : controller.complaints
            .where((complaint) => complaint.categoryName == _selectedCategory)
            .toList();
    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        return AduanCard(
          id: complaints[index].id,
          name: complaints[index].name,
          initials: controller.getInitials(complaints[index].name),
          description: complaints[index].description,
          category: complaints[index].categoryName,
          regency: complaints[index].regencyName,
          status: complaints[index].status,
          profilePhoto: complaints[index].profilePhoto,
          files: complaints[index].files,
          totalLikes: complaints[index].totalLikes,
          date: complaints[index].date,
        );
      },
    );
  }
}
