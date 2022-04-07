import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/notification_config.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

Future init() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  } on Exception catch (error) {
    print("Erro $error");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String notificationTitle = "Vazio";
  String notificationBody = "Vazio";
  String notificationData = "Vazio";
  @override
  void initState() {
    final firebaseMessaging = FirebaseCloudMessaging();
    firebaseMessaging.setNotification();
    firebaseMessaging.streamCtrl.stream.listen(_setDadosNotification);
    firebaseMessaging.titleCtrl.stream.listen(_setDadosTitle);
    firebaseMessaging.bodyCtrl.stream.listen(_setDadosBody);
    super.initState();
  }

  _setDadosNotification(String msg) => setState(() => notificationData = msg);
  _setDadosTitle(String msg) => setState(() => notificationTitle = msg);
  _setDadosBody(String msg) => setState(() => notificationBody = msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notification"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "🔔 Flutter Notification 🔔",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                notificationTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                notificationBody,
                textAlign: TextAlign.center,
              ),
              //Text(notificationData),
            ],
          ),
        ),
      ),
    );
  }
}
