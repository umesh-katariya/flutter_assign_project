import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class CommonTextfield extends StatelessWidget {
  CommonTextfield({
    Key? key,
    this.labelText,
    required this.controller,
    required this.hintText,
    this.textInput = TextInputType.text,
    this.isSecure = false,
    this.maxLength,
    this.suffixWidget,
    this.focus,
    this.validation,
    this.emptyValidation = true,
    this.nextFocus,
  }) : super(key: key);

  String? labelText;
  final TextEditingController controller;
  final TextInputType textInput;
  final String hintText;
  final int? maxLength;
  final bool isSecure;
  final bool emptyValidation;
  final FocusNode? focus;
  final Widget? suffixWidget;
  var validation;
  var nextFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(labelText, style: blackRegular14),
          // SizedBox(
          //   height: 10.h,
          // ),
          TextFormField(
            controller: controller,
            keyboardType: textInput,
            textInputAction: TextInputAction.done,
            inputFormatters: textInput == TextInputType.number
                ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                : null,
            // cursorColor: primaryColor,
            maxLength: maxLength,
            focusNode: focus,
            obscureText: isSecure,
            textAlignVertical: TextAlignVertical.bottom,
            style: AppStyles.blackRegular16,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: suffixWidget,
              ),
              filled: false,
              fillColor: Theme.of(context).focusColor,
              suffixIconConstraints: BoxConstraints(maxHeight: 15),
              counterText: "",
              hintText: hintText,
              hintStyle: AppStyles.hintTextStyle,
              contentPadding:
                  EdgeInsets.only(bottom: 11, top: 12, left: 15),
              isDense: true,
              // border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ),
            ),
            validator: emptyValidation
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return '$hintText Required';
                    }
                    return null;
                  }
                : validation,
            onEditingComplete: nextFocus,
          ),
        ],
      ),
    );
  }
}

class CommonTextfieldWithUnderLine extends StatelessWidget {
  CommonTextfieldWithUnderLine({
    Key? key,
    this.labelText,
    required this.controller,
    required this.hintText,
    this.textInput = TextInputType.text,
    this.isSecure = false,
    this.isDisabled = false,
    this.isDigitsOnly = false,
    this.maxLength,
    this.suffixWidget,
    this.focus,
    this.validation,
    this.emptyValidation = true,
    this.nextFocus,
    this.onChange,
    this.maxLine,
    this.prefixIcon,
    this.textInputAction,
  }) : super(key: key);

  final String? labelText;
  final TextEditingController controller;
  final TextInputType textInput;
  final String hintText;
  final int? maxLength;
  final bool isSecure;
  final bool isDisabled;
  final bool isDigitsOnly;
  final bool emptyValidation;
  final FocusNode? focus;
  final Widget? suffixWidget;
  final Widget? prefixIcon;
  var validation;
  var nextFocus;
  var onChange;
  final int? maxLine;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(labelText, style: blackRegular14),
          // SizedBox(
          //   height: 10.h,
          // ),
          TextFormField(
            controller: controller,
            keyboardType: textInput,

            // inputFormatters: isDigitsOnly ? [WhitelistingTextInputFormatter.digitsOnly]: null,
            inputFormatters: isDigitsOnly
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ]
                : null,
            // cursorColor: primaryColor,
            maxLength: maxLength,
            maxLines: maxLine,
            focusNode: focus,
            obscureText: isSecure,
            enabled: !isDisabled,
            textAlignVertical: TextAlignVertical.bottom,
            style: AppStyles.blackRegular16,
            textInputAction: textInputAction??TextInputAction.next,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                  right: 5,
                ),
                child: suffixWidget,
              ),
              prefixIcon: prefixIcon,
              // filled: true,
              // fillColor: Theme.of(context).focusColor,
              suffixIconConstraints: BoxConstraints(maxHeight: 15),
              prefixIconConstraints: BoxConstraints(maxWidth: 35),
              counterText: "",
              hintText: hintText,
              hintStyle: AppStyles.hintTextStyle,
              contentPadding: EdgeInsets.only(bottom: 10, top: 15, left: 0),
              isDense: true,
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ),
              disabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ),
            ),
            validator: emptyValidation
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return '$hintText Required';
                    }
                    return null;
                  }
                : validation,
            onEditingComplete: nextFocus,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}

