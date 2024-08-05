import 'dart:developer';

import 'environtment.dart';
import 'package:flutter/material.dart';
import 'package:max_moments/max_moments.dart';

class MomentList extends StatefulWidget {
  const MomentList({super.key});

  @override
  State<MomentList> createState() => _MomentListState();
}

Map<String, dynamic> params = {};

class _MomentListState extends State<MomentList> {
  MaxConfig maxConfig = MaxConfig();

  Map<String, dynamic> params = {};

  @override
  void initState() {
    _setInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaxMoments(
        url: maxConfig.url!,
        apiKey: maxConfig.apiKey!,
        accessToken: maxConfig.accessToken!,
        additionalParams: params,
        showMoreButton: false,
        urlGateway: maxConfig.urlGateway!,
        urlCustomer: maxConfig.urlCustomer!,
        showBookmark: maxConfig.isLogin!,
        onMomentChanged: (p0) {},
      ),
    );
  }

  _setInit() async {
    setState(() {
      maxConfig = MaxConfig(
          url: '${Environment.contentGateWay}v1/',
          urlCustomer: '${Environment.endpointApi}v1/',
          apiKey: Environment.apikey,
          accessToken:
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQyNDk5NDBkLWQ2YTgtNDg5ZC04OTI0LTE4NmQ2ODg5YjQzOSIsImlhdCI6MTcyMjYxNTY0NH0.ke9HU1yiQKIysIs8JZvhQfwZo_vHXnuuMfNNHEwmn1c',
          isLogin: true,
          urlGateway: Environment.fileGateWay2);
    });
  }
}

class MaxConfig {
  String? url, urlGateway, urlCustomer, apiKey, accessToken;
  bool? isLogin;
  MaxConfig(
      {this.accessToken,
      this.apiKey,
      this.url,
      this.urlGateway,
      this.isLogin = false,
      this.urlCustomer});
}
