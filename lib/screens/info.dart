import 'package:flutter/material.dart';
import '../data/getData.dart';


class Information_Page extends StatefulWidget {
  final bool isDarkMode;

  const Information_Page({required this.isDarkMode});

  @override
  State<Information_Page> createState() => _Information_PageState();
}

class _Information_PageState extends State<Information_Page> {
  BusData _BusData = BusData();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _BusData.loadData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.isDarkMode ? Colors.lightBlue[600] : Colors.lightBlue[100],
        title: Text(
          'Information',
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? Colors.white : Colors.black
          ),
        ),
      ),
      body: Container(
        color: widget.isDarkMode ? Colors.lightBlue[900] : Colors.white,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 15, 15, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Morning Schedule ===
                Text(
                  'Morning Schedule',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'From King Albert Park MRT Exit A to NP campus',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                _buildScheduleSection('', _BusData.KAPArrivalTime, 2),
                SizedBox(height: 30),

                Text(
                  'From Clementi MRT Exit B to NP campus',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                _buildScheduleSection('', _BusData.CLEArrivalTime, 1),
                SizedBox(height: 30),

                // === Afternoon Schedule ===
                Text(
                  'Afternoon Schedule',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  'From NP campus to King Albert Park MRT OPP Exit A',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),

                _buildScheduleSection('', _BusData.KAPDepartureTime, 2),
                SizedBox(height: 30),

                Text(
                  'From NP campus to Clementi MRT Exit B',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                _buildScheduleSection('', _BusData.CLEDepartureTime, 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleSection(String title, List<DateTime> times, int columns) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20.0,
              color: widget.isDarkMode ? Colors.white: Colors.black
          ),
        ),
        SizedBox(height: 10),
        Table(
          columnWidths: columns == 2
              ? {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(2),
          }
              : {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          border: TableBorder.all(
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),

          children: _buildTableRows(times, columns),
        ),
      ],
    );
  }

  List<TableRow> _buildTableRows(List<DateTime> times, int columns) {
    List<TableRow> rows = [];

    if (columns == 2) {
      rows.add(_buildTableRow(['Trip', 'Bus A Departure Time', 'Trip', 'Bus B Departure Time']));
      for (int i = 0; i < times.length; i += 2) {
        rows.add(_buildTableRow([
          (i + 1).toString(),
          _formatTime(times[i]),
          if (i + 1 < times.length) (i + 2).toString() else '',
          if (i + 1 < times.length) _formatTime(times[i + 1]) else '',
        ]));
      }
    } else if (columns == 1) {
      rows.add(_buildTableRow(['Trip', 'Bus A Departure Time']));
      for (int i = 0; i < times.length; i++) {
        rows.add(_buildTableRow([(i + 1).toString(), _formatTime(times[i])]));
      }
    }

    return rows;
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  TableRow _buildTableRow(List<String> data) {
    return TableRow(
      children: data
          .map(
            (item) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item, textAlign: TextAlign.center, style: TextStyle(
              color: widget.isDarkMode ? Colors.white: Colors.black
          ),),
        ),
      )
          .toList(),
    );
  }
}
