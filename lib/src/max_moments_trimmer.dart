import 'dart:io';

import 'package:flutter/material.dart';
import 'package:max_moments/src/max_moments_manager.dart';
import 'package:max_moments/utils/view/view_utils.dart';
import 'package:video_trimmer/video_trimmer.dart';

class MaxMomentsTrimmer extends StatefulWidget {
  final File file;
  final String accessToken;
  final String apiKey;
  final String url;
  final String urlGateway;

  const MaxMomentsTrimmer(
    this.file, {
    Key? key,
    required this.accessToken,
    required this.apiKey,
    required this.url,
    required this.urlGateway,
  }) : super(key: key);
  @override
  State<MaxMomentsTrimmer> createState() => _MaxMomentsTrimmerState();
}

class _MaxMomentsTrimmerState extends State<MaxMomentsTrimmer> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  @override
  void initState() {
    super.initState();

    _loadVideo();
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file);
  }

  _saveVideo() {
    setState(() {
      _progressVisibility = true;
    });

    _trimmer.saveTrimmedVideo(
      startValue: _startValue,
      endValue: _endValue,
      onSave: (outputPath) {
        setState(() {
          _progressVisibility = false;
        });
        debugPrint('OUTPUT PATH: $outputPath');

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MaxMomentsManager(
                      accessToken: widget.accessToken,
                      apiKey: widget.apiKey,
                      url: widget.url,
                      outputVideoPath: outputPath,
                      urlGateway: widget.urlGateway,
                    )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: appBar(context, title: 'ATUR MOMENT', actions: [
          TextButton(
              onPressed: _progressVisibility ? null : () => _saveVideo(),
              child: Text(
                'Selanjutnya',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.amber[700]),
              ))
        ]),
        body: Center(
          child: Container(
            padding: const EdgeInsets.only(bottom: 30.0, top: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Visibility(
                  visible: _progressVisibility,
                  child: const LinearProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
                Expanded(
                    child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: VideoViewer(trimmer: _trimmer)),
                  ),
                )),
                TextButton(
                  child: _isPlaying
                      ? const Icon(
                          Icons.pause_rounded,
                          size: 60,
                          color: Colors.black87,
                        )
                      : const Icon(
                          Icons.play_arrow_rounded,
                          size: 60,
                          color: Colors.black87,
                        ),
                  onPressed: () async {
                    bool playbackState = await _trimmer.videoPlaybackControl(
                      startValue: _startValue,
                      endValue: _endValue,
                    );
                    setState(() => _isPlaying = playbackState);
                  },
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TrimViewer(
                      trimmer: _trimmer,
                      viewerHeight: 50.0,
                      durationTextStyle: const TextStyle(color: Colors.black),
                      viewerWidth: MediaQuery.of(context).size.width,
                      durationStyle: DurationStyle.FORMAT_HH_MM_SS,
                      maxVideoLength: const Duration(minutes: 5),
                      editorProperties: TrimEditorProperties(
                        borderPaintColor: Colors.yellow,
                        borderWidth: 4,
                        borderRadius: 5,
                        circlePaintColor: Colors.yellow.shade800,
                      ),
                      areaProperties: TrimAreaProperties.edgeBlur(
                        thumbnailQuality: 10,
                      ),
                      onChangeStart: (value) => _startValue = value,
                      onChangeEnd: (value) => _endValue = value,
                      onChangePlaybackState: (value) =>
                          setState(() => _isPlaying = value),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
