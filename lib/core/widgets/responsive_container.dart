import 'package:financial_requests_module/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = AppSpacing.maxContentWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double horizontalPadding =
        constraints.maxWidth >= 720 ? AppSpacing.xl : AppSpacing.md;

        return Align(
          alignment: AlignmentDirectional.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: horizontalPadding,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}