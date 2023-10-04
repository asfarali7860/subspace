import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final String placeholderImageAsset;

  ImageLoader({required this.imageUrl, required this.placeholderImageAsset});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Display the placeholder image if loading from the URL failed.
        return Image.asset(placeholderImageAsset);
      },
    );
  }
}
