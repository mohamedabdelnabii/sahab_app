import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:sahab/core/helpers/spacing.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/features/radar/domain/entities/radar_frame.dart';
import 'cached_tile_provider.dart';
import 'radar_controls_widget.dart';

class RadarMapWidget extends StatelessWidget {
  final RadarFrameEntity? currentFrame;
  final String? host;
  final LatLng center;
  final MapController mapController;
  final Color primaryColor;
  final RadarLayer selectedLayer;
  final String? cityName;
  final String? temp;

  const RadarMapWidget({
    super.key,
    this.currentFrame,
    this.host,
    required this.center,
    required this.mapController,
    required this.primaryColor,
    this.selectedLayer = RadarLayer.rain,
    this.cityName,
    this.temp,
  });

  @override
  Widget build(BuildContext context) {

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: center,
        initialZoom: 6,
        minZoom: 2,
        maxZoom: 18,
      ),
      children: [
        // Base Map Layer
          TileLayer(
            tileProvider: CachedTileProvider(),
            urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
            subdomains: const ['a', 'b', 'c', 'd'],
          ),

        // Weather Data Overlay Layer
        if (host != null && currentFrame != null)
          TileLayer(
            tileProvider: CachedTileProvider(),
            urlTemplate: '$host${currentFrame!.path}/256/{z}/{x}/{y}/${selectedLayer == RadarLayer.rain ? 2 : 1}/1_1.png',
            panBuffer: 0,
          ),

        // City Identification Marker
        MarkerLayer(
          markers: [
            Marker(
              point: center,
              width: 150,
              height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (cityName != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: AppDecorations.getGlassDecoration(context).copyWith(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              cityName!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (temp != null) ...[
                            hGap(6),
                            Container(
                              width: 1.w,
                              height: 12.h,
                              color: Colors.white24,
                            ),
                            hGap(6),
                            Text(
                              '$temp°',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  vGap(6),
                  // Pulsing Glow Center Point
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      _PulsingCircle(color: primaryColor),
                      Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.5),
                              blurRadius: 10.r,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PulsingCircle extends StatefulWidget {
  final Color color;
  const _PulsingCircle({required this.color});

  @override
  State<_PulsingCircle> createState() => _PulsingCircleState();
}

class _PulsingCircleState extends State<_PulsingCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 30 * _controller.value + 10,
          height: 30 * _controller.value + 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withValues(alpha: 1 - _controller.value),
          ),
        );
      },
    );
  }
}
