import 'package:components/utils/ext/num_extension.dart';
import 'package:flutter/material.dart';

List<BoxShadow> getBoxShadow(
        {int num = 1,
        Color color = Colors.black12,
        double? radius,
        BlurStyle blurStyle = BlurStyle.normal,
        double blurRadius = 0.05,
        double spreadRadius = 0.05,
        Offset? offset}) =>
    num.generate((index) => BoxShadow(
        color: color,
        blurStyle: blurStyle,
        blurRadius: radius ?? blurRadius,
        spreadRadius: radius ?? spreadRadius,
        offset: offset ?? Offset.zero));

class PlaceholderChild extends StatelessWidget {
  const PlaceholderChild(
      {Key? key,
      this.padding = const EdgeInsets.all(100),
      this.child,
      this.text = 'There is no data'})
      : super(key: key);

  final EdgeInsetsGeometry padding;
  final Widget? child;
  final String text;

  @override
  Widget build(BuildContext context) =>
      Padding(padding: padding, child: Center(child: child ?? Text(text)));
}
