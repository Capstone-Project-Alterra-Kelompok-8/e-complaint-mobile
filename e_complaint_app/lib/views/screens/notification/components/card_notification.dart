import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/models/notification_model.dart';
import 'package:flutter/material.dart';

class CardNotification extends StatelessWidget {
  final NotificationModel notification;

  const CardNotification({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    String title = 'Pemberitahuan';
    String subtitle = '';

    if (notification.discussion != null) {
      title = 'Komentar';
      subtitle = '${notification.discussion!.user?.name ?? notification.discussion!.admin?.name} berkomentar: ${notification.discussion!.comment}';
    } else if (notification.like != null) {
      title = 'Suka';
      subtitle = '${notification.like!.user?.name ?? notification.like!.admin?.name} menyukai kiriman Anda';
    }

    final imageUrl = notification.discussion?.user?.url ?? notification.like?.user?.url ?? notification.discussion?.admin?.url ?? notification.like?.admin?.url ??'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorCollections.secondaryColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 16,
              offset: Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageUrl.startsWith('http')
                    ? NetworkImage(imageUrl)
                    : AssetImage(imageUrl) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            title,
            style: TextCollections.headingOne.copyWith(
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextCollections.headingThree.copyWith(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
