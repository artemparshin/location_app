import 'package:flutter/material.dart';
import 'package:location_app/main.dart';
import 'package:location_app/model/event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'add_tab.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});
  @override
  State<CalendarTab> createState() => CalendarState();
}

class CalendarState extends State<CalendarTab> {
  
  List<EventModel> eventList = MyAppState.eventListMain.value; 
  int currentTabIndex = 0;
  ValueNotifier<bool> notifier = ValueNotifier(false);
  ValueNotifier<DateTime> mySelectedDay = ValueNotifier(DateTime.now());

EventModel? getIndex(DateTime day) {
    for (var event in eventList) {
      if ((event.Date.day == day.day) &&
          (event.Date.month == day.month) &&
          (event.Date.year == day.year)) {
        return event;
      }
    }
  }
  
  List<String> getEventsForDay(DateTime day) {
    if (eventList.any((element) => element.Date.day == day.day) &&
        eventList.any((element) => element.Date.month == day.month) &&
        eventList.any((element) => element.Date.year == day.year)) {
      return [""];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Calendar"), automaticallyImplyLeading: false),
      body: Column(children: [
        TableCalendar(
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              mySelectedDay.value = selectedDay;
              setState(() {});
            },
            selectedDayPredicate: (day) {
              // bool predicate = false;
              // if (mySelectedDay == day || mySelectedDay == DateTime.now()) {
              //   predicate = true;
              // }
              // return predicate;
              return isSameDay(mySelectedDay.value, day);
            },
            firstDay: DateTime.utc(2010),
            lastDay: DateTime.utc(2030),
            focusedDay: DateTime.now(),
            eventLoader: (day) {
              return getEventsForDay(day);
            }),
        ValueListenableBuilder(
          valueListenable: mySelectedDay,
          builder: (BuildContext context, dynamic value, Widget? child) {
            return (eventList.isNotEmpty && getIndex(value) != null) ? Expanded(child: Column(
              children: [
                Row(
                  children: [const Text("From "), Text(getIndex(value)!.From)],
                ),
                Row(
                  children: [const Text("To "), Text(getIndex(value)!.To)],
                ),
                Row(
                  children: [const Text("Price "), Text(getIndex(value)!.Price.toString())],
                ),
                Row(
                  children: [const Text("Date "), Text(getIndex(value)!.Date.toString())],
                )
              ],
            )) : const SizedBox();
          },
        ) 
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.border_color), label: "Add")
        ],
        currentIndex: currentTabIndex,
        onTap: (Value) {
          setState(() {
            currentTabIndex = Value;
            Value == 1
                ? Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const AddTab();
                  }))
                : null;
          });
        },
      ),
    );
  } 
}

