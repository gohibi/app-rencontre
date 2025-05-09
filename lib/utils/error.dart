import 'package:flutter/material.dart';

void showCustomizeDialog({
required BuildContext context,
required String title,
required String content,
}){
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    );
  });
}