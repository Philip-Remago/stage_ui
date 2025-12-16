import 'package:flutter/material.dart';
import 'package:stage_ui/src/Inputs/text_input.dart';
import 'package:stage_ui/src/dialogs/empty_popup_dialog.dart';


class TextInputPopupDialog {
  static Future<String?> show(
    BuildContext context, {
    bool barrierDismissible = true,
    EdgeInsets padding = EmptyPopupDialog.defaultPadding,
    double width = 320,
    Radius borderRadius = EmptyPopupDialog.defaultBorderRadius,
    Color? backgroundColor,
    String? title,
    String cancelText = 'Cancel',
    String confirmText = 'OK',
    String? placeholder,
    String initialValue = '',
    Color? cancelTextColor,
    Color? confirmTextColor,
  }) {
    return EmptyPopupDialog.show<String>(
      context,
      barrierDismissible: barrierDismissible,
      padding: padding,
      width: width,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      child: _TextInputDialogContent(
        title: title,
        cancelText: cancelText,
        confirmText: confirmText,
        placeholder: placeholder,
        initialValue: initialValue,
        cancelTextColor: cancelTextColor,
        confirmTextColor: confirmTextColor,
      ),
    );
  }
}

class _TextInputDialogContent extends StatefulWidget {
  final String? title;
  final String cancelText;
  final String confirmText;
  final String? placeholder;
  final String initialValue;
  final Color? cancelTextColor;
  final Color? confirmTextColor;

  const _TextInputDialogContent({
    required this.title,
    required this.cancelText,
    required this.confirmText,
    required this.placeholder,
    required this.initialValue,
    required this.cancelTextColor,
    required this.confirmTextColor,
  });

  @override
  State<_TextInputDialogContent> createState() => _TextInputDialogContentState();
}

class _TextInputDialogContentState extends State<_TextInputDialogContent> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    Navigator.of(context).pop(_controller.text);
  }

  void _cancel() {
    Navigator.of(context).pop(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = theme.colorScheme.onSurface.withAlpha(30);

    const removeStyle = ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      minimumSize: WidgetStatePropertyAll(Size.fromHeight(52)),
      side: WidgetStatePropertyAll(BorderSide.none),
    );

    final cancelStyle = removeStyle.copyWith(
      foregroundColor: widget.cancelTextColor == null
          ? null
          : WidgetStatePropertyAll(widget.cancelTextColor),
    );

    final confirmStyle = removeStyle.copyWith(
      foregroundColor: widget.confirmTextColor == null
          ? null
          : WidgetStatePropertyAll(widget.confirmTextColor),
    );

    final maxHeight = MediaQuery.of(context).size.height * 0.75;
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.title != null && widget.title!.trim().isNotEmpty) ...[
                    Text(widget.title!, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 12),
                  ],
                  Flexible(
                    child: SingleChildScrollView(
                      child: TextInput(
                        controller: _controller,
                        placeholder: widget.placeholder,
                        onSubmittedPop: _confirm,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(width: double.infinity, height: 1, color: dividerColor),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: cancelStyle,
                      onPressed: _cancel,
                      child: Text(widget.cancelText),
                    ),
                  ),
                  VerticalDivider(width: 1, thickness: 1, color: dividerColor),
                  Expanded(
                    child: OutlinedButton(
                      style: confirmStyle,
                      onPressed: _confirm,
                      child: Text(widget.confirmText),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
