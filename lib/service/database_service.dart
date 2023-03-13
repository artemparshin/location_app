import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_app/model/event_model.dart';

class MyDatabaseService {
  final String? locationFile;
  MyDatabaseService({this.locationFile});

  final CollectionReference bookingLocations =
      FirebaseFirestore.instance.collection("LocationCollection");

  final CollectionReference userCollection =
    FirebaseFirestore.instance.collection("user");

  get uid => FirebaseAuth.instance.currentUser?.uid;

  Future updateLocationData(
      EventModel event ) async {
        
    return await bookingLocations.doc().set({
      "From": event.From,
      "To": event.To,
      "Price": event.Price,
      "Date": event.Date,
      "user": uid
    });
  }
  
  Future<List<EventModel>> getLocationCollectionData() async {
    return await bookingLocations.where("user", isEqualTo: uid).get().then((QuerySnapshot res) { 
    return res.docs
    .map((e) => EventModel(From: e['From'], To: e['To'], Price: e['Price'], Date: e['Date'].toDate()))
    .toList();
    });
  }
}