class CommonTextfieldRectangle extends StatelessWidget {
  CommonTextfieldRectangle({
    Key? key,
    this.labelText,
    required this.controller,
    required this.hintText,
    this.textInput = TextInputType.text,
    this.isSecure = false,
    this.isDisabled = false,
    this.isDigitsOnly = false,
    this.maxLength,
    this.suffixWidget,
    this.focus,
    this.validation,
    this.emptyValidation = true,
    this.nextFocus,
    this.onChange,
    this.maxLine,
    this.prefixIcon,
  }) : super(key: key);

  final String? labelText;
  final TextEditingController controller;
  final TextInputType textInput;
  final String hintText;
  final int? maxLength;
  final bool isSecure;
  final bool isDisabled;
  final bool isDigitsOnly;
  final bool emptyValidation;
  final FocusNode? focus;
  final Widget? suffixWidget;
  final Widget? prefixIcon;
  var validation;
  var nextFocus;
  var onChange;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(labelText, style: blackRegular14),
          // SizedBox(
          //   height: 10.h,
          // ),
          TextFormField(
            controller: controller,
            keyboardType: textInput,
            // inputFormatters: isDigitsOnly ? [WhitelistingTextInputFormatter.digitsOnly]: null,
            inputFormatters: isDigitsOnly
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ]
                : null,
            // cursorColor: primaryColor,
            maxLength: maxLength,
            maxLines: maxLine,
            focusNode: focus,
            obscureText: isSecure,
            enabled: !isDisabled,
            textAlignVertical: TextAlignVertical.bottom,
            style: AppStyles.blackRegular16,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                  right: 5,
                ),
                child: suffixWidget,
              ),
              prefixIcon: prefixIcon,
              filled: true,
              fillColor: AppColors.textFillColorColor,
              suffixIconConstraints: BoxConstraints(maxHeight: 15),
              prefixIconConstraints: BoxConstraints(maxWidth: 35),
              counterText: "",
              hintText: hintText,
              hintStyle: AppStyles.hintTextStyle,
              contentPadding: EdgeInsets.only(bottom: 15, top: 15, left: 15),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.hintColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.hintColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.hintColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.hintColor),
              ),
            ),
            validator: emptyValidation
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return '$hintText Required';
                    }
                    return null;
                  }
                : validation,
            onEditingComplete: nextFocus,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}

/*class CommonMobilefield extends StatelessWidget {
  const CommonMobilefield({
    Key key,
    @required this.labelText,
    @required this.controller,
    @required this.hintText,
    this.textInput = TextInputType.text,
    this.isSecure = false,
    this.autofocus = false,
    this.maxLength,
    this.focus,
    this.suffixWidget,
    this.nextFocus,
    // this.validation,
    // this.emptyValidation,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final TextInputType textInput;
  final String hintText;
  final int maxLength;
  final FocusNode focus;
  final bool isSecure;
  final bool autofocus;
  // final bool emptyValidation;
  final Widget suffixWidget;
  final Function nextFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: primaryBold18),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            autofocus: autofocus,
            controller: controller,
            keyboardType: textInput,
            cursorColor: primaryColor,
            maxLength: maxLength,
            obscureText: isSecure,
            focusNode: focus,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 10, top: 0),
                child: suffixWidget,
              ),
              suffixIconConstraints: BoxConstraints(maxHeight: 10.h),
              counterText: "",
              hintText: hintText,
              hintStyle: TextStyle(color: primaryColor),
              contentPadding:
                  EdgeInsets.only(bottom: 11.w, top: 12.w, left: 15.w),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide(color: primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide(color: primaryColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide(color: primaryColor)),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field can\'t be empty';
              } else if (value.length < 10) {
                return 'Please enter valid number';
              }
              return null;
            },
            onEditingComplete: nextFocus,
          ),
        ],
      ),
    );
  }
}*/

