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
        url: 'https://content.stg.orderia.id/api/v1/',
        urlGateway: 'https://file.stg.orderia.id/api/v1/',
        urlCustomer: 'https://customer.backend.stg.orderia.id/api/v1/',
        apiKey: '0f99beea-bfbf-11ec-9708-ef87d9a9c4d9',
        showBookmark: true,
        additionalParams: params,
        accessToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNmOGNkOTIzLWU4NmQtNDk0Ni05MzUxLThmNWVlN2IyNTA4NiIsImlhdCI6MTcyMTMxNDQwOH0.PB6Yiq722XdDoXycpfJTLoTG8BJH39oAiTGlKOomX40',
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
