import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  const AppLogo({
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo.svg',
      width: width,
      height: height,
      colorFilter: color != null 
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }
}

class AppLogoWithText extends StatelessWidget {
  final double? logoSize;
  final String? text;
  final TextStyle? textStyle;
  final Axis direction;
  final double spacing;

  const AppLogoWithText({
    super.key,
    this.logoSize,
    this.text,
    this.textStyle,
    this.direction = Axis.horizontal,
    this.spacing = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = textStyle ?? 
        Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        );

    return direction == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppLogo(
                width: logoSize ?? 32,
                height: logoSize ?? 32,
              ),
              SizedBox(width: spacing),
              if (text != null)
                Text(
                  text!,
                  style: defaultTextStyle,
                ),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppLogo(
                width: logoSize ?? 48,
                height: logoSize ?? 48,
              ),
              SizedBox(height: spacing),
              if (text != null)
                Text(
                  text!,
                  style: defaultTextStyle,
                ),
            ],
          );
  }
}
