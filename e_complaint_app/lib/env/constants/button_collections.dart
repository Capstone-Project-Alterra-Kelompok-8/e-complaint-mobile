part of 'constants.dart';

class ButtonCollections {
  static Widget stackedButton(VoidCallback onPressed) {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorCollections.primaryColor,
          ),
        ),
        IconButton(
          icon: Icon(Icons.send, color: ColorCollections.textPrimaryColor),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
