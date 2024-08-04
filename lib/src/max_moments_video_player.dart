import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:max_moments/max_moments.dart';
import 'package:max_moments/utils/view/view_utils.dart';

class MaxMomentsVideoPlayer extends StatefulWidget {
  final String url;

  const MaxMomentsVideoPlayer({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  _MaxMomentsVideoPlayerState createState() => _MaxMomentsVideoPlayerState();
}

class _MaxMomentsVideoPlayerState extends State<MaxMomentsVideoPlayer> {
  late VideoPlayerController controller;
  bool isMute = false;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.url,
      ),
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
      httpHeaders: {
        'Connection': 'keep-alive',
      },
    )..initialize().then((value) async {
        await controller.setLooping(true);
        controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(
        context,
        title: "",
        actions: [
          GestureDetector(
            onTap: () {
              muteUnmuteAll();
            },
            child: Container(
                height: 30,
                width: 30,
                color: Colors.transparent,
                child: Icon(
                  isMute == false
                      ? Icons.volume_up_outlined
                      : Icons.volume_off_outlined,
                  color: Colors.white,
                )),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  )
                : const CircularProgressIndicator.adaptive(),
          ),
          ReelsWidget(
            playerController: controller,
          ),
        ],
      ),
    );
  }

  void muteUnmuteAll() {
    isMute = !isMute;
    if (isMute == true) {
      controller.setVolume(0.0);
    } else {
      controller.setVolume(10.0);
    }
    setState(() {});
  }
}
