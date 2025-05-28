import 'package:flutter/material.dart';
import 'package:mini_project_five/data/global.dart';
import 'package:mini_project_five/utils/getTime.dart';

class Calculate_MorningBus {
  static Widget buildMorningETADisplay(String text, {String ETA = ''}) {
    return Container(
      width: 350,
      child: Card(
        color: Colors.lightBlue[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Icon(Icons.directions_bus_outlined),
              Text(
                ETA.isNotEmpty ? 'Upcoming bus: $ETA minutes' : text,
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget getMorningETA(List<DateTime> busArrivalTimes) {
    final _timeService = TimeService();
    DateTime currentTime = _timeService.time_now ?? DateTime.now();
    currentTime = DateTime(currentTime.year, currentTime.month, currentTime.day, currentTime.hour, currentTime.minute);

    List<DateTime> upcomingArrivalTimes = busArrivalTimes.where((time) => time.isAfter(currentTime)).toList();

    if (upcomingArrivalTimes.isEmpty) {
      return SizedBox.shrink(); // ✅ hides output if nothing upcoming
    }

    String upcomingBus = upcomingArrivalTimes[0].difference(currentTime).inMinutes.toString();
    String nextUpcomingBus = upcomingArrivalTimes.length > 1
        ? upcomingArrivalTimes[1].difference(currentTime).inMinutes.toString()
        : ' - ';

    if (selectedMRT == 1) {
      return Column(
        children: [
          buildMorningETADisplay('Upcoming bus:', ETA: upcomingBus),
          buildMorningETADisplay('Next bus:', ETA: nextUpcomingBus),
        ],
      );
    } else if (selectedMRT == 2) {
      return Column(
        children: [
          buildMorningETADisplay('Upcoming bus:', ETA: upcomingBus),
        ],
      );
    }

    return SizedBox.shrink();
  }
}

class GetMorningETA extends StatelessWidget {
  final List<DateTime> busArrivalTimes;

  const GetMorningETA(this.busArrivalTimes);

  @override
  Widget build(BuildContext context) {
    return Calculate_MorningBus.getMorningETA(busArrivalTimes);
  }
}
