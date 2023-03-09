import 'package:flutter/material.dart';
import 'package:location_app/service/database_service.dart';
import 'package:location_app/model/event_model.dart';
import 'calendar_tab.dart';
import 'package:intl/intl.dart';

class AddTab extends StatefulWidget {
  const AddTab({super.key});

  @override
  State<AddTab> createState() => _AddTabState();
}

class _AddTabState extends State<AddTab> {
  int currentTabIndex = 1;

  final FromController = TextEditingController();
  final ToController = TextEditingController();
  final PriceController = TextEditingController();
  final DateController = TextEditingController();  

  @override
  void dispose() {
    FromController.dispose();
    ToController.dispose();
    PriceController.dispose();
    DateController.dispose();   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add location"), automaticallyImplyLeading: false),
      body: SizedBox(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("From"),
              TextFormField(controller: FromController),
              const Text("To"),
              TextFormField(controller: ToController),
              const Text("Price"),
              TextFormField(controller: PriceController),
              const Text("Date"),
              TextFormField(controller: DateController,
                onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2025),)
                      .then((selectedDate) {
                      if (selectedDate != null) {
                        DateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                      }
                    });
                }),
              ElevatedButton(
                  onPressed: () {
                    EventModel event = EventModel(
                        From: FromController.text,
                        To: ToController.text,
                        Price: int.parse(PriceController.text),
                        Date: DateTime.parse(DateController.text));
                    MyDatabaseService().updateLocationData(event);
                  },
                  child: const Text("Send"))
            ]),
      ),
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
            Value == 0
                ? Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const CalendarTab();
                  }))
                : null;
          });
        },
      ),
    );
  }
}
