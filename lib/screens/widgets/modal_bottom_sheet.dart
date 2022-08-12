import 'package:flutter/material.dart';

Future modalBottomSheet(BuildContext context, Widget bottomSheet) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => bottomSheet,
    // isScrollControlled: true,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
  );
}
