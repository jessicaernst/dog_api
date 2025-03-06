import 'package:flutter/material.dart';

class DogImageFrame extends StatelessWidget {
  const DogImageFrame({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imageUrl,
        height: 300,
        width: 300,
        fit: BoxFit.cover,
      ),
    );
  }
}
