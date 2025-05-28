import 'package:flutter/material.dart';
import 'package:mini_project_five/data/global.dart';
import 'package:mini_project_five/utils/styling.dart';
import '../data/getData.dart';
import '../services/getMorningETA.dart';

class Morning_Screen extends StatefulWidget {
  final Function(int) updateSelectedBox;

  Morning_Screen({required this.updateSelectedBox});

  @override
  _Morning_ScreenState createState() => _Morning_ScreenState();
}

class _Morning_ScreenState extends State<Morning_Screen> {
  int selectedBox = 1;
  BusData _BusData = BusData();
  bool _isDarkMode = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _BusData.loadData().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void updateSelectedBox(int box) {
    setState(() {
      selectedBox = box;
      print('Printing selectedbox = $box');
    });
    widget.updateSelectedBox(box);
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> currentTimes = selectedBox == 1
        ? _BusData.KAPArrivalTime
        : _BusData.CLEArrivalTime;

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    updateSelectedBox(1);
                    selectedMRT = 1;
                  },
                  child: MRT_Box(box: selectedBox, MRT: 'KAP', label: "King Albert Park"),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    updateSelectedBox(2);
                    selectedMRT = 2;
                  },
                  child: MRT_Box(box: selectedBox, MRT: 'CLE', label: "Clementi"),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        GetMorningETA(currentTimes),
        SizedBox(height: 8),

        /// Morning Bus Trip Info Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      'Morning Bus Trips (NO BOOKING REQUIRED)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    children: currentTimes.map((time) {
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(left: 8.0),
                        title: Text(
                          'Trip at ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                  Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, size: 20, color: Colors.orange),
                      SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Note: Morning buses only stop at:',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text('• Main Entrance (ENT)'),
                            Text('• Makan Place (MAP)'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
