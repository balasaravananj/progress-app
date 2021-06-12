import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';


class PercentageViewer extends StatelessWidget {
 final double pcnt;
 PercentageViewer(this.pcnt);
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 200.0,
      lineWidth: 10.0,
      animation: true,
      percent: pcnt/100,
      center: Text(
        pcnt.toStringAsFixed(2) + "%",
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black),
      ),
      backgroundColor: Colors.grey[300],
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.redAccent,
    );
  }
}
