import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../size_config.dart';

class MyInputField extends StatelessWidget {
  const MyInputField(
      {super.key,
      required this.hint,
      this.readOnly = false,
      this.controller,
      this.widget});

  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //padding: EdgeInsets.all(20),
        margin: const EdgeInsets.all(14),
        child: Container(
          padding: const EdgeInsets.only(left: 14),
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
          //width: SizeConfig.screenWidth - 40,
          height: 52,
          // alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  autofocus: false,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  readOnly: readOnly,
                  decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 0),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 0),
                      ),
                      hintText: hint,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.grey,
                      )),
                ),
              ),
              widget ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
