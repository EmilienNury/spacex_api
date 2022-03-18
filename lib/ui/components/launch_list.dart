import 'package:flutter/material.dart';
import 'package:spacex_api/core/model/launch.dart';
import 'package:spacex_api/ui/components/launch_list_item.dart';

class LaunchList extends StatelessWidget {
  final List<Launch> launches;

  const LaunchList(this.launches, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        Launch launch = launches[position];
        return LaunchListItem(launch);
      },
      itemCount: launches.length,
    );
  }
}
