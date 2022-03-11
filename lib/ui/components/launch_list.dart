import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_api/core/model/launch.dart';
import 'package:spacex_api/ui/components/image_placeholder.dart';
import 'package:spacex_api/ui/launch_detail.dart';

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
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(LaunchDetail.route,
                arguments: LaunchDetailArguments(launch: launch));
          },
          child: Row(
            children: [
              SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    launch.links?.patch?.small ?? '',
                    fit: BoxFit.scaleDown,
                    errorBuilder: (context, child, stack) {
                      return const ImagePlaceholder();
                    },
                  )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      launch.name ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        "Date : ${DateFormat.yMd().add_Hm().format(launch.date_utc?.toLocal() ?? DateTime.now())}")
                  ],
                ),
              )
            ],
          ),
        );
      },
      itemCount: launches.length,
    );
  }
}
