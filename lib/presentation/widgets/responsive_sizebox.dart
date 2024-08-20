import 'package:flutter/material.dart';

class ResponsiveSizedBox extends StatelessWidget {
  final double sizedBoxHeight;
  const ResponsiveSizedBox({super.key, required this.sizedBoxHeight});

  @override
  Widget build(BuildContext context) {


    return SizedBox(height: sizedBoxHeight);
  }
}
