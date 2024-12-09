import 'package:flutter/material.dart';
import 'package:medherence/core/utils/color_utils.dart';
import 'package:medherence/core/utils/size_manager.dart';

class PrimaryButton extends StatelessWidget {
  final ButtonConfig buttonConfig;
  final double height;
  final EdgeInsets? margin;
  final double width;
  final Color color, textColor;
  final double? textSize;

  const PrimaryButton({
    Key? key,
    required this.buttonConfig,
    this.textSize = 23.0,
    this.height = 50.0,
    this.margin,
    required this.width,
    this.textColor = AppColors.white,
    this.color = AppColors.mainPrimaryButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: height,
        width: width,
        margin: margin ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: buttonConfig.disabled ? AppColors.disabledButton : color,
          borderRadius: BorderRadius.circular(
            (10),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: buttonConfig.disabled ? null : buttonConfig.action,
            highlightColor: AppColors.disabledButton,
            child: Center(
              child: RichText(
                text: TextSpan(
                    text: buttonConfig.text,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: buttonConfig.disabled
                          ? Colors.grey.shade300
                          : textColor,
                      fontSize: textSize,
                    ),
                    children: [
                      TextSpan(
                        text: buttonConfig.extraText,
                        style: TextStyle(
                          fontSize: SizeMg.text(20),
                          color: AppColors.inactiveGrey,
                        ),
                      )
                    ]),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OutlinePrimaryButton extends StatelessWidget {
  final ButtonConfig buttonConfig;
  final double height;
  final EdgeInsets? margin;
  final double width;
  final Color color, textColor;
  final IconData? icon;
  final double? textSize;
  final Widget? child;

  const OutlinePrimaryButton({
    Key? key,
    required this.buttonConfig,
    this.child,
    this.icon,
    this.height = 50.0,
    this.textSize = 23,
    this.margin,
    this.width = double.infinity,
    this.textColor = AppColors.mainPrimaryButton,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: height,
        width: width,
        margin: margin ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            (10),
          ),
          border: Border.all(
            color: AppColors.pressedButton,
            width: 2.0,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: buttonConfig.action,
            highlightColor: AppColors.disabledButton,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon == null)
                    FittedBox(
                      child: child,
                    ),
                  if (icon != null)
                    Icon(
                      icon,
                      color: AppColors.mainPrimaryButton,
                    ),
                  RichText(
                    text: TextSpan(
                        text: buttonConfig.text,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: textColor,
                          fontSize: textSize,
                        ),
                        children: [
                          TextSpan(
                            text: buttonConfig.extraText,
                            style: const TextStyle(
                              color: AppColors.inactiveGrey,
                            ),
                          )
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonConfig {
  final String text;
  String extraText;
  final VoidCallback action;
  final bool disabled;
  ButtonConfig({
    this.extraText = '',
    required this.text,
    required this.action,
    this.disabled = false,
  });
}
