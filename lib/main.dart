import 'dart:developer';

import 'package:fcm_notification/local_service.dart';
import 'package:fcm_notification/notification_details.dart';
import 'package:fcm_notification/work_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future.wait([
    LocalService.init(),
    WorkManagerService().init(),
  ]);
  ///i can handel by this way to handel performance
 //  await LocalService.init();
 // await WorkManagerService().init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listenToNotification();
  }

  void listenToNotification() {
    LocalService.streamController.stream.listen((response) {
      log(response.id.toString());
      log(response.payload.toString());
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => NotificationDetailsScreen(response: response),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(color: Colors.amber, Icons.notifications_active),
          title: const Text("Flutter Notification"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(166),
                    color: Colors.tealAccent),
                child: ListTile(
                  onTap: () {
                    LocalService.showBasicNotification();
                  },
                  trailing: IconButton(
                      onPressed: () {
                        LocalService.cancelNotification(0);
                      },
                      icon: const Icon(Icons.cancel_outlined)),
                  title: const Text("Flutter Notification"),
                  leading: const Icon(
                      color: Colors.amber, Icons.notifications_active),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(166),
                    color: Colors.tealAccent),
                child: ListTile(
                  onTap: () {
                    LocalService.showRepeatedNotification();
                  },
                  trailing: IconButton(
                      onPressed: () {
                        LocalService.cancelNotification(1);
                      },
                      icon: const Icon(Icons.cancel_outlined)),
                  title: const Text("Repeated Flutter Notification"),
                  leading: const Icon(
                      color: Colors.amber, Icons.notifications_active),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(166),
                    color: Colors.tealAccent),
                child: ListTile(
                  onTap: () {
                    LocalService.showScheduleNotification();
                  },
                  trailing: IconButton(
                      onPressed: () {
                        LocalService.cancelNotification(2);
                      },
                      icon: const Icon(Icons.cancel_outlined)),
                  title: const Text("schedule Flutter Notification"),
                  leading: const Icon(
                      color: Colors.amber, Icons.notifications_active),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent),
                  onPressed: () {
                    LocalService.cancelAllNotification();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("cancel all"),
                      SizedBox(
                        height: 15,
                      ),
                      Icon(Icons.close),
                    ],
                  ))
            ],
          ),
        ));
  }
}
