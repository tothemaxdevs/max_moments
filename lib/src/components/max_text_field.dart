// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:max_moments/utils/view/view_utils.dart';

class MaxField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final FormFieldValidator<String>? validator;
  final Function(String value)? onChanged;
  final bool isDescription;
  final int? maxlines;
  final int? limit;

  const MaxField({
    Key? key,
    this.controller,
    required this.hint,
    required this.label,
    this.validator,
    this.onChanged,
    this.isDescription = false,
    this.maxlines,
    this.limit,
  }) : super(key: key);
  _MaxFieldState createState() => _MaxFieldState();
}

class _MaxFieldState extends State<MaxField> {
  int? countChar = 0;

  onChangedCharacter(String value) {
    setState(() {
      countChar = value.length;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${widget.label}',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ],
        ),
        sizeH(4),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                onChanged: widget.isDescription
                    ? onChangedCharacter
                    : widget.onChanged,
                maxLines: widget.maxlines ?? 1,
                maxLength: widget.limit,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(
                    fontSize: 14, height: 1.0, color: Colors.black),
                decoration: InputDecoration(
                    counterText: widget.isDescription == true
                        ? '$countChar / ${widget.limit}'
                        : '',
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFDCDEE0), width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFDCDEE0), width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: (widget.hint ?? 'Input'),
                    hintStyle: const TextStyle(color: Colors.grey)
                    // hintText: (widget.hint!).tr() ?? widget.label,
                    // labelText: label,
                    // labelStyle: TextStyle(fontSize: 12)
                    ),
                validator: widget.validator,
                inputFormatters: [
                  if (widget.limit != null)
                    LengthLimitingTextInputFormatter(widget.limit),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
