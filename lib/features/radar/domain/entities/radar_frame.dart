import 'package:flutter/material.dart';
import 'package:sahab/generated/l10n.dart';

class RadarFrameEntity {
  final int time;
  final String path;

  RadarFrameEntity({
    required this.time,
    required this.path,
  });

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(time * 1000);

  String getRelativeTime(BuildContext context) {
    final s = S.of(context);
    final difference = DateTime.now().difference(dateTime);

    if (difference.isNegative) {
      final absDiff = difference.abs();
      if (absDiff.inMinutes < 60) {
        return 'in ${absDiff.inMinutes} min';
      } else {
        return 'in ${absDiff.inHours} hr';
      }
    }

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
