import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/size_manager.dart';

class TitleAndTextFormField extends StatelessWidget {
  ///The text above the text field
  final String title;

  ///The hint text of the form field
  final String formFieldHint;

  ///The text editing controller of the form field
  final TextEditingController formFieldController;

  ///The keyboard input type
  final TextInputType textInputType;

  ///The enter button of the keyboard action
  final TextInputAction textInputAction;

  ///The filled color of the form field
  final Color? formFieldColor;

  ///The validator function of the form field
  final String? Function(String?) formFieldValidator;

  ///List of text input formatters
  final List<TextInputFormatter>? textInputFormatters;

  ///Callback for onChanged event of the form field
  final void Function(String)? onChanged;

  ///Places a [Text] above a [TextFormField] in a [Column] widget
  const TitleAndTextFormField({
    Key? key,
    required this.title,
    required this.formFieldHint,
    required this.formFieldController,
    required this.textInputAction,
    required this.textInputType,
    required this.formFieldColor,
    required this.formFieldValidator,
    this.textInputFormatters,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: SizeMg.text(18),
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: (10),
        ),
        TextFormField(
          controller: formFieldController,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          inputFormatters: textInputFormatters,
          decoration: kFormTextDecoration.copyWith(
            hintText: formFieldHint,
            fillColor: formFieldColor,
            errorBorder: kFormTextDecoration.errorBorder,
          ),
          validator: formFieldValidator,
          onChanged: onChanged,
        ),
        // const SizedBox(
        //   height: (25),
        // ),
      ],
    );
  }
}
