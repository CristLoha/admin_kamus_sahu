import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnderlineController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void toggleUnderline() {
    if (textEditingController.selection.isCollapsed) {
      return;
    }

    var currentText = textEditingController.text;
    var selectionStart = textEditingController.selection.start;
    var selectionEnd = textEditingController.selection.end;
    var textBeforeSelection = currentText.substring(0, selectionStart);
    var selectedText = currentText.substring(selectionStart, selectionEnd);
    var textAfterSelection = currentText.substring(selectionEnd);

    var textSpan = TextSpan(
      children: [
        TextSpan(text: textBeforeSelection),
        TextSpan(
          text: selectedText,
          style: TextStyle(decoration: TextDecoration.underline),
        ),
        TextSpan(text: textAfterSelection),
      ],
    );

    textEditingController.value = textEditingController.value.copyWith(
      text: textSpan.toPlainText(),
      selection: TextSelection.collapsed(offset: selectionEnd + 7),
      composing: TextRange.empty,
    );

    focusNode.requestFocus();
  }
}
