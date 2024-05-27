import 'package:flutter/material.dart';

import '../model/photo_model.dart';

class PhototView extends StatefulWidget {
  final PhotoModel photo;
  const PhototView({super.key, required this.photo});

  @override
  State<PhototView> createState() => _PhototViewState();
}

class _PhototViewState extends State<PhototView> {
  @override
  Widget build(BuildContext context) {
    return Image.network(widget.photo.url,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
      return child;
    }, loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      }
    }, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
      return Container(
          color: Colors.grey[200], child: Icon(Icons.broken_image));
    });
  }
}
