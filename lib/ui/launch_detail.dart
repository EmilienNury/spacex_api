import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_api/core/manager/api_manager.dart';
import 'package:spacex_api/core/model/launch.dart';
import 'package:spacex_api/ui/components/image_placeholder.dart';

class LaunchDetailArguments {
  Launch launch;

  LaunchDetailArguments({required this.launch});
}

class LaunchDetail extends StatefulWidget {
  static const route = "/spot";

  final Launch launch;

  const LaunchDetail(this.launch, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LaunchDetailState();
}

class _LaunchDetailState extends State<LaunchDetail> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager().getLaunchDetail(widget.launch),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var launch = snapshot.data as Launch;
            return Scaffold(
              appBar: AppBar(
                title: Text(launch.name ?? ''),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Image.network(
                          launch.links?.patch?.large ?? '',
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, child, stack) {
                            return const ImagePlaceholder();
                          },
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(
                                launch.name ?? '',
                                style: const TextStyle(fontSize: 20),
                              ),
                              SizedBox(width: 16),
                              /*LikeButton(
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.favorite,
                                size: 32.0,
                                color: isLiked ? Colors.pink : Colors.grey,
                              );
                            },
                            onTap: onLikeButtonTapped,
                          ),*/
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 40,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, position) {
                                return const SizedBox(
                                  width: 8,
                                );
                              },
                              itemBuilder: (context, position) {
                                String? tag;
                                MaterialColor color;
                                if (launch.success != null) {
                                  if (launch.success!) {
                                    tag = "Success";
                                    color = Colors.green;
                                  } else {
                                    tag = "Failure";
                                    color = Colors.red;
                                  }
                                } else {
                                  tag = "Not launched yet";
                                  color = Colors.grey;
                                }

                                return Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: Center(
                                      child: Text(
                                    tag,
                                    style: const TextStyle(color: Colors.white),
                                  )),
                                );
                              },
                              itemCount: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                              "Date : ${DateFormat.yMd().add_Hm().format(launch.date_utc?.toLocal() ?? DateTime.now())}"),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(launch.details ?? ""),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
/*Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }*/
}
