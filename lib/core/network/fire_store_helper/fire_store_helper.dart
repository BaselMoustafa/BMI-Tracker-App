import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'fire_store_filter/fire_store_filter.dart';
import 'fire_store_filter/firestore_filter_manager.dart';
import 'fire_store_reference/fire_store_reference.dart';
import 'get_collection_output.dart';
import 'update_info/fire_store_update.dart';

abstract class FireStoreHelper extends Equatable{

  static final FirebaseFirestore _fireStore=FirebaseFirestore.instance;
  
  static Future<Map<String,dynamic>>getDocument({required List<String>path})async{
    DocumentSnapshot documentSnapshot= await FireStoreReference(path: path,fireStore: _fireStore,).getDocumentReference().get();
    return documentSnapshot.data() as Map<String,dynamic>;
  }

  static Future<GetCollectionOutput>getCollection({required List<String>path,List<FireStoreFilter>fireStoreFilters = const[]})async{
    final List<Map<String,dynamic>>data=[];
    CollectionReference reference=FireStoreReference(path: path,fireStore: _fireStore,).getCollectionReference();
    Query? query=FireStoreFilterManager(collectionReference: reference, fireStoreFilters: fireStoreFilters).query;
    QuerySnapshot querySnapshot= query==null? await reference.get(): await query.get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      data.add(querySnapshot.docs[i].data() as Map<String,dynamic>);
    }
    return GetCollectionOutput(data: data, docs: querySnapshot.docs);
  }

  static Future<String> add({required List<String> collectionPath,required Map<String, dynamic> data}) async{
    DocumentReference documentReference= FireStoreReference(fireStore: _fireStore, path: collectionPath).getCollectionReference().doc();
    
    documentReference.set({
      "id": documentReference.id,
      ...data,
    });
    return documentReference.id;
  }
  
  static Future<void> set({required List<String> documentPath, required Map<String, dynamic> data, bool merge = false}) async{
    await FireStoreReference(fireStore: _fireStore, path: documentPath)
    .getDocumentReference().set({
      "id":documentPath.last,
      ...data
    },SetOptions(merge: merge));
  }
  
  static Future<void> update({required List<String> documentPath,required List<FireStoreUpdate> updates}) async {
    Map<String,dynamic>data={};
    for (var i = 0; i < updates.length; i++) {
      updates[i].addThisUpdateToMap(data);
    }
    await FireStoreReference(fireStore: _fireStore, path: documentPath)
    .getDocumentReference().update(data);
  }
  
  static Future<void> deleteDocument({required List<String> documentPath}) async{
    await FireStoreReference(fireStore: _fireStore, path: documentPath)
    .getDocumentReference().delete();
  }

  static Future<void> deleteCollection({required List<String> collectionPath,List<FireStoreFilter>fireStoreFilters = const[]})async {
    CollectionReference reference=FireStoreReference(path: collectionPath,fireStore: _fireStore,).getCollectionReference();
    Query? query=FireStoreFilterManager(collectionReference: reference, fireStoreFilters: fireStoreFilters).query;
    QuerySnapshot querySnapshot= query==null? await reference.get(): await query.get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      querySnapshot.docs[i].reference.delete();
    }
  }
  
  static Future documentIsExists({required List<String> path})async {
    DocumentSnapshot documentSnapshot=await FireStoreReference(
      fireStore: _fireStore, path: path
    ).getDocumentReference().get();
    return documentSnapshot.exists;
  }

  static Future<int>numOfDocuments({required List<String>path,List<FireStoreFilter>fireStoreFilters = const[]})async{
    CollectionReference reference=FireStoreReference(path: path,fireStore: _fireStore,).getCollectionReference();
    Query? query=FireStoreFilterManager(collectionReference: reference, fireStoreFilters: fireStoreFilters).query;
    AggregateQuerySnapshot aggregateQuerySnapshot=query==null? await reference.count().get(): await query.count().get();
    return aggregateQuerySnapshot.count??0;
  }

  @override
  List<Object?> get props => [_fireStore];

}