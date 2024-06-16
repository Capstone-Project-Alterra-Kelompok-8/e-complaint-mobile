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

  static ElevatedButton detailButton({required void Function()? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        minimumSize: Size(97, 31),
        backgroundColor: ColorCollections.buttonColor, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        'Lihat Detail',
        style: TextCollections.detailFont,
      ),
    );
  }
  static ElevatedButton searchButton({required void Function()? onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(299, 40),
      backgroundColor: ColorCollections.buttonColor, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    onPressed: onPressed,
    child: const Text(
      'Cari Aduanku',
      style: TextStyle(
        color: ColorCollections.textSecondaryColor,
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
  }


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
