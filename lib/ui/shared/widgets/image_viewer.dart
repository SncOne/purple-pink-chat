import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';

class ImageViewerPage extends StatelessWidget {
  final String imageUrl;

  const ImageViewerPage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: generateRandomString(15),
              child: CustomImage.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                context.maybePop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
