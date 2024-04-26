import 'package:cloud_firestore/cloud_firestore.dart';

import 'fire_store_filter.dart';

class StartAfterFilter extends FireStoreFilter{
  final List values;

  const StartAfterFilter({required this.values});

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference,
  )=>collectionReference.startAfter(values);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.startAfter(values);

  @override
  List<Object?> get props =>[values];
  
}