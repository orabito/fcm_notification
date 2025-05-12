import 'package:fcm_notification/local_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
                  onTap: ()  {
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
                  onTap: ()  {
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
              )
            ],
          ),
        ));
  }
}
