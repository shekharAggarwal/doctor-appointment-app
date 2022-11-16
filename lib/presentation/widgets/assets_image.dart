import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AssetsImage extends StatelessWidget {
  const AssetsImage(this.path,
      {Key? key,
      this.fit = BoxFit.fill,
      required this.height,
      required this.width})
      : super(key: key);
  final String path;
  final BoxFit fit;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: fit,
      height: height,
      width: width,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Icon(
          Icons.error,
          color: Colors.red,
        );
      },
    );
  }
}