class CommonTextfieldWithFill extends StatelessWidget {
  CommonTextfieldWithFill({
    Key? key,
    this.labelText,
    required this.controller,
    required this.hintText,
    this.textInput = TextInputType.text,
    this.textAlign = TextAlign.left,
    this.isSecure = false,
    this.isDisabled = false,
    this.isDigitsOnly = false,
    this.maxLength,
    this.suffixWidget,
    this.prefixWidget,
    this.focus,
    this.validation,
    this.emptyValidation = true,
    this.nextFocus,
    this.onChange,
    this.onFieldSubmitted,
    this.maxLine,
    this.textInputAction,
  }) : super(key: key);

  final String? labelText;
  final TextEditingController controller;
  final TextInputType textInput;
  final TextAlign textAlign;
  final String hintText;
  final int? maxLength;
  final bool isSecure;
  final bool isDisabled;
  final bool isDigitsOnly;
  final bool emptyValidation;
  final FocusNode? focus;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  var validation;
  var nextFocus;
  var onChange;
  var onFieldSubmitted;
  final int? maxLine;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: textInput,
            textInputAction: textInputAction??TextInputAction.next,
            inputFormatters: isDigitsOnly
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ]
                : null,
            maxLength: maxLength,
            maxLines: maxLine,
            focusNode: focus,
            obscureText: isSecure,
            enabled: !isDisabled,
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: textAlign,
            style: AppStyles.blackRegular16,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                  right: 15,
                ),
                child: suffixWidget,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 2
                ),
                child: prefixWidget,
              ),
              prefixIconConstraints: BoxConstraints(maxHeight: 24),
              filled: true,
              fillColor: isDisabled?Colors.grey.withOpacity(0.3):AppColors.textFillColorColor,
              suffixIconConstraints: BoxConstraints(maxHeight: 24),
              counterText: "",
              hintText: hintText,
              hintStyle: AppStyles.hintTextStyle,
              contentPadding:
                  EdgeInsets.only(bottom: 15, top: 15, left: 15),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            validator: emptyValidation
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return '$hintText Required';
                    }
                    return null;
                  }
                : validation,
            onEditingComplete: nextFocus,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}

class UnderlineTextfield extends StatelessWidget {
  UnderlineTextfield({
    Key? key,
    this.labelText,
    required this.controller,
    required this.hintText,
    this.textInput = TextInputType.text,
    this.isSecure = false,
    this.maxLength,
    this.suffixWidget,
    this.focus,
    this.validation,
    this.emptyValidation = true,
    this.nextFocus,
    this.cursorcolor = Colors.black,
    this.textstyle,
    this.hintstyle,
    this.borderColor = Colors.black,
  }) : super(key: key);

  final String? labelText;
  final TextEditingController controller;
  final TextInputType textInput;
  final String hintText;
  final int? maxLength;
  final bool isSecure;
  final bool emptyValidation;
  final FocusNode? focus;
  final Widget? suffixWidget;
  var validation;
  var nextFocus;
  var textstyle;
  var hintstyle;
  var cursorcolor;
  var borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(labelText, style: blackRegular14),
          // SizedBox(
          //   height: 10.h,
          // ),
          TextFormField(
            controller: controller,
            keyboardType: textInput,
            cursorColor: cursorcolor,
            maxLength: maxLength,
            focusNode: focus,
            obscureText: isSecure,
            textAlignVertical: TextAlignVertical.bottom,
            style: textstyle,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: suffixWidget,
              ),
              // filled: true,
              // fillColor: Theme.of(context).focusColor,
              suffixIconConstraints: BoxConstraints(maxHeight: 15),
              counterText: "",
              hintText: hintText,
              hintStyle: hintstyle ?? AppStyles.hintTextStyle,
              contentPadding:
                  EdgeInsets.only(bottom: 5, top: 12, left: 2),
              isDense: true,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor)),
              /* enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ), */
            ),
            validator: emptyValidation
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return '$hintText Required';
                    }
                    return null;
                  }
                : validation,
            onEditingComplete: nextFocus,
          ),
        ],
      ),
    );
  }
}
