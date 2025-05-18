import 'dart:developer';

import 'package:fcm_notification/local_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  ///init work manager
 Future<void>  init() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    //register task must be after init
    registerTask();
  }
//method that register task
  void registerTask() async {
    await Workmanager().registerOneOffTask("id1", "show simple notification ");
  }

// method that handle task & method that init want and her i give him my task
  callbackDispatcher() async {
    LocalService.showBasicNotification();
    Workmanager().executeTask((taskName, inputData) {
      return Future.value(true);
    });
  }

  void cancelOneTask(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}
