part of 'constants.dart';

class ButtonCollections {
  static ElevatedButton loginButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorCollections.buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    onPressed: () {},
    child: const Padding(
      padding: EdgeInsets.all(PaddingCollections.paddingButtonLarge),
      child: Text(
        'Login',
        style: TextStyle(
          color: ColorCollections.textSecondaryColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  
}