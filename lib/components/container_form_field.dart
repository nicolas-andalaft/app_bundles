import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerFormField extends FormField {
  final Widget? child;
  final String? labelText;
  final bool isCentered;

  ContainerFormField({
    this.child,
    this.labelText,
    this.isCentered = false,
    String? Function()? validator,
    autovalidateMode,
  }) : super(
          builder: (state) {
            var errorWidget = IntrinsicHeight(
              child: InputDecorator(
                decoration: InputDecoration(
                  hintText: state.errorText,
                  errorText: state.errorText,
                  isCollapsed: true,
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            );

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: labelText,
                    isCollapsed: true,
                    isDense: true,
                    enabledBorder: InputBorder.none,
                  ),
                  child: child,
                ),
                isCentered ? IntrinsicWidth(child: errorWidget) : errorWidget,
              ],
            );
          },
          validator: (_) => validator?.call(),
          autovalidateMode: autovalidateMode,
        );
}
