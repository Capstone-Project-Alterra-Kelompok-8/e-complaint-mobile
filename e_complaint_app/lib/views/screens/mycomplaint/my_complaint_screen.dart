import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/my_complaint_controller.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/mycomplaint/detail_my_complaint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyComplaintScreen extends StatefulWidget {
  const MyComplaintScreen({Key? key}) : super(key: key);

  @override
  State<MyComplaintScreen> createState() => _MyComplaintScreenState();
}

class _MyComplaintScreenState extends State<MyComplaintScreen> {
  final Map<String, Color> _statusColorMap = {
    'Pending': Colors.grey,
    'Selesai': Colors.green,
    'Ditolak': Colors.red,
    'On Progres': Colors.orange,
    'Verifikasi': Colors.blue,
  };

  String? _selectedStatus;

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 5,
                        width: 50,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            final myComplaintController = Provider.of<MyComplaintController>(context, listen: false);
                            myComplaintController.clearFilter();
                            Navigator.of(context).pop();
                            setState(() {
                              _selectedStatus = null;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Filter',
                          style: TextCollections.headingThree,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'Pilih Status',
                      style: TextCollections.headingThree,
                    ),
                    const SizedBox(height: 16),
                    ..._statusColorMap.entries.map((entry) => _buildStatusOption(entry.key, entry.value, TextCollections.filterFont)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonCollections.searchButton(
                          onPressed: () {
                            final myComplaintController = Provider.of<MyComplaintController>(context, listen: false);
                            myComplaintController.setFilterStatus(_selectedStatus);
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

Widget _buildStatusOption(String status, Color color, TextStyle textStyle) {
  return ListTile(
    leading: Radio<String>(
      value: status,
      groupValue: _selectedStatus,
      onChanged: (String? value) {
        setState(() {
          _selectedStatus = value;
        });
      },
      activeColor: color,
      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return color; // Color when selected
        }
        return Colors.orange; // Default color for unselected state
      }),
      overlayColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return color.withOpacity(0.3); // Slightly transparent color when pressed
        }
        return Colors.transparent; // No overlay color when not pressed
      }),
    ),
    title: Text(status, style: textStyle),
  );
}


  @override
  Widget build(BuildContext context) {
    final myComplaintController = Provider.of<MyComplaintController>(context);
    if (!myComplaintController.isLoaded) {
      myComplaintController.getMyComplaint();
    }
    return Scaffold(
      appBar: CurvedAppBarMyComplaint(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Aduanku',
                  style: TextCollections.titleFont,
                ),
                IconButton(
                  icon: ImageIcon(
                    const AssetImage('assets/images/icon_filter.png'),
                    size: 40,
                  ),
                  onPressed: _showFilterBottomSheet,
                ),
              ],
            ),
          ),
          Expanded(
            child: myComplaintController.isLoaded
                ? myComplaintController.filteredComplaints.isNotEmpty
                    ? ListView.builder(
                        itemCount: myComplaintController.filteredComplaints.length,
                        itemBuilder: (context, index) {
                          final complaint = myComplaintController.filteredComplaints[index];
                          final Color statusColor = _statusColorMap[complaint.status] ?? Colors.grey;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: Image.network(
                                        complaint.files.isNotEmpty
                                            ? complaint.files[0].url
                                            : 'https://via.placeholder.com/91x133.png?text=No+Image',
                                        width: 91,
                                        height: 133,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.network(
                                            'https://via.placeholder.com/91x133.png?text=No+Image',
                                            width: 91,
                                            height: 133,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            complaint.updatedAt,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            complaint.category.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            complaint.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              ButtonCollections.detailButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => DetailMyComplaintScreen(complaint: complaint),
                                                    ),
                                                  );
                                                },
                                              ),
                                              const SizedBox(width: 10),
                                              Container(
                                                width: 91,
                                                height: 31,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(
                                                    color: statusColor,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    complaint.status,
                                                    style: TextStyle(
                                                      color: statusColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('No complaints available'))
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}