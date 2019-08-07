import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final Firestore db = Firestore.instance;
  final ref = Firestore.instance
      .collection('users')
      .document('nico')
      .collection('foods');
  final refExp = Firestore.instance
      .collection('users')
      .document('nico')
      .collection('drinks');

  /// Query a subcollection
//  Stream<List<Food>> streamFoods() {
////    List<Food> _li stOfFoods = [];
//    var ref = _db.collection('Food');
//
//    return ref.snapshots().map((list) => list.documents.map((doc) {
//          return Food.fromSnapshot(doc);
//        }).toList());
//  }

  Future<List<DocumentSnapshot>> fetchSnapshot() async {
    QuerySnapshot theItems;
//    var _ref = db.collection('users').document('datacode').collection('Food');
//    debugPrint('ref is ' + ref.toString());
    theItems = await ref.getDocuments();
    debugPrint('List of Items are: ${theItems.documents.length}');
    return theItems.documents;
  }

//  Future<List<DocumentSnapshot>> fetchSnapshot() async {
//    QuerySnapshot theItems;
////    var _ref = db.collection('users').document('datacode').collection('Food');
////    debugPrint('ref is ' + ref.toString());
//    theItems = await ref.getDocuments();
//    debugPrint('List of Items are: ${theItems.documents.length}');
//    return theItems.documents;
//  }
}
