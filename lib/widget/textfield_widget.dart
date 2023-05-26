import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final int maxLines;
  final String hintText;
  final TextEditingController textEditingController;

  const TextFieldWidget({
    super.key,
    required this.maxLines,
    required this.hintText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText),
        maxLines: maxLines,
      ),
    );
  }
}
