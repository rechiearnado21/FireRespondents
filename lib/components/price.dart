import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  const Price({super.key, required this.amount});
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "\$",
        children: [
          TextSpan(
            text: amount,
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: "/kg",
            style: TextStyle(
              color: Colors.black26,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
