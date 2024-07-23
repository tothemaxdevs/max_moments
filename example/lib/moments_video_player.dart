import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_moments/max_moments.dart';

class MomentVideoPlayer extends StatefulWidget {
  const MomentVideoPlayer({super.key});

  @override
  State<MomentVideoPlayer> createState() => _MomentVideoPlayerState();
}

Map<String, dynamic> params = {};

class _MomentVideoPlayerState extends State<MomentVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MaxMomentsVideoPlayer(
        url: '',
      ),
    );
  }
}
