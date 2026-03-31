import 'package:flutter/material.dart';
import 'package:sahab/generated/l10n.dart';

class RadarLoadingWidget extends StatelessWidget {
  final Color primary;

  const RadarLoadingWidget({
    super.key,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class RadarErrorWidget extends StatelessWidget {
  final String error;
  final Color onSurface;
  final VoidCallback? onRetry;

  const RadarErrorWidget({
    super.key,
    required this.error,
    required this.onSurface,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 32,
              color: onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: TextStyle(
                color: onSurface.withValues(alpha: 0.7),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(s.retry, style: const TextStyle(fontSize: 12)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
