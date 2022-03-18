import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:spacex_api/core/manager/database_manager.dart';
import 'package:spacex_api/core/model/launch.dart';
import 'package:spacex_api/ui/components/image_placeholder.dart';
import 'package:spacex_api/ui/launch_detail.dart';

class LaunchListItem extends StatefulWidget {
  final Launch launch;

  const LaunchListItem(this.launch, {Key? key}) : super(key: key);

  @override
  State<LaunchListItem> createState() => _LaunchListItemState();
}

class _LaunchListItemState extends State<LaunchListItem> {
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
          return InkWell(
            onTap: () async {
              var result = await Navigator.of(context).pushNamed(LaunchDetail.route,
                  arguments: LaunchDetailArguments(launch: widget.launch));
              if (result != null && result is bool) {
                setState(() {

                });
              }
            },
            child: Row(
              children: [
                SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      widget.launch.links?.patch?.small ?? '',
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
                        widget.launch.name ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                          "Date : ${DateFormat.yMd().add_Hm().format(widget.launch.date_utc?.toLocal() ?? DateTime.now())}")
                    ],
                  ),
                ),
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
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          );
        });
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    if (isLiked) {
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
