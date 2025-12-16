import 'package:flutter/material.dart';
import 'package:stage_ui/src/dialogs/empty_popup_dialog.dart';

class TextPopupDialog {
  static Future<bool?> show(
    BuildContext context, {
    bool barrierDismissible = true,
    EdgeInsets padding = EmptyPopupDialog.defaultPadding,
    double width = 320,
    Radius borderRadius = EmptyPopupDialog.defaultBorderRadius,
    Color? backgroundColor,
    String? title,
    required Widget content,
    String cancelText = 'Cancel',
    String confirmText = 'Confirm',
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool confirmEnabled = true,
    Color? cancelTextColor,
    Color? confirmTextColor,
  }) {
    return EmptyPopupDialog.show<bool>(
      context,
      barrierDismissible: barrierDismissible,
      padding: padding,
      width: width,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      child: _TextDialogContent(
        title: title,
        content: content,
        cancelText: cancelText,
        confirmText: confirmText,
        onCancel: onCancel,
        onConfirm: onConfirm,
        confirmEnabled: confirmEnabled,
        cancelTextColor: cancelTextColor,
        confirmTextColor: confirmTextColor,
      ),
    );
  }
}

class _TextDialogContent extends StatelessWidget {
  final String? title;
  final Widget content;

  final String cancelText;
  final String confirmText;

  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  final bool confirmEnabled;

  final Color? cancelTextColor;
  final Color? confirmTextColor;

  const _TextDialogContent({
    required this.title,
    required this.content,
    required this.cancelText,
    required this.confirmText,
    required this.onCancel,
    required this.onConfirm,
    required this.confirmEnabled,
    required this.cancelTextColor,
    required this.confirmTextColor,
  });

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
      foregroundColor: cancelTextColor == null
          ? null
          : WidgetStatePropertyAll(cancelTextColor),
    );

    final confirmStyle = removeStyle.copyWith(
      foregroundColor: confirmTextColor == null
          ? null
          : WidgetStatePropertyAll(confirmTextColor),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null && title!.trim().isNotEmpty) ...[
                Text(title!, style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
              ],
              SingleChildScrollView(child: content),
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
                  onPressed: () {
                    onCancel?.call();
                    Navigator.of(context).pop(false);
                  },
                  child: Text(cancelText),
                ),
              ),
              VerticalDivider(width: 1, thickness: 1, color: dividerColor),
              Expanded(
                child: OutlinedButton(
                  style: confirmStyle,
                  onPressed: confirmEnabled
                      ? () {
                          onConfirm?.call();
                          Navigator.of(context).pop(true);
                        }
                      : null,
                  child: Text(confirmText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
