import "package:cloud_firestore/cloud_firestore.dart";
import 'package:location_app/model/event.dart';

class MyDatabaseService {
  final String? locationFile;
  MyDatabaseService({this.locationFile});

  final CollectionReference bookingLocations =
      FirebaseFirestore.instance.collection("LocationCollection");
//  why you are not specifying the return type?
  Future updateLocationData(
      EventModel event ) async {
    return await bookingLocations.doc().set({
      "From": event.From,
      "To": event.To,
      "Price": event.Price,
      "Date": event.Date
    });
  }
    
  Future<List<EventModel>> getLocationCollectionData() async {
    return await bookingLocations.get().then((QuerySnapshot res) { 
    return res.docs
    .map((e) => EventModel(From: e['From'], To: e['To'], Price: e['Price'], Date: e['Date'].toDate()))
    .toList();
    });
  }
}
