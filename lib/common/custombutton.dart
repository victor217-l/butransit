import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final Color? color;
  final bool isLoading;
  const CustomButton({super.key, required this.onTap, required this.text, this.color,  this.isLoading = false});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isLoading ? null : widget.onTap,
      child: Center(child: Text(widget.text)
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0))),
        minimumSize: Size(
        double.infinity, 50),
        primary: widget.color),
    );
  }
}
