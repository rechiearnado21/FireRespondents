import 'package:flutter/material.dart';
import 'package:fire_respondents/components/custom_text.dart';
import 'package:fire_respondents/components/global_function.dart';

import '../constants.dart';

class CustomActiveButton extends StatelessWidget {
  final String bodyText;
  final VoidCallback callback;
  final bool? isLoading;
  const CustomActiveButton({
    super.key,
    required this.bodyText,
    required this.callback,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primaryColor,
        ),
        child: Center(
          child: isLoading!
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : AppText(
                  bodyText,
                  type: TextType.subtitle,
                  color: Colors.white,
                  fontweight: FontWeight.bold,
                ),
        ),
      ),
    );
  }
}

class CustomDisabledButton extends StatelessWidget {
  final String bodyText;
  final VoidCallback? callback;
  const CustomDisabledButton({
    super.key,
    required this.bodyText,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          callback ??
          () {
            GlobalFunction(context: context).close();
          },
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: disabledBtn,
        ),
        child: Center(
          child: AppText(
            bodyText,
            type: TextType.subtitle,
            color: primaryColor,
            fontweight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
