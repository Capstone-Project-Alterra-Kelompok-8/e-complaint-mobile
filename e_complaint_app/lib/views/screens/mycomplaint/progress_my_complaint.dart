import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/my_complaint_controller.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/mycomplaint/components/dashline_painter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProgressMyComplaintScreen extends StatefulWidget {
  final String complaintId;

  const ProgressMyComplaintScreen({super.key, required this.complaintId});

  @override
  State<ProgressMyComplaintScreen> createState() => _ProgressMyComplaintScreenState();
}

class _ProgressMyComplaintScreenState extends State<ProgressMyComplaintScreen> {
  @override
  void initState() {
    super.initState();
    final controller = context.read<MyComplaintController>();
    controller.getComplaintProcesses(widget.complaintId);
  }

  @override
  Widget build(BuildContext context) {
    final myComplaintController = Provider.of<MyComplaintController>(context);
    if (!myComplaintController.isLoaded) {
      myComplaintController.getComplaintProcesses(widget.complaintId);
    }
    return Scaffold(
      appBar: CurvedAppBarMyComplaint(),
      body: Consumer<MyComplaintController>(
        builder: (context, controller, child) {
          if (!controller.isLoaded) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage));
          }

          if (controller.myComplaintProses.isEmpty) {
            return Center(child: Text('No progress found for this complaint.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorCollections.secondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Proses Aduan'.toUpperCase(),
                        style: TextCollections.headingThree.copyWith(
                          color: ColorCollections.textPrimaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.myComplaintProses.length,
                      itemBuilder: (context, index) {
                        final proses = controller.myComplaintProses[index];
                        final iconColor = _getStatusColor(proses.status);
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.circle_outlined,
                                  color: iconColor,
                                  size: 30,
                                ),
                                if (index != controller.myComplaintProses.length - 1)
                                  CustomPaint(
                                    size: Size(1, 100), // Adjust the height as needed
                                    painter: DashedLinePainter(),
                                  ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    proses.status,
                                    style: TextCollections.primaryFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: iconColor,
                                    ),
                                  ),
                                  Text(
                                    proses.admin.name,
                                    style: TextCollections.headingTwo.copyWith(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    proses.date,
                                    style: TextCollections.headingThree.copyWith(
                                      fontSize: 14,
                                      color: Color(0xEC5A5A5A),
                                    ),
                                  ),
                                  Text(
                                    proses.message,
                                    style: TextCollections.headingThree.copyWith(
                                      fontSize: 14,
                                      color: Color(0xEC5A5A5A),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.grey[600]!;
      case 'Verifikasi':
        return Colors.blueAccent[700]!;
      case 'On Progress':
        return Colors.yellow[700]!;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
