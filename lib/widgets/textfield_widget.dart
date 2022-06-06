import 'package:flutter/material.dart';

Widget textfield(String label, IconData prefixIcon) {
  return TextField(
    autocorrect: true,
    decoration: InputDecoration(
      hintText: label,
      prefixIcon: Icon(prefixIcon),
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white70,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
    ),
  );
}