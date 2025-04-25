import 'package:flutter/material.dart';

class CustomFieldText extends StatelessWidget {
  final TextEditingController? editingController;
  final IconData? iconData;
  final String? assetRef;
  final String? labelText;
  final bool? isObscure;
  final TextInputType? keyboardType;


  const CustomFieldText({
    super.key,
    this.editingController,
    this.iconData,
    this.assetRef,
    this.isObscure,
    this.labelText,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      controller: editingController,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: iconData !=  null
            ? Icon(iconData,color: Colors.lightBlue,)
            :Padding(
            padding: EdgeInsets.all(8) ,
            child: Image.asset(assetRef.toString()),
        ),
          labelStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black

          ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.grey,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.grey,
          )
        )
      ),
      obscureText: isObscure!,
    );
  }
}
