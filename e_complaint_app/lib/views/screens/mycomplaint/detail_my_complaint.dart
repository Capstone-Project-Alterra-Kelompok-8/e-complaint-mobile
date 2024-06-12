import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/models/my_complaint_model.dart';
import 'package:e_complaint_app/views/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailMyComplaintScreen extends StatelessWidget {
  final MyComplaintModel complaint;

  const DetailMyComplaintScreen({required this.complaint, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CarouselController _controller = CarouselController();

    return Scaffold(
      appBar: CurvedAppBar(),
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
                          image: NetworkImage('https://storage.googleapis.com/e-complaint-assets/${complaint.user.profilePhoto}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      complaint.user.name,
                      style: TextCollections.headingOne.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Anonim',
                      style: TextCollections.headingThree.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                // slider
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CarouselSlider.builder(
                            carouselController: _controller,
                            itemCount: complaint.files.length,
                            options: CarouselOptions(
                              aspectRatio: 1.0,
                              height: 200,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.8,
                            ),
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(complaint.files[index].url),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 6, color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
                              complaint.category.name,
                              style: TextCollections.headingOne.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.comment_outlined),
                            onPressed: () {},
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Row(
                              children: [
                                Icon(Icons.favorite_border),
                                Text(
                                  '10Rb',
                                  style: TextCollections.headingThree.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          complaint.regency.name,
                          style: TextCollections.headingThree.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Gap(5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ID: #${complaint.id}',
                          style: TextCollections.headingThree.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          complaint.description,
                          style: TextCollections.headingThree.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Gap(60),
                      Text(
                        'Selesai',
                          style: TextCollections.headingThree.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Colors.blue,
                        ),
                      ),
                      Gap(10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/progress_aduanku');
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
