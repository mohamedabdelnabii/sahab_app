import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:sahab/features/weather/presentation/widgets/home/weather_body.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a dummy weather object for skeletonization
    const dummyCondition = WeatherCondition(
      text: 'Cloudy',
      iconUrl: 'https://cdn.weatherapi.com/weather/64x64/day/113.png',
      code: 1000,
    );

    final dummyWeather = Weather(
      location: const LocationInfo(
        name: 'City Name',
        region: 'Region Name',
        country: 'Country',
        lat: 0.0,
        lon: 0.0,
        tzId: 'UTC',
        localtime: '2026-03-27 12:00',
      ),
      current: const CurrentWeather(
        tempC: 25.0,
        tempF: 77.0,
        isDay: true,
        condition: dummyCondition,
        windKph: 10.0,
        windDir: 'N',
        pressureMb: 1013.0,
        humidity: 50,
        feelslikeC: 25.0,
        feelslikeF: 77.0,
        dewpointC: 15.0,
        dewpointF: 59.0,
        visKm: 10.0,
        uv: 5.0,
      ),
      forecastDays: List.generate(
        7,
        (index) => ForecastDayInfo(
          date: '2026-03-27',
          maxtempC: 30.0,
          maxtempF: 86.0,
          mintempC: 20.0,
          mintempF: 68.0,
          condition: dummyCondition,
          astro: const AstroInfo(
            sunrise: '06:00 AM',
            sunset: '06:00 PM',
          ),
          hours: List.generate(
            24,
            (hIndex) => HourInfo(
              time: '2026-03-27 12:00',
              tempC: 25.0,
              tempF: 77.0,
              condition: dummyCondition,
              windKph: 10.0,
              humidity: 50,
            ),
          ),
        ),
      ),
    );

    return Skeletonizer(
      enabled: true,
      child: WeatherBody(weather: dummyWeather),
    );
  }
}
