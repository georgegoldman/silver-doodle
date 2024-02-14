import 'package:flutter/material.dart';

/// This file holds frequently used widgets for forms.
///
/// The [ApplicationFormField] mixin provides methods for creating text fields
/// and text areas commonly used in forms.

mixin ApplicationFormField {
  /// Creates a text field widget with the provided [controller] and [placeholder].
  ///
  /// The [controller] manages the text entered into the text field,
  /// and the [placeholder] is displayed as the label for the text field.
  TextField applicationTextField(
    TextEditingController controller,
    String placeholder,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(placeholder),
      ),
    );
  }

  /// Creates a text area widget with the provided [controller] and [placeholder].
  ///
  /// The [controller] manages the text entered into the text area,
  /// and the [placeholder] is displayed as the label for the text area.
  TextField applicationTextArea(
      TextEditingController controller, String placeholder) {
    return TextField(
      controller: controller,
      maxLines: null, // Set to null for unlimited lines, or specify a number
      decoration: InputDecoration(
        labelText: placeholder,
      ),
    );
  }
}
