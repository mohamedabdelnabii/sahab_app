import 'package:flutter/material.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/core/theme/app_decorations.dart';

import '../../../../../core/helpers/spacing.dart';

class DetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;
  final Color? subtitleColor;

  const DetailCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final textSecondary = context.labelColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.getGlassDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: textSecondary),
              hGap(6),
              Expanded(
                child: Text(
                  label,
                  style: context.font12Primary54MediumSpacing,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          vGap(10),
          Text(
            value,
            textDirection: TextDirection.ltr,
            style: context.font24PrimaryLight,
          ),
          if (subtitle != null) ...[
            vGap(6),
            Text(
              subtitle!,
              textDirection: TextDirection.ltr,
              style: context.font12Primary60Regular.copyWith(
                color: subtitleColor ?? textSecondary,
                fontWeight: subtitleColor != null
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
