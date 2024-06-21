import 'package:e_complaint_app/controllers/notification_controller.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/notification/components/card_notification.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:e_complaint_app/constants/constants.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedIndex = 0; // Variabel untuk melacak tombol aktif

  @override
  void initState() {
    super.initState();
    // Fetch initial notifications for "Semua Aktivitas"
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationController>(context, listen: false).getNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationController = Provider.of<NotificationController>(context);

    return Scaffold(
      appBar: const CurvedAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 0 ? ColorCollections.buttonColor : ColorCollections.backgroundColor,
                    enabledMouseCursor: MouseCursor.defer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: ColorCollections.buttonColor),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                    notificationController.filterNotifications('all');
                  },
                  child: Text(
                    'Semua Aktivitas',
                    style: TextCollections.headingThree.copyWith(
                      color: selectedIndex == 0 ? Colors.white : ColorCollections.buttonColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 1 ? ColorCollections.buttonColor : ColorCollections.backgroundColor,
                    enabledMouseCursor: MouseCursor.defer,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorCollections.buttonColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    notificationController.filterNotifications('like');
                  },
                  child: Text(
                    'Suka',
                    style: TextCollections.headingThree.copyWith(
                      color: selectedIndex == 1 ? Colors.white : ColorCollections.buttonColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 2 ? ColorCollections.buttonColor : ColorCollections.backgroundColor,
                    enabledMouseCursor: MouseCursor.defer,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorCollections.buttonColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                    notificationController.filterNotifications('comment');
                  },
                  child: Text(
                    'Komentar',
                    style: TextCollections.headingThree.copyWith(
                      color: selectedIndex == 2 ? Colors.white : ColorCollections.buttonColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Gap(20),
            notificationController.isLoaded
                ? notificationController.notifications.isEmpty
                    ? Center(child: Text('No notifications available'))
                    : ListView.builder(
                        itemBuilder: (context, index) => CardNotification(notification: notificationController.notifications[index]),
                        itemCount: notificationController.notifications.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
