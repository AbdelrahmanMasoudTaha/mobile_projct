import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<int> topSoldTimes;
  final List<Color> colors;
  const Chart({super.key, required this.topSoldTimes, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final s in topSoldTimes)
            ChartBar(
              color: colors[topSoldTimes.indexOf(s)],
              fill: s / topSoldTimes[0],
            ),
        ],
      ),
    );
  }
}
