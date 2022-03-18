import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:spacex_api/core/manager/database_manager.dart';
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
        future: DataBaseManager().isFavLaunch(widget.launch),
        builder: (context, snapshot) {
          bool liked;
          if (snapshot.hasData) {
            liked = snapshot.data as bool;
          } else {
            liked = false;
          }
          //var launch = snapshot.data as Launch;
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.launch.name ?? ''),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Image.network(
                        widget.launch.links?.patch?.large ?? '',
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
                            LikeButton(
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.favorite,
                                  size: 32.0,
                                  color: isLiked ? Colors.pink : Colors.grey,
                                );
                              },
                              onTap: onLikeButtonTapped,
                              isLiked: liked,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              widget.launch.name ?? '',
                              style: const TextStyle(fontSize: 20),
                            ),
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
                              if (widget.launch.success != null) {
                                if (widget.launch.success!) {
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
                            "Date : ${DateFormat.yMd().add_Hm().format(widget.launch.date_utc?.toLocal() ?? DateTime.now())}"),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(widget.launch.details ?? ""),
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
        });
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    if(isLiked) {
      DataBaseManager().removeFavLaunch(widget.launch);
    } else {
      DataBaseManager().addFavLaunch(widget.launch);
    }
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }
}
