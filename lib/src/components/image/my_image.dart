import 'package:benji/src/repo/utils/constants.dart';
import 'package:benji/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final String? url;
  final double radiusTop;
  final double radiusBottom;

  const MyImage(
      {super.key, this.url, this.radiusTop = 15, this.radiusBottom = 15});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusTop),
          topRight: Radius.circular(radiusTop),
          bottomLeft: Radius.circular(radiusBottom),
          bottomRight: Radius.circular(radiusBottom)),
      child: CachedNetworkImage(
        imageUrl: url == null ? '' : url!.startsWith("https") ? url! :  baseImage + url!,
        width: double.infinity,
        height: double.infinity,
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover, // Use BoxFit.fill to fill the parent container
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Center(child: CupertinoActivityIndicator(color: kAccentColor)),
        errorWidget: (context, url, error) =>
            Icon(Icons.error, color: kAccentColor),
      ),
    );
  }
}
