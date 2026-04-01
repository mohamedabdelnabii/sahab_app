import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahab/core/helpers/spacing.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/generated/l10n.dart';

enum RadarLayer {
  rain,
  wind,
  temperature,
}

class RadarControlsWidget extends StatelessWidget {
  final RadarLayer selectedLayer;
  final Function(RadarLayer) onLayerChanged;
  final int? currentFrameIndex;
  final int? totalFrames;
  final Function(int)? onFrameChanged;
  final DateTime? currentFrameTime;
  final String? labelTitle;
  final String? relativeTime;
  final Color onSurface;
  final Color primary;

  const RadarControlsWidget({
    super.key,
    required this.selectedLayer,
    required this.onLayerChanged,
    this.currentFrameIndex,
    this.totalFrames,
    this.onFrameChanged,
    this.currentFrameTime,
    this.labelTitle,
    this.relativeTime,
    required this.onSurface,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppDecorations.getGlassDecoration(context).copyWith(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Layer Controls
            _LayerSelector(
              selectedLayer: selectedLayer,
              onLayerChanged: onLayerChanged,
              onSurface: onSurface,
              primary: primary,
            ),

            vGap( 20),

            // Timeline Slider or Static
            if (currentFrameIndex != null && totalFrames != null && onFrameChanged != null)
              _TimelineSlider(
                currentFrame: currentFrameIndex!,
                totalFrames: totalFrames!,
                onChanged: onFrameChanged!,
                onSurface: onSurface,
                primary: primary,
              )
            else
              _StaticTimeline(
                onSurface: onSurface,
                primary: primary,
              ),

            vGap(12),

            // Time Display
            _TimeDisplay(
              currentFrameTime: currentFrameTime,
              labelTitle: labelTitle,
              relativeTime: relativeTime,
              onSurface: onSurface,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Private Widgets
// ═══════════════════════════════════════════════════════════════

class _LayerSelector extends StatelessWidget {
  final RadarLayer selectedLayer;
  final Function(RadarLayer) onLayerChanged;
  final Color onSurface;
  final Color primary;

  const _LayerSelector({
    required this.selectedLayer,
    required this.onLayerChanged,
    required this.onSurface,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _LayerItem(
          icon: Icons.waves,
          label: s.rain,
          layer: RadarLayer.rain,
          isActive: selectedLayer == RadarLayer.rain,
          onTap: () => onLayerChanged(RadarLayer.rain),
          onSurface: onSurface,
          primary: primary,
        ),
        _LayerItem(
          icon: Icons.wind_power_outlined,
          label: s.wind,
          layer: RadarLayer.wind,
          isActive: selectedLayer == RadarLayer.wind,
          onTap: () => onLayerChanged(RadarLayer.wind),
          onSurface: onSurface,
          primary: primary,
        ),
        _LayerItem(
          icon: Icons.thermostat,
          label: s.temp,
          layer: RadarLayer.temperature,
          isActive: selectedLayer == RadarLayer.temperature,
          onTap: () => onLayerChanged(RadarLayer.temperature),
          onSurface: onSurface,
          primary: primary,
        ),
      ],
    );
  }
}

class _LayerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final RadarLayer layer;
  final bool isActive;
  final VoidCallback onTap;
  final Color onSurface;
  final Color primary;

  const _LayerItem({
    required this.icon,
    required this.label,
    required this.layer,
    required this.isActive,
    required this.onTap,
    required this.onSurface,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: isActive ? primary : onSurface.withValues(alpha: 0.7),
            size: 24,
          ),
          vGap(8),
          Text(
            label,
            style: context.font12Primary54MediumSpacing.copyWith(
              color: isActive ? onSurface : onSurface.withValues(alpha: 0.54),
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineSlider extends StatelessWidget {
  final int currentFrame;
  final int totalFrames;
  final Function(int) onChanged;
  final Color onSurface;
  final Color primary;

  const _TimelineSlider({
    required this.currentFrame,
    required this.totalFrames,
    required this.onChanged,
    required this.onSurface,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    if (totalFrames <= 1) {
      return _StaticTimeline(onSurface: onSurface, primary: primary);
    }

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
      ),
      child: Slider(
        value: currentFrame.toDouble(),
        min: 0,
        max: (totalFrames - 1).toDouble(),
        divisions: totalFrames - 1,
        activeColor: primary,
        inactiveColor: onSurface.withValues(alpha: 0.1),
        onChanged: (value) => onChanged(value.toInt()),
      ),
    );
  }
}

class _StaticTimeline extends StatelessWidget {
  final Color onSurface;
  final Color primary;

  const _StaticTimeline({
    required this.onSurface,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionalTranslation(
        translation: const Offset(0.3, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeDisplay extends StatelessWidget {
  final DateTime? currentFrameTime;
  final String? labelTitle;
  final String? relativeTime;
  final Color onSurface;

  const _TimeDisplay({
    this.currentFrameTime,
    this.labelTitle,
    this.relativeTime,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    String timeText;
    if (currentFrameTime != null) {
      timeText = DateFormat('HH:mm').format(currentFrameTime!);
    } else {
      timeText = DateFormat('HH:mm').format(DateTime.now());
    }

    return Row(
      children: [
        Text(
          labelTitle ?? s.livePrediction,
          style: context.font12Primary54MediumSpacing,
        ),
        hGap(4),
        Text(
          timeText,
          style: context.font12Primary54MediumSpacing.copyWith(
            color: onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (relativeTime != null) ...[
          hGap( 4),
          Text(
            '($relativeTime)',
            style: context.font12Primary54MediumSpacing.copyWith(
              fontSize: 10,
            ),
          ),
        ],
      ],
    );
  }
}
