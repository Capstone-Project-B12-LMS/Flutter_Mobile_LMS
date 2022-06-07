import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';

Widget widgetTextField(String label, TextInputType keyboard) {
  return SizedBox(
    // width: MediaQuery.of(context).size.width,
    height: 100,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade200),
            child: TextField(
              keyboardType: keyboard,
              style: const TextStyle(color: Colors.black),
              cursorColor: HexColor('#FF997A'),
              decoration: InputDecoration(
                  fillColor: Colors.black,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 20),
                  // enabled: false,
                  // focusColor: Colors.grey,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10)),
                  // errorText: err,
                  // errorBorder: OutlineInputBorder(
                  //     borderSide: const BorderSide(color: Colors.red),
                  //     borderRadius: BorderRadius.circular(20)),
                  hintText: label,
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  // labelText: label,
                  suffixIcon: Icon(
                    Icons.edit_outlined,
                    color: HexColor('#FF997A'),
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}