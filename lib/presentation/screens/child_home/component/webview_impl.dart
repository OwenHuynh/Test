import 'package:flutter/material.dart';

class WebViewSizedChild extends StatelessWidget {
  const WebViewSizedChild({
    required this.width,
    required this.height,
    required this.builder,
  });

  final double? width;
  final double? height;
  final Widget Function(double, double) builder;

  @override
  Widget build(BuildContext context) {
    if (width != null && height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: builder(width!, height!),
      );
    }
    return LayoutBuilder(
      builder: (context, dimens) {
        final w = width ?? dimens.maxWidth;
        final h = height ?? dimens.maxHeight;
        return SizedBox(
          width: w,
          height: h,
          child: builder(w, h),
        );
      },
    );
  }
}
