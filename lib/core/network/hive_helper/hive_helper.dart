import "package:hive_flutter/hive_flutter.dart";

import "../../constants/constants.dart";

abstract class HiveHelper {

  static Future<void>init()async{
    await Hive.initFlutter();
    await Hive.openBox(KConst.dataBoxName);
  }

  static void put({
    required String boxName,
    required dynamic key,
    required dynamic value,
  }){
    Hive.box(boxName).put(key, value);
  }

  static void putAt({
    required String boxName,
    required int index,
    required dynamic value,
  }){
    Hive.box(boxName).putAt(index,value);
  }

  static void putAll({
    required String boxName,
    required Map<dynamic,dynamic>data,
  }){
    Hive.box(boxName).putAll(data);
  }

  static void add({
    required String boxName,
    required dynamic value,
  }){
    Hive.box(boxName).add(value);
  }

  static void addAll({
    required String boxName,
    required List<dynamic> values,
  }){
     Hive.box(boxName).addAll(values);
  }

  static T get<T>({
    required String boxName,
    required dynamic key,
    dynamic defaultValue,
  }){
    return  Hive.box(boxName).get(key, defaultValue: defaultValue);
  }

  static T getAt<T>({
    required String boxName,
    required int index,
  }){
    return Hive.box(boxName).getAt(index);
  }

  static void delete({
    required String boxName,
    required dynamic key,
  }){
    Hive.box(boxName).delete(key);
  }

  static void deleteAt({
    required String boxName,
    required int index,
  }){
    Hive.box(boxName).deleteAt(index);
  }

  static void deleteAll({
    required String boxName,
    required List<dynamic> keys,
  }){
    Hive.box(boxName).deleteAll(keys);
  }

  static Future<void>clear({
    required String boxName,
  })async{
    await Hive.box(boxName).clear();
  }

  static Future<void>deleteFromDisk({
    required String boxName,
  })async{
    await Hive.box(boxName).deleteFromDisk();
  }


}