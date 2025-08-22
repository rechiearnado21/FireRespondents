import 'package:fire_respondents/components/custom_text.dart';

import '../../constants.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final List<dynamic> reports;
  const DetailsScreen({super.key, required this.reports});

  @override
  // ignore: library_private_types_in_public_api
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Add to Cart"),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: ListView.builder(
        itemCount: widget.reports.length,
        itemBuilder: (context, index) {
          final data = widget.reports[index];

          return ListTile(
            leading: CircleAvatar(child: AppText("$index")),
            title: AppText("${data.type}", type: TextType.title),
            subtitle: AppText("${data.description}"),
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: BackButton(color: Colors.black),
      backgroundColor: Color(0xFFF8F8F8),
      elevation: 0,
      centerTitle: true,
      title: Text("Fruits", style: TextStyle(color: Colors.black)),
      actions: [SizedBox(width: defaultPadding)],
    );
  }
}
