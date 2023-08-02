import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomTextfieldView extends GetView {
  const CustomTextfieldView({
    Key? key,
    required this.textController,
    required this.title,
    required this.hintText,
    this.isTerm = false,
  }) : super(key: key);

  final TextEditingController textController;
  final String title;
  final String hintText;
  final bool isTerm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        14,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 200,
          ),
          Row(
            children: [
              if (!isTerm)
                Text(
                  'currency'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              if (!isTerm)
                SizedBox(
                  width: MediaQuery.of(context).size.width / 50,
                ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: textController,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: hintText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
