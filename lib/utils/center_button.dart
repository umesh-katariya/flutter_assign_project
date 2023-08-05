import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';
import 'app_utils.dart';

class CenterButton extends StatelessWidget {
  CenterButton({
    Key? key,
    required this.ontap,
    required this.text,
    this.bgColor = AppColors.primaryColor,
    this.txtColor = Colors.white,
    this.fontWeight,
    this.isExpanded = false,
    this.showArrow = false,
    this.margin = 0,
    this.radius = 25,
    this.isProgress = false,
    this.fontsize = 14,
    this.padding,
    this.border,
    this.shadowColor,
    this.isDisable = false,
  }) : super(key: key);

  var ontap;
  final String text;
  final Color bgColor;
  final Color txtColor;
  final Color? shadowColor;
  final FontWeight? fontWeight;
  final bool isExpanded;
  final bool isProgress;
  final bool showArrow;
  final double margin;
  final double fontsize;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final bool isDisable;

  // final textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisable?null:ontap,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: isExpanded ? double.infinity : null,
          margin:
              margin > 0 ? EdgeInsets.symmetric(horizontal: margin) : null,
          padding: padding??EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: isDisable?AppColors.primaryLightColor:bgColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  color: shadowColor??Colors.black12,
                  spreadRadius: 2,
                  offset: Offset(0, 2))
            ],
            borderRadius: BorderRadius.circular(radius),
            border: border
          ),
          child: isProgress
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      text,
                      style: AppStyles.whiteRegular14.copyWith(
                          color: txtColor, fontSize: fontsize,fontWeight: fontWeight,letterSpacing: 0.8,),
                    ),
                  showArrow?Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.east_outlined,color: txtColor),
                  ):blankBox()
                ],
              ),
        ),
      ),
    );
  }
}
