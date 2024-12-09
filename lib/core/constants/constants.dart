import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/color_utils.dart';

InputDecoration kFormTextDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey.shade500,
  ),
  filled: true,
  fillColor: AppColors.textFilledColor,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      (10),
    ),
    borderSide: BorderSide(
      width: (2),
      color: Colors.grey.shade500,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      (10),
    ),
    borderSide: const BorderSide(
      width: (2),
      color: Colors.black87,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.red),
  ),
);

InputDecoration kProfileInputDecoration = InputDecoration(
  filled: true,
  // fillColor: Colors.white70,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      (10),
    ),
    borderSide: const BorderSide(
      width: (2),
      color: Colors.black87,
    ),
  ),
);

NumberFormat kNumFormatNoDecimal = NumberFormat('#,###');

NumberFormat kNumFormatDecimal = NumberFormat('#,###.0#');
