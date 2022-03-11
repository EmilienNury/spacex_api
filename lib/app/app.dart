import 'package:flutter/material.dart';
import 'package:spacex_api/core/model/launch.dart';
import 'package:spacex_api/ui/home.dart';
import 'package:spacex_api/ui/launch_detail.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX launches',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        var arguments = settings.arguments;
        switch (settings.name) {
          case LaunchDetail.route:
            if (arguments != null && arguments is LaunchDetailArguments) {
              Launch launch = arguments.launch;
              return MaterialPageRoute(builder: (_) => LaunchDetail(launch));
            } else {
              throw Exception(
                  "Cette route doit avoir un objet LaunchDetailArgument en argument");
            }

          default:
            return unknownRoute();
        }
      },
      home: const HomePage(title: 'SpaceX launches'),
    );
  }

  MaterialPageRoute unknownRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(child: Text("Route inconnue")),
            ));
  }
}
