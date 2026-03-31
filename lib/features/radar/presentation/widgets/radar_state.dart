import 'package:flutter/material.dart';
import 'package:sahab/generated/l10n.dart';

class RadarFrame {
  final int time;
  final String path;

  RadarFrame({
    required this.time,
    required this.path,
  });

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(time * 1000);

  String getRelativeTime(BuildContext context) {
    final s = S.of(context);
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 1) {
      return s.justNow;
    } else if (difference.inMinutes < 60) {
      return s.minutesAgo(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return s.hoursAgo(difference.inHours);
    } else {
      return s.daysAgo(difference.inDays);
    }
  }
}