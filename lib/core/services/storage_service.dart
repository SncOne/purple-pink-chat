import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/constants.dart';
import '../../utils/print.dart';

final storageService = Provider((_) => StorageService());

/// final storage = ref.watch(storageService);
///
/// storage.box().get(C.token);
class StorageService {
  final _service = 'StorageService';

  Box<T> box<T>([String? name]) {
    return name != null ? Hive.box<T>(name) : Hive.box(C.hive.app);
  }

  void put(String key, Object? value) {
    Print.log('put', _service);
    box().put(key, value);
  }

  void putAt(int index, Object? value) {
    Print.log('putAt', _service);
    box().putAt(index, value);
  }

  Object? get(String key) {
    Print.log('get', _service);
    return box().get(key);
  }

  Object? getAt(int index) {
    Print.log('getAt', _service);
    return box().getAt(index);
  }

  Future<void> delete(String key) async {
    Print.log('delete', _service);
    await box().delete(key);
  }

  Future<void> deleteAt(int index) async {
    Print.log('deleteAt', _service);
    await box().deleteAt(index);
  }

  Future<int> clear() async {
    Print.log('clear', _service);
    return await box().clear();
  }

  Stream<BoxEvent> watch(String key) {
    Print.log('watch', _service);
    return box().watch(key: key);
  }

  List valuesBetween({Object? startKey, Object? endKey}) {
    Print.log('valuesBetween', _service);
    return box().valuesBetween(startKey: startKey, endKey: endKey).toList();
  }

  Future<void> close() async {
    Print.log('close', _service);
    await box().close();
  }

  void setLastSeenDateTime(String roomId, DateTime date) {
    Print.log('setUnreadMessageDateTime', _service);
    box().put('unread_$roomId', date.millisecondsSinceEpoch);
  }

  int getLastSeenDateTime(String roomId) {
    Print.log('getLastSeenDateTime', _service);
    final lastSeen = box().get('unread_$roomId') as int?;
    return lastSeen ?? DateTime.now().millisecondsSinceEpoch;
  }

  // New methods for unread message counts
  void incrementUnreadCount(String userId) {
    Print.log('incrementUnreadCount', _service);
    int count = box().get('unread_$userId', defaultValue: 0) as int;
    count++;
    box().put('unread_$userId', count);
  }

  void decrementUnreadCount(String userId) {
    Print.log('decrementUnreadCount', _service);
    int count = box().get('unread_$userId', defaultValue: 0) as int;
    if (count > 0) {
      count--;
      box().put('unread_$userId', count);
    }
  }

  int getUnreadCount(String userId) {
    Print.log('getUnreadCount', _service);
    return box().get('unread_$userId', defaultValue: 0) as int;
  }

  void resetUnreadCount(String userId) {
    Print.log('resetUnreadCount', _service);
    box().put('unread_$userId', 0);
  }
}
