import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sahab/core/di/injection_container.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/features/radar/cubit/radar_cubit.dart';
import 'package:sahab/features/radar/cubit/radar_state.dart';
import 'package:sahab/features/radar/ui/widgets/radar_controls_widget.dart';
import 'package:sahab/features/radar/ui/widgets/radar_header_widget.dart';
import 'package:sahab/features/radar/ui/widgets/radar_loading_widget.dart';
import 'package:sahab/features/radar/ui/widgets/radar_map_widget.dart';
import 'package:sahab/generated/l10n.dart';
import 'package:sahab/features/weather/presentation/cubit/weather_cubit.dart';

class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gitIt<RadarCubit>()..fetchRadarData(),
      child: const RadarScreenContent(),
    );
  }
}

class RadarScreenContent extends StatefulWidget {
  const RadarScreenContent({super.key});

  @override
  State<RadarScreenContent> createState() => _RadarScreenContentState();
}

class _RadarScreenContentState extends State<RadarScreenContent> {
  final MapController _mapController = MapController();

  int _currentFrameIndex = 0;
  bool _isPlaying = false;
  RadarLayer _selectedLayer = RadarLayer.rain;

  static const LatLng _defaultCenter = LatLng(31.2653, 32.3019);

  @override
  void dispose() {
    _isPlaying = false;
    _mapController.dispose();
    super.dispose();
  }

  void _togglePlayback(int totalFrames) {
    if (totalFrames <= 1) return;
    
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _playAnimation(totalFrames);
    }
  }

  Future<void> _playAnimation(int totalFrames) async {
    if (totalFrames <= 1) return;

    while (_isPlaying && mounted) {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (!_isPlaying || !mounted) break;

      setState(() {
        _currentFrameIndex = (_currentFrameIndex + 1) % totalFrames;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = context.onSurfaceColor;
    final primary = context.primaryColor;

    return Scaffold(
      body: Container(
        decoration: AppDecorations.getMainGradient(context),
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, weatherState) {
            final center = weatherState.maybeWhen(
              success: (weather) => LatLng(weather.location.lat, weather.location.lon),
              orElse: () => _defaultCenter,
            );
            
            final cityName = weatherState.maybeWhen(
              success: (weather) => weather.location.name,
              orElse: () => null,
            );

            final temp = weatherState.maybeWhen(
              success: (weather) => weather.current.tempC.round().toString(),
              orElse: () => null,
            );

            return BlocBuilder<RadarCubit, RadarState>(
              builder: (context, state) {
                final frames = state is RadarLoaded 
                    ? (_selectedLayer == RadarLayer.clouds ? state.data.satelliteInfrared : state.data.allRadarFrames) 
                    : [];
                
                return Stack(
                  children: [
                    _buildMap(state, frames, primary, onSurface, center, cityName, temp),
                    
                    Positioned(
                      right: 20,
                      top: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        children: [
                          _buildZoomButton(Icons.add, () {
                            _mapController.move(_mapController.camera.center, _mapController.camera.zoom + 1);
                          }, onSurface),
                          const SizedBox(height: 12),
                          _buildZoomButton(Icons.remove, () {
                            _mapController.move(_mapController.camera.center, _mapController.camera.zoom - 1);
                          }, onSurface),
                        ],
                      ),
                    ),

                    SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RadarHeaderWidget(
                            onRefresh: () => context.read<RadarCubit>().fetchRadarData(),
                            onTogglePlayback: () {
                              if (frames.isNotEmpty) {
                                _togglePlayback(frames.length);
                              }
                            },
                            isPlaying: _isPlaying,
                            onSurface: onSurface,
                            primary: primary,
                          ),
                          const Spacer(),
                          if (state is RadarLoading)
                            RadarLoadingWidget(primary: primary)
                          else if (state is RadarError)
                            RadarErrorWidget(
                              error: state.message,
                              onSurface: onSurface,
                              onRetry: () => context.read<RadarCubit>().fetchRadarData(),
                            ),
                          RadarControlsWidget(
                            selectedLayer: _selectedLayer,
                            onLayerChanged: (layer) => setState(() {
                              _selectedLayer = layer;
                              _currentFrameIndex = 0;
                              _isPlaying = false;
                            }),
                            currentFrameIndex: state is RadarLoaded ? _currentFrameIndex : null,
                            totalFrames: state is RadarLoaded ? frames.length : null,
                            onFrameChanged: (index) => setState(() {
                              _currentFrameIndex = index;
                              _isPlaying = false;
                            }),
                            currentFrameTime: state is RadarLoaded && frames.isNotEmpty && _currentFrameIndex < frames.length
                                ? frames[_currentFrameIndex].dateTime
                                : null,
                            labelTitle: state is RadarLoaded && frames.isNotEmpty && _currentFrameIndex < frames.length
                                ? (frames[_currentFrameIndex].dateTime.isBefore(DateTime.now()) 
                                    ? S.of(context).pastData 
                                    : S.of(context).livePrediction)
                                : S.of(context).livePrediction,
                            relativeTime: state is RadarLoaded && frames.isNotEmpty && _currentFrameIndex < frames.length
                                ? frames[_currentFrameIndex].getRelativeTime(context)
                                : null,
                            onSurface: onSurface,
                            primary: primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildZoomButton(IconData icon, VoidCallback onTap, Color onSurface) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: onSurface.withValues(alpha: 0.2)),
        ),
        child: Icon(icon, color: onSurface, size: 20),
      ),
    );
  }

  Widget _buildMap(RadarState state, List<dynamic> frames, Color primary, Color onSurface, LatLng center, String? cityName, String? temp) {
    final host = state is RadarLoaded ? state.data.host : null;
    final currentFrame = (state is RadarLoaded && frames.isNotEmpty && _currentFrameIndex < frames.length) 
        ? frames[_currentFrameIndex] 
        : null;

    return RadarMapWidget(
      currentFrame: currentFrame,
      host: host,
      center: center,
      mapController: _mapController,
      primaryColor: primary,
      selectedLayer: _selectedLayer,
      cityName: cityName,
      temp: temp,
    );
  }
}
