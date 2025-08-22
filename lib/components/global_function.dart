import 'package:flutter/material.dart';

class GlobalFunction {
  final BuildContext context;
  final dynamic parameter;
  GlobalFunction({required this.context, this.parameter});

  void close() {
    Navigator.of(context).pop(parameter);
  }
}
