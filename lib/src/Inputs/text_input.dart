import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;

  final String? placeholder;

  final bool autofocus;
  final int maxLines;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  final Color? fillColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  final VoidCallback? onSubmittedPop;

  const TextInput({
    super.key,
    required this.controller,
    this.placeholder,
    this.autofocus = true,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.fillColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.onSubmittedPop,
  });

  void _handleSubmit(BuildContext context) {
    if (onSubmittedPop != null) {
      onSubmittedPop!.call();
    } else {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final resolvedFill =
        fillColor ?? theme.colorScheme.surfaceContainerHighest;

    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface,
    );

    final hintStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface.withAlpha(127),
    );

    return Container(
      decoration: BoxDecoration(
        color: resolvedFill,
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: textStyle,
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: placeholder,
          hintStyle: hintStyle,
        ),
        onSubmitted: (_) => _handleSubmit(context),
      ),
    );
  }
}
