import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomImage({
    Key? key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If imageUrl is null, return a default placeholder
    if (imageUrl == null || imageUrl!.isEmpty) {
      return placeholder ?? Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        child: Center(
          child: Icon(
            Icons.image_outlined,
            color: Colors.grey.shade500,
            size: width != null && height != null
                ? (width! + height!) * 0.1
                : 50,
          ),
        ),
      );
    }

    return Image.network(
      imageUrl!,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ??
            Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey,
              child: Icon(
                Icons.broken_image,
                color: Colors.white,
                size: width != null && height != null
                    ? (width! + height!) * 0.1
                    : 50,
              ),
            );
      },
    );
  }
}