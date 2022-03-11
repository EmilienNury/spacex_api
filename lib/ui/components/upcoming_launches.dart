import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:spacex_api/core/manager/api_manager.dart';
import 'package:spacex_api/core/model/launch.dart';
import 'package:spacex_api/ui/components/launch_list.dart';

class UpcomingLaunches extends StatelessWidget {
  final String? title;

  const UpcomingLaunches(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager().getUpcomingLaunches(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var upcomingLaunches = snapshot.data as List<Launch>;
          var endTime =
              upcomingLaunches[0].date_utc?.toLocal().millisecondsSinceEpoch ??
                  DateTime.now().millisecondsSinceEpoch + 1000 * 30;
          return Scaffold(
              appBar: AppBar(
                // Here we take the value from the HomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Center(
                    child: Column(
                  children: [
                    Text(title ?? ""),
                    CountdownTimer(endTime: endTime),
                  ],
                )),
                backgroundColor: Colors.blueGrey,
              ),
              body: LaunchList(upcomingLaunches));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ); // trailing comma makes auto-formatting nicer for build methods.
  }
}
