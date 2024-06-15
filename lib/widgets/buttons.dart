import 'package:flutter/material.dart';
import 'package:rental_car/Theme.dart';

class CustomFilledButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  final Color? bgcolor;
  final TextStyle? textColor;

  const CustomFilledButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 40,
    this.onPressed,
    this.bgcolor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: bgcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: textColor,
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomTextButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 24,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          title,
          style: bluetogreenTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
      ),
    );
  }
}

class CustomInputButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CustomInputButton({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: numberBackgroundColor),
        child: Center(
          child: Text(
            title,
            style: whitekTextStyle.copyWith(fontWeight: semiBold, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
