import 'package:flutter/material.dart';
import 'package:max_moments/max_moments.dart';

class ReelsWidget extends StatefulWidget {
  final CachedVideoPlayerController playerController;

  const ReelsWidget({Key? key, required this.playerController})
      : super(key: key);

  @override
  State<ReelsWidget> createState() => _ReelsWidgetState();
}

class _ReelsWidgetState extends State<ReelsWidget> {
  late CachedVideoPlayerController _videoPlayerController;

  bool pause = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = widget.playerController;

    setState(() {
      _videoPlayerController.seekTo(Duration.zero);
      _videoPlayerController.setLooping(true);
      _videoPlayerController.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _videoPlayerController.dispose();
    _videoPlayerController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print("widget.cont?.page");
        // print(_videoPlayerController.value.aspectRatio);
        pause = !pause;
        if (pause == true) {
          _videoPlayerController.pause();
        } else {
          _videoPlayerController.play();
        }
        setState(() {});
      },
      child: Stack(
        children: [
          _videoPlayerController.value.aspectRatio > 0.6
              ? Center(
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: CachedVideoPlayer(_videoPlayerController),
                  ),
                )
              : CachedVideoPlayer(_videoPlayerController),
          pause
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}
