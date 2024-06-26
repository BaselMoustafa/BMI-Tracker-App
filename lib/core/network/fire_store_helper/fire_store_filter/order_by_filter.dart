import 'package:cloud_firestore/cloud_firestore.dart';

import 'fire_store_filter.dart';

class OrderByFilter extends FireStoreFilter{
  final String filedName;
  final bool descending;

  const OrderByFilter({
    required this.filedName,
    this.descending=false,
  });

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.orderBy(filedName,descending: descending);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.orderBy(filedName,descending: descending);

  @override
  List<Object?> get props =>[filedName,descending];

}