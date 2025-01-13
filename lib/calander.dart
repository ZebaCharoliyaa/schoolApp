import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calendar(),
    );
  }
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;

  // List of events
  final List<Map<String, String>> events = [
    {"date": "01", "type": "Holiday", "name": "National Day", "color": "pink"},
    {
      "date": "10",
      "type": "Event",
      "name": "Summer Holiday Event",
      "color": "blue"
    },
    {"date": "22", "type": "Event", "name": "School Function", "color": "pink"},
    {"date": "26", "type": "Event", "name": "Dean Meeting", "color": "green"},
    {
      "date": "30",
      "type": "Holiday",
      "name": "Carnival in the City",
      "color": "pink"
    },
  ];

  // Function to get the number of days in a month
  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  // Function to handle year and month changes
  void _updateYearOrMonth(int year, int month) {
    setState(() {
      selectedYear = year;
      selectedMonth = month;
      selectedDay = -1; // Reset selected day when year or month changes
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(selectedYear, selectedMonth);

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Calendar",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          // Dropdown for year selection
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: DropdownButton<int>(
              value: selectedYear,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownColor: Colors.deepPurple,
              items: List.generate(
                10,
                (index) => DropdownMenuItem(
                  value: DateTime.now().year - 5 + index,
                  child: Text(
                    "${DateTime.now().year - 5 + index}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onChanged: (value) {
                _updateYearOrMonth(value!, selectedMonth);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar Header with month selection
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    final newMonth =
                        selectedMonth == 1 ? 12 : selectedMonth - 1;
                    final newYear =
                        selectedMonth == 1 ? selectedYear - 1 : selectedYear;
                    _updateYearOrMonth(newYear, newMonth);
                  },
                ),
                Text(
                  "${DateFormat('MMMM yyyy').format(DateTime(selectedYear, selectedMonth))}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    final newMonth =
                        selectedMonth == 12 ? 1 : selectedMonth + 1;
                    final newYear =
                        selectedMonth == 12 ? selectedYear + 1 : selectedYear;
                    _updateYearOrMonth(newYear, newMonth);
                  },
                ),
              ],
            ),
          ),
          // Calendar Grid
          Expanded(
            flex: 3,
            child: CalendarGrid(
              selectedDay: selectedDay,
              daysInMonth: daysInMonth,
              selectedYear: selectedYear,
              selectedMonth: selectedMonth,
              onDateSelected: (day) {
                setState(() {
                  selectedDay = day;
                });
              },
            ),
          ),
          // Event List
          Expanded(
            flex: 3,
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(
                  date: event["date"]!,
                  type: event["type"]!,
                  name: event["name"]!,
                  color: event["color"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarGrid extends StatefulWidget {
  final int selectedDay;
  final int daysInMonth;
  final int selectedYear;
  final int selectedMonth;
  final Function(int) onDateSelected;

  CalendarGrid({
    required this.selectedDay,
    required this.daysInMonth,
    required this.selectedYear,
    required this.selectedMonth,
    required this.onDateSelected,
  });

  @override
  _CalendarGridState createState() => _CalendarGridState();
}

class _CalendarGridState extends State<CalendarGrid> {
  List<int> getDaysGrid() {
    final firstDayOfMonth =
        DateTime(widget.selectedYear, widget.selectedMonth, 1).weekday;
    final daysInPreviousMonth =
        DateTime(widget.selectedYear, widget.selectedMonth, 0).day;

    // Fill leading days from previous month
    final leadingDays = List.generate(firstDayOfMonth - 1,
        (i) => daysInPreviousMonth - (firstDayOfMonth - 2) + i);

    // Fill current month's days
    final currentMonthDays = List.generate(widget.daysInMonth, (i) => i + 1);

    // Fill trailing days for next month
    final trailingDays = List.generate(
      (7 - ((leadingDays.length + currentMonthDays.length) % 7)) % 7,
      (i) => i + 1,
    );

    return [...leadingDays, ...currentMonthDays, ...trailingDays];
  }

  @override
  Widget build(BuildContext context) {
    final daysGrid = getDaysGrid();

    return Column(
      children: [
        // Weekdays header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        // Calendar dates grid
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: daysGrid.length,
            itemBuilder: (context, index) {
              final day = daysGrid[index];
              final isCurrentMonthDay = index >=
                  (daysGrid.length - widget.daysInMonth) -
                      (7 - widget.daysInMonth % 7);
              final isSelected = widget.selectedDay == day && isCurrentMonthDay;
              return GestureDetector(
                onTap: isCurrentMonthDay
                    ? () => widget.onDateSelected(day)
                    : null, // Disable selection for days outside the current month
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.deepPurple : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Colors.white
                          : isCurrentMonthDay
                              ? Colors.black
                              : Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatefulWidget {
  final String date;
  final String type;
  final String name;
  final String color;

  EventCard({
    required this.date,
    required this.type,
    required this.name,
    required this.color,
  });

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  Color getCardColor(String colorName) {
    switch (colorName) {
      case "pink":
        return Colors.green[100]!;
      case "blue":
        return Colors.pink[100]!;
      case "green":
        return Colors.blue[100]!;
      default:
        return Colors.pink[100]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: getCardColor(widget.color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Text(
              widget.date,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.type,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
