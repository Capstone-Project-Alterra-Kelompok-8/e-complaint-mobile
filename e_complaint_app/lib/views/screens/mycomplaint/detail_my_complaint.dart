import 'package:e_complaint_app/controllers/my_complaint_controller.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/mycomplaint/components/comment.dart';
import 'package:e_complaint_app/views/screens/mycomplaint/progress_my_complaint.dart';
import 'package:flutter/material.dart';
import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/models/my_complaint_model.dart';
import 'package:gap/gap.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart'; // Import the package for indicators

class DetailMyComplaintScreen extends StatefulWidget {
  final MyComplaintModel complaint;

  const DetailMyComplaintScreen({required this.complaint, Key? key}) : super(key: key);

  @override
  _DetailMyComplaintScreenState createState() => _DetailMyComplaintScreenState();
}

class _DetailMyComplaintScreenState extends State<DetailMyComplaintScreen> {
  final PageController _pageController = PageController(); // PageController for controlling the PageView
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0); // ValueNotifier for page index
  final Map<String, Color> _statusColorMap = {
    'Pending': Colors.grey,
    'Selesai': Colors.green,
    'Ditolak': Colors.red,
    'On Progres': Colors.orange,
    'Verifikasi': Colors.blue,
  };

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the page controller
    _currentPageNotifier.dispose(); // Dispose the ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myComplaintController = Provider.of<MyComplaintController>(context, listen: false);

    return Scaffold(
      appBar: CurvedAppBarMyComplaint(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorCollections.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://storage.googleapis.com/e-complaint-assets/${widget.complaint.user.profilePhoto}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      'Anda',
                      style: TextCollections.headingOne.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'ID: #${widget.complaint.id}',
                          style: TextCollections.headingThree.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue,
                          ),
                    ),
                    trailing: Text(
                        widget.complaint.status,
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: _statusColorMap[widget.complaint.status],
                        ),
                      ),
                  ),
                ),
                // PageView with indicators
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: widget.complaint.files.length,
                        onPageChanged: (index) {
                          _currentPageNotifier.value = index; // Update current page index
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.complaint.files.isNotEmpty
                                      ? widget.complaint.files[index].url
                                      : 'https://via.placeholder.com/91x133.png?text=No+Image',
                                ),

                                fit: BoxFit.cover,
                              
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10.0,
                        child: CirclePageIndicator(
                          selectedDotColor: ColorCollections.primaryColor,
                          itemCount: widget.complaint.files.length,
                          currentPageNotifier: _currentPageNotifier,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.complaint.category.name,
                              style: TextCollections.headingOne.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.comment_outlined),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context, 
                                builder: (context) => CommentMyComplaint(complaintId: widget.complaint.id));
                            },
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Row(
                              children: [
                                Icon(Icons.favorite_border),
                                
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.complaint.regency.name}, ${widget.complaint.date}',
                          style: TextCollections.headingThree.copyWith(
                            fontSize: 14,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Gap(5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.complaint.description,
                          style: TextCollections.headingThree.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Gap(60),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                           
                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ProgressMyComplaintScreen (complaintId: widget.complaint.id,),
                                                    ),
                                                  );
                          },
                          child: Text(
                            'Progress Aduan',
                            style: TextCollections.headingThree.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorCollections.buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
