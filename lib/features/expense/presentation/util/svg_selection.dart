import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgSelection extends StatelessWidget {
  final String svgName;

  const SvgSelection({super.key, required this.svgName});

  @override
  Widget build(BuildContext context) {
    final String assetName =
        'assets/svg/${svgName.toLowerCase()}.svg';

    return SvgPicture.asset(
      assetName,
      height: 16,
      width: 16,
      allowDrawingOutsideViewBox: true,
      semanticsLabel: 'SVG Asset',
    );
  }
}
