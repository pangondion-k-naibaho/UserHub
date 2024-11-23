import 'package:flutter/material.dart';
import 'AppColors.dart';

class AppBackgrounds {
  // 1. bg_bottomsheet.xml
  static BoxDecoration bottomSheetDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    ),
    border: Border.all(
      width: 1.0,
      color: AppColors.black50,
    ),
  );

  // 2. bg_circle_grey_white.xml
  static BoxDecoration circleGreyWhite = BoxDecoration(
    color: AppColors.white,
    shape: BoxShape.circle,
    border: Border.all(
      width: 1.0,
      color: AppColors.grey,
    ),
  );

  // 3. bg_circle_hibiscus.xml
  static BoxDecoration circleHibiscus = BoxDecoration(
    color: AppColors.socialist, // Menggunakan socialist yang lebih relevan
    shape: BoxShape.circle,
  );

  // 4. bg_circular_rectangle_white.xml
  static BoxDecoration circularRectangleWhite = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(5.0),
  );

  // 5. bg_circular_rectangle_white_grey.xml
  static BoxDecoration circularRectangleWhiteGrey = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
      width: 2.0,
      color: AppColors.grey,
    ),
  );

  // 6. bg_rectangle_dustblu.xml
  static BoxDecoration rectangleDustblu = BoxDecoration(
    color: AppColors.dustblu,
    borderRadius: BorderRadius.circular(2.0),
  );

  // 7. bg_rectangle_red_white.xml
  static BoxDecoration rectangleRedWhite = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(
      width: 1.0,
      color: AppColors.red,
    ),
  );

  // 8. bg_rectangle_satin_white.xml
  static BoxDecoration rectangleSatinWhite = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(
      width: 1.0,
      color: AppColors.satinWhite,
    ),
  );

  // 9. bg_rectangle_socialist.xml
  static BoxDecoration rectangleSocialist = BoxDecoration(
    color: AppColors.socialist,
    borderRadius: BorderRadius.circular(8.0),
  );

  // 10. bg_rectangle_socialist_white.xml
  static BoxDecoration rectangleSocialistWhite = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(
      width: 1.0,
      color: AppColors.socialist,
    ),
  );

  // 11. bg_rectangle_white.xml
  static BoxDecoration rectangleWhite = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16.0),
  );
}
