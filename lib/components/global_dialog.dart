import 'package:flutter/material.dart';
import 'package:fire_respondents/components/global_function.dart';

import 'custom_button.dart';
import 'custom_text.dart';

class GlobalDialog {
  final BuildContext context;
  final EdgeInsetsGeometry? padding;
  final Widget? title;
  final Widget? body;
  final Widget? child;
  final VoidCallback? callback;

  GlobalDialog({
    required this.context,
    this.title,
    this.body,
    this.child,
    this.callback,
    this.padding,
  });

  void showGlobalDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
            child:
                child ??
                DefaultDialog(title: title, body: body, callback: callback),
          ),
        );
      },
    );
  }
}

class DefaultDialog extends StatelessWidget {
  final Widget? title;
  final Widget? body;
  final VoidCallback? callback;

  const DefaultDialog({super.key, this.title, this.body, this.callback});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText("My Title Here", type: TextType.title),
              SizedBox(height: 5),
              AppText(
                "Are you sure you want to continue?",
                type: TextType.subtitle,
                fontsize: 16,
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: CustomDisabledButton(bodyText: "No")),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomActiveButton(
                      bodyText: "Yes",
                      callback: () {
                        GlobalFunction(context: context).close();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
