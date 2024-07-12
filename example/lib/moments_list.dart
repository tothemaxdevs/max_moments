import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_moments/max_moments.dart';

class MomentList extends StatefulWidget {
  const MomentList({super.key});

  @override
  State<MomentList> createState() => _MomentListState();
}

Map<String, dynamic> params = {};

class _MomentListState extends State<MomentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaxMoments(
        url: 'https://content.dev.orderia.id/api/v1/',
        urlGateway: 'https://file.dev.orderia.id/api/',
        apiKey: '0f99beea-bfbf-11ec-9708-ef87d9a9c4d9',
        additionalParams: params,
        accessToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ1ZjY0NTNjLTZhNzEtNDIzNS05MGRmLWZiMWFhNWNhNzFlYSIsImlhdCI6MTcyMDA4MDc2NX0.LwURhC0BO6K3WOucfgYFJ0P2ZQ86yslbjHNyolfu45A',
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
