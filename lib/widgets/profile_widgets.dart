import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';

Widget widgetTextField(String label, String data, TextInputType keyboard,
    TextEditingController controller, bool enable) {
  Color secColor = HexColor('#415A80');
  return SizedBox(
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
            child: TextFormField(
              enabled: enable,
              controller: controller,
              keyboardType: keyboard,
              style: const TextStyle(color: Colors.black),
              cursorColor: secColor,
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
                  hintText: data,
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  // labelText: label,
                  suffixIcon: Icon(
                    Icons.edit_outlined,
                    color: secColor,
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget widgetTextFieldRole(String label, String data) {
  Color secColor = HexColor('#415A80');
  return SizedBox(
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
            child: TextFormField(
              controller: TextEditingController(text: data),
              enabled: false,
              style: const TextStyle(color: Colors.black),
              cursorColor: secColor,
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
                  // hintText: data,
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  labelText: '',
                  suffixIcon: Icon(
                    Icons.edit_off_outlined,
                    color: secColor,
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}
