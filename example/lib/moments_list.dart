import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_moments/max_moments.dart';

class MomentList extends StatefulWidget {
  const MomentList({super.key});

  @override
  State<MomentList> createState() => _MomentListState();
}

class _MomentListState extends State<MomentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaxMoments(
        url: '',
        urlGateway: '',
        apiKey: '',
        accessToken: '',
        onMomentChanged: (v) {
          log(v!);
        },
        onTapDelete: (v) {
          log('Delete Tapped');
          log(v!);
        },
        onEdited: () {},
      ),
    );
  }
}
