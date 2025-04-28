// Boîte d'alerte personnalisée
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomDialog(bool isAdded) {
  Get.dialog(
    AlertDialog(
      backgroundColor: Colors.white, // Couleur de fond
      insetPadding: EdgeInsets.all(20), // Marge externe
      contentPadding: EdgeInsets.all(20), // Marge interne
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Container(
        width: 300, // Largeur fixe
        height: 250, // Hauteur fixe
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icône
            Icon(
              isAdded ? Icons.favorite : Icons.favorite_border,
              size: 60,
              color: Color(0xFF123880),
            ),

            // Titre
            Text(
              isAdded ? "Ajouté !" : "Retiré !",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            // Message
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                isAdded
                    ? "Ce profil est maintenant dans vos favoris"
                    : "Ce profil a été retiré de vos favoris",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),

            // Bouton
            SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF123880),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () => Get.back(),
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}