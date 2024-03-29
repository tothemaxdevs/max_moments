import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_moments/max_moments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? title;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaxMoments(
        url: 'https://merchant.backend.dev.orderia.id/api/merchant/',
        urlGateway: 'https://file.dev.orderia.id/api/',
        apiKey: '0f99beea-bfbf-11ec-9708-ef87d9a9c4d9',
        accessToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhjYTc4NjUzLTQxYWEtNGZkYi05YmFhLWY1Yjg5Yzk2N2JlZCIsImlhdCI6MTcxMTAxMDM3MX0.81DsEVobnt3oRloK7TsTYjs283t1P1wf_MWF5G5PUtY',
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
