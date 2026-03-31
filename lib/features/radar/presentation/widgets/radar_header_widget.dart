import 'package:flutter/material.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/generated/l10n.dart';

class RadarHeaderWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  final VoidCallback onTogglePlayback;
  final bool isPlaying;
  final Color onSurface;
  final Color primary;

  const RadarHeaderWidget({
    super.key,
    required this.onRefresh,
    required this.onTogglePlayback,
    required this.isPlaying,
    required this.onSurface,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRefresh,
            color: onSurface,
          ),
          Text(
            s.satelliteRadar,
            style: context.font14PrimarySemiBoldSpacing.copyWith(
              letterSpacing: 2,
            ),
          ),
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
            ),
            onPressed: onTogglePlayback,
            color: primary,
          ),
        ],
      ),
    );
  }
}