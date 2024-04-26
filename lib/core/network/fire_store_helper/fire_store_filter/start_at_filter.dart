import 'package:cloud_firestore/cloud_firestore.dart';

import 'fire_store_filter.dart';

class StartAtFilter extends FireStoreFilter{
  final List values;

  const StartAtFilter({required this.values});

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference,
  )=>collectionReference.startAt(values);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.startAt(values);

  @override
  List<Object?> get props =>[values];
  
}