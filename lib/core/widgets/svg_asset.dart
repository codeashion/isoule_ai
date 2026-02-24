import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class SvgAsset extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;

  const SvgAsset(this.path, {super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      fit: BoxFit.contain,
    );
  }
}
