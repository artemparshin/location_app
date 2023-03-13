import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location_app/model/event_model.dart';
import 'package:location_app/service/database_service.dart';
import 'package:location_app/views/welcome_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'add_tab.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});
  @override
  State<CalendarTab> createState() => CalendarState();
}

class CalendarState extends State<CalendarTab> {
  
  @override
  void initState() {
    MyDatabaseService().getLocationCollectionData().then((value) {eventList = value;});
    super.initState();
  }
  
  static List<EventModel> eventList = List.empty();

  static ValueNotifier<DateTime> _mySelectedDay = ValueNotifier(DateTime.now());

  static DateTime _focusedDay = DateTime.now();

  int currentTabIndex = 0;

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
    if (eventList.any((element) => element.Date.day == day.day && element.Date.month == day.month && element.Date.year == day.year)) {
      return [""];
    }
    return [];
  }

  Widget _signOut(BuildContext context) {
      return ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
            return const WelcomeScreen();
          }));
        },
        child: const Text("Sign out")
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Calendar"), automaticallyImplyLeading: false),
      body: Column(children: [
        _signOut(context),
        TableCalendar(
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              setState(() {
                _mySelectedDay.value = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_mySelectedDay.value, day);
            },
            firstDay: DateTime.utc(2010),
            lastDay: DateTime.utc(2030),
            focusedDay: _focusedDay,
            eventLoader: (day) {
              return getEventsForDay(day);
            }),
        ValueListenableBuilder(
          valueListenable: _mySelectedDay,
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
            )) : const SizedBox.shrink();
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

