import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> uploadToCloudinary2(XFile? file) async {
  if (file == null) return null;

  try {
    final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'];
    final uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET_2'];

    if (cloudName == null || uploadPreset == null) {
      Get.snackbar(
          "Configuration Error",
          "Cloudinary credentials not found. Check your .env file.",
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
      return null;
    }

    final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final request = http.MultipartRequest("POST", uri)
      ..files.add(await http.MultipartFile.fromPath('file', file.path))
      ..fields['upload_preset'] = uploadPreset;

    final response = await request.send();
    final body = await response.stream.bytesToString();
    final jsonResponse = jsonDecode(body);

    if (response.statusCode == 200) {
      Get.snackbar(
          "Upload Successful",
          "Image uploaded to Cloudinary",
          backgroundColor: Color(0xFF123880),
          colorText: Colors.white
      );
      return jsonResponse['secure_url'] as String;
    } else {
      final errorMessage = jsonResponse['error']?['message'] ?? 'Unknown error';
      Get.snackbar(
          "Upload Failed",
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
      return null;
    }
  } catch (e) {
    Get.snackbar(
        "Upload Error",
        "Exception during upload: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white
    );
    return null;
  }
}