import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      this.color = Colors.white30,
      required this.icon});
  // final Function onTap;
  final VoidCallback onTap; // Thay đổi kiểu từ Function sang VoidCallback
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: color),
        child: Icon(icon),
      ),
    );
  }
}
