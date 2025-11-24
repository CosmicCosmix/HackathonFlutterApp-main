import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomButton - A versatile button component with support for icons, custom styling, and various border radius configurations
 * 
 * @param text - Button text content
 * @param onPressed - Callback function when button is pressed
 * @param width - Button width (required parameter)
 * @param height - Button height
 * @param backgroundColor - Background color of the button
 * @param textColor - Text color
 * @param fontSize - Font size for the text
 * @param fontWeight - Font weight for the text
 * @param borderRadius - Border radius for the button
 * @param leftIcon - Icon to display on the left side
 * @param rightIcon - Icon to display on the right side
 * @param padding - Internal padding of the button
 * @param margin - External margin of the button
 * @param alignment - Button alignment within parent
 */
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    required this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.leftIcon,
    this.rightIcon,
    this.padding,
    this.margin,
    this.alignment,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final String? leftIcon;
  final String? rightIcon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 50.h,
      margin: margin,
      alignment: alignment,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Color(0xFF6A62B6),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(24.h),
          ),
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 12.h,
              ),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != null) ...[
              CustomImageView(
                imagePath: leftIcon!,
                height: 16.h,
                width: 36.h,
              ),
              SizedBox(width: 8.h),
            ],
            Flexible(
              child: Text(
                text,
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  color: textColor ?? appTheme.whiteCustom,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  height: 1.31,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (rightIcon != null) ...[
              SizedBox(width: 8.h),
              CustomImageView(
                imagePath: rightIcon!,
                height: 16.h,
                width: 36.h,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
