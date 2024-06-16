// views/screens/riwayat_aduan/riwayat_aduan.dart
import 'package:e_complaint_app/controllers/riwayat_aduan_controller.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/riwayat_aduan/aduan_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RiwayatAduan extends StatelessWidget {
  const RiwayatAduan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RiwayatAduanController()..fetchComplaints(),
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
                          // Handle filter action
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
    return ListView.builder(
      itemCount: controller.complaints.length,
      itemBuilder: (context, index) {
        return AduanCard(
          id: controller.complaints[index].id,
          name: controller.complaints[index].name,
          initials: controller.getInitials(controller.complaints[index].name),
          description: controller.complaints[index].description,
          category: controller.complaints[index].categoryName,
          regency: controller.complaints[index].regencyName,
          status: controller.complaints[index].status,
          profilePhoto: controller.complaints[index].profilePhoto,
          files: controller.complaints[index].files,
          totalLikes: controller.complaints[index].totalLikes,
          date: controller.complaints[index].date,
        );
      },
    );
  }
}
