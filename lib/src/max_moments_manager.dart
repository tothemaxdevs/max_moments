import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:max_moments/src/bloc/moment_bloc.dart';
import 'package:max_moments/src/components/max_button.dart';
import 'package:max_moments/src/components/max_text_field.dart';
import 'package:max_moments/src/models/file_upload_gateway/files.dart';
import 'package:max_moments/src/models/moment_list_result/moment.dart';
import 'package:max_moments/utils/view/view_utils.dart';

class MaxMomentsManager extends StatefulWidget {
  final bool? isEdit;
  final String? outputVideoPath;
  final Moment? momentFile;
  final String accessToken;
  final String apiKey;
  final String url;
  final String urlGateway;

  MaxMomentsManager(
      {Key? key,
      this.isEdit = false,
      this.outputVideoPath,
      this.momentFile,
      required this.accessToken,
      required this.apiKey,
      required this.url,
      required this.urlGateway})
      : super(key: key);

  @override
  _MaxMomentsManagerState createState() => _MaxMomentsManagerState();
}

class _MaxMomentsManagerState extends State<MaxMomentsManager> {
  String? title;
  final _formKey = GlobalKey<FormState>();
  bool enableBtn = false;
  bool isLoading = false;
  bool activateComment = false;
  TextEditingController captionController = TextEditingController();
  MomentsBloc? momentBloc;

  MomentVideoStatus momentVideoStatus = MomentVideoStatus();

  @override
  void initState() {
    _initEditMoment();
    if (widget.isEdit == false) {
      postFileMoment();
    }
    super.initState();
    momentBloc = MomentsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context,
            title: 'ATUR MOMENT', textColor: Colors.black, color: Colors.white),
        body: BlocProvider(
          create: (context) => momentBloc!,
          child: BlocConsumer<MomentsBloc, MomentsState>(
              builder: (context, state) {
            return buildView();
          }, listener: (context, state) {
            if (state is CreateMomentLoadingState) {
              isLoading = true;
            } else if (state is CreateMomentLoadedState) {
              Navigator.pop(context, true);
            } else if (state is CreateMomentFailedState) {
              isLoading = false;
            } else if (state is CreateMomentErrorState) {
              isLoading = false;
            }
            if (state is UpdateMomentLoadingState) {
              isLoading = true;
            } else if (state is UpdateMomentLoadedState) {
              Navigator.pop(context, true);
            } else if (state is UpdateMomentFailedState) {
              isLoading = false;
            } else if (state is UpdateMomentErrorState) {
              isLoading = false;
            } else if (state is UploadMomentFileLoadingState) {
            } else if (state is UploadMomentFileProgressState) {
              momentVideoStatus.uploadProgress = state.progress;
              setState(() {});
            } else if (state is UploadMomentFileLoadedState) {
              momentVideoStatus.file = state.data;
              momentVideoStatus.isUploaded = true;
              setState(() {});
            } else if (state is UploadMomentFileFailedState) {
            } else if (state is UploadMomentFileErrorState) {}
          }),
        ));
  }

  buildView() {
    return Form(
      key: _formKey,
      onChanged: () =>
          setState(() => enableBtn = _formKey.currentState!.validate()),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            MaxField(
              hint: 'Masukan judul event',
              label: 'Caption',
              isDescription: true,
              limit: 300,
              controller: captionController,
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
              maxlines: 3,
            ),
            if (widget.isEdit == false) sizeH(16),
            if (widget.isEdit == false)
              Row(
                children: [
                  SizedBox(
                    height: 300,
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Stack(
                          children: [
                            netWorkImage(
                              '',
                              borderRadius: BorderRadius.circular(10),
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            if (momentVideoStatus.isUploaded == false)
                              Center(
                                child: CircularProgressIndicator(
                                  value: momentVideoStatus.uploadProgress !=
                                          null
                                      ? momentVideoStatus.uploadProgress! / 100
                                      : null,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            sizeH(16),
            ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Aktifkan Komentar',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Customer bisa mengomentari moment anda bila diaktifkan',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
                trailing: CupertinoSwitch(
                  activeColor: Colors.amber,
                  value: activateComment,
                  onChanged: ((value) {
                    activateComment = value;
                    setState(() {});
                  }),
                ))
          ],
        )),
        sizeH(16),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (widget.isEdit == true)
                Flexible(
                  child: MaxButton(
                    width: double.infinity,
                    text: 'Batal',
                    color: Colors.white,
                    borderColor: const Color(0xFFFFC700),
                    press: isLoading
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                  ),
                ),
              if (widget.isEdit == true) sizeW(10),
              Flexible(
                child: MaxButton(
                  width: double.infinity,
                  text: 'Simpan',
                  isLoading: isLoading,
                  press: saveButton(),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  saveButton() {
    if (widget.isEdit!) {
      return () {
        updateMoment();
      };
    } else {
      if (enableBtn && momentVideoStatus.file != null) {
        return () {
          saveMoment();
        };
      } else {
        return null;
      }
    }
  }

  updateMoment() {
    Map<String, dynamic> body = {};
    body['caption'] = captionController.text;
    body['allow_comment'] = activateComment ? 'true' : 'false';

    momentBloc!.add(UpdateMomentsEvent(
        momentId: widget.momentFile!.id,
        body: body,
        accessToken: widget.accessToken,
        url: widget.url,
        apiKey: widget.apiKey));
  }

  saveMoment() {
    Map<String, dynamic> body = {};
    body['caption'] = captionController.text;
    body['allow_comment'] = activateComment ? 'true' : 'false';
    body['media'] = momentVideoStatus.file!.path;
    body['media_type'] = 'video';

    momentBloc!.add(CreateMomentsEvent(
        body: body,
        accessToken: widget.accessToken,
        url: widget.url,
        apiKey: widget.apiKey));
  }

  void _initEditMoment() {
    if (widget.isEdit == true) {
      captionController.text = widget.momentFile!.caption!;
      activateComment = widget.momentFile!.allowComment!;

      setState(() {});
    }
  }

  postFileMoment() async {
    Map<String, dynamic> body = {};
    Map<String, dynamic> params = {};

    body['images'] = await MultipartFile.fromFile(widget.outputVideoPath!,
        contentType: MediaType('video', 'mp4'));
    params['folder_path'] = 'video/moments/${widget.outputVideoPath}';
    params['save_to'] = 'AWS';
    params['max_size'] = 10000;
    momentBloc!.add(PostMomentFilesEvent(
        body: body,
        params: params,
        accessToken: widget.accessToken,
        url: widget.urlGateway,
        apiKey: widget.apiKey));
  }
}

class MomentVideoStatus {
  double? uploadProgress;
  bool? isUploaded;
  Files? file;
  MomentVideoStatus({this.uploadProgress, this.isUploaded = false, this.file});
}
