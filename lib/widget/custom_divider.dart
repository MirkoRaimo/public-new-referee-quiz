import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        SizedBox(
          width: 16.0,
        ),
        Text("Beta"),
        SizedBox(
          width: 16.0,
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
