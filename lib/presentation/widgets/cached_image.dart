import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final String link;
  final BoxFit fit;
  final bool isExt;

  const CachedImage(
      {Key? key, required this.link, this.fit = BoxFit.fill, this.isExt = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: isExt ? /*ApiConstants.BASE_IMAGE_URL +*/ link : link,
      fit: fit,
      width: double.maxFinite,
      height: double.maxFinite,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: const Color(0xFFEBEBF4),
        highlightColor: const Color(0xFFF4F4F4),
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) {
        return const Icon(
          Icons.error,
          color: Colors.red,
        );
      },
    );
  }
}
