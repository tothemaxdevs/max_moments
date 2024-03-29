import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_moments/max_moments.dart';
import 'package:max_moments/src/bloc/moment_bloc.dart';
import 'package:max_moments/src/components/comment_widget.dart';
import 'package:max_moments/src/components/more_option_widget.dart';
import 'package:max_moments/src/max_moments_manager.dart';
import 'package:max_moments/src/models/moment_list_result/moment.dart';
import 'package:max_moments/utils/view/page_view.dart';
import 'package:max_moments/utils/view/view_utils.dart';
import 'components/moments_button.dart';

class MaxMoments extends StatefulWidget {
  final String url;
  final String urlGateway;
  final String apiKey;
  final String accessToken;
  final Function()? onEdited;
  final Function(String?)? onTapDelete;
  final Function(String?)? onMomentChanged;
  final bool showMoreButton;
  final Map<String, dynamic>? additionalParams;
  final Widget? additionalButton;

  const MaxMoments({
    Key? key,
    required this.url,
    required this.urlGateway,
    required this.apiKey,
    required this.accessToken,
    this.onEdited,
    this.onTapDelete,
    this.onMomentChanged,
    this.showMoreButton = true,
    this.additionalParams,
    this.additionalButton,
  }) : super(key: key);

  @override
  _MaxMomentsState createState() => _MaxMomentsState();
}

class _MaxMomentsState extends State<MaxMoments> {
  late List<CachedVideoPlayerController> _controllers;
  int _currentPage = 0;
  bool isMute = false;
  bool readMore = false;
  double? height = 20.0;
  double? likeHeight = 0.0;
  double? likeWidth = 0.0;
  final MomentsBloc _bloc = MomentsBloc();
  PageMode mode = PageMode.loading;

  @override
  void initState() {
    _getMomentList();
    super.initState();
  }

  @override
  void dispose() {
    pageController?.removeListener(_onPageChanged);
    pageController?.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers() async {
    await Future.wait(
        _controllers.map((controller) => controller.initialize()));
    setState(() {});
  }

  void _onPageChanged() {
    final newPage = pageController?.page?.toInt() ?? 0;
    if (newPage != _currentPage) {
      _currentPage = newPage;

      if (_currentPage < momentsList!.length - 1) {
        _controllers[_currentPage + 1].initialize().then((_) {
          setState(() {});
        });
        _controllers[_currentPage - 1].initialize().then((_) {
          setState(() {});
        });
      }
    }

    _getHitView();
  }

  void onDoubleTapLike(int index, String? id) {
    likeHeight = 55.0;
    likeWidth = 55.0;
    Future.delayed(const Duration(milliseconds: 110)).then((value) {
      likeHeight = 45.0;
      likeWidth = 45.0;
      setState(() {});
    });
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      likeHeight = 0.0;
      likeWidth = 0.0;
      setState(() {});
    });
    _bloc.add(PostDoubleTapLikeEvent(
        id: id,
        url: widget.url,
        accessToken: widget.accessToken,
        apiKey: widget.apiKey));
    setState(() {});
  }

  void readMoreFunc() {
    readMore = !readMore;
    if (readMore == true) {
      height = null;
    } else {
      height = 20.0;
    }
    setState(() {});
  }

  void likeUnlike(int index, {String? id}) {
    _bloc.add(PostLikeDislikeEvent(
        id: id,
        url: widget.url,
        accessToken: widget.accessToken,
        apiKey: widget.apiKey));
  }

  void muteUnmuteAll() {
    isMute = !isMute;
    if (isMute == true) {
      for (var element in _controllers) {
        element.setVolume(0.0);
      }
    } else {
      for (var element in _controllers) {
        element.setVolume(10.0);
      }
    }
    setState(() {});
  }

  List<Moment>? momentsList = [];

  PageController? pageController = PageController();
  bool? loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, actions: [
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
      ]),
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocConsumer<MomentsBloc, MomentsState>(
          builder: (context, state) {
            return MyPageView(
              view: _buildView(),
              mode: mode,
            );
          },
          listener: (context, state) {
            if (state is GetMomentsListLoadingState) {
              mode = PageMode.loading;
            } else if (state is GetMomentsListLoadedState) {
              setState(() {
                momentsList = state.data!.moments;
                _controllers = List.generate(
                  momentsList!.length,
                  (index) => CachedVideoPlayerController.networkUrl(
                      Uri.parse(momentsList![index].media ?? '')),
                );
                _initializeControllers();
                pageController?.addListener(_onPageChanged);
                mode = PageMode.loaded;
              });
            } else if (state is GetMomentsListEmptyState) {
              mode = PageMode.empty;
            } else if (state is GetMomentsListFailedState) {
              mode = PageMode.failed;
            } else if (state is GetMomentsListErrorState) {
              mode = PageMode.error;
            } else if (state is GetMomentDetailLoadingState) {
            } else if (state is GetMomentDetailLoadedState) {
              setState(() {
                int index = momentsList!.indexWhere(
                    (element) => element.id == state.data!.moment!.id);
                log(index.toString());
                momentsList![index].isLiked = state.data!.moment!.isLiked;
                momentsList![index].likeCount = state.data!.moment!.likeCount;
                momentsList![index].caption = state.data!.moment!.caption;
                momentsList![index].allowComment =
                    state.data!.moment!.allowComment;
                momentsList![index].commentCount =
                    state.data!.moment!.commentCount;
              });
            } else if (state is GetMomentDetailFailedState) {
            } else if (state is GetMomentDetailErrorState) {
            } else if (state is PostLikeDislikeLoadingState) {
            } else if (state is PostLikeDislikeLoadedState) {
              _getHitView(id: state.id);
            } else if (state is PostLikeDislikeFailedState) {
              showToastError(context, state.message!);
            } else if (state is PostLikeDislikeErrorState) {
              showToastError(context, state.message!);
            } else if (state is PostDoubleTapLikeLoadingState) {
            } else if (state is PostDoubleTapLikeLoadedState) {
              _getHitView(id: state.id);
            } else if (state is PostDoubleTapLikeFailedState) {
              showToastError(context, state.message!);
            } else if (state is PostDoubleTapLikeErrorState) {
              showToastError(context, state.message!);
            } else if (state is DeleteMomentLoadingState) {
              _showLoading();
            } else if (state is DeleteMomentLoadedState) {
              momentsList!.removeAt(_currentPage);
              Navigator.pop(context);
              setState(() {});
            } else if (state is DeleteMomentFailedState) {
              Navigator.pop(context);
              showToastError(context, state.message);
            } else if (state is DeleteMomentErrorState) {
              Navigator.pop(context);
              showToastError(context, state.message);
            }
          },
        ),
      ),
    );
  }

  Widget _buildView() {
    return RefreshIndicator(
      onRefresh: () async {
        _getMomentList();
        _currentPage = 0;
        setState(() {});
      },
      child: Stack(
        children: [
          PageView.builder(
            itemCount: momentsList!.length,
            scrollDirection: Axis.vertical,
            onPageChanged: (value) {
              _currentPage = value;
              widget.onMomentChanged!(momentsList![_currentPage].id ?? '');

              _getHitView();
              setState(() {});
            },
            itemBuilder: (BuildContext context, int index) {
              var moment = momentsList![index];
              return GestureDetector(
                onDoubleTap: () {
                  onDoubleTapLike(index, moment.id);
                },
                child: Stack(children: [
                  ReelsWidget(
                    playerController: _controllers[index],
                  ),
                  Positioned(
                      bottom: 10,
                      child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () {
                                        readMoreFunc();
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.amber,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            moment.restaurantPhoto ??
                                                                ''),
                                                        fit: BoxFit.cover)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                moment.uploader ?? '',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.79,
                                                height: height,
                                                child: Text(
                                                  moment.caption ?? '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      overflow:
                                                          readMore == false
                                                              ? TextOverflow
                                                                  .ellipsis
                                                              : null),
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  sizeW(10),
                                  Column(
                                    children: [
                                      widget.additionalButton ??
                                          const SizedBox(),
                                      MomentsButton(
                                        icon: moment.isLiked == false
                                            ? ImageConstants.unlike
                                            : ImageConstants.like,
                                        count: moment.likeCount,
                                        onTap: () {
                                          likeUnlike(index, id: moment.id);
                                        },
                                      ),
                                      if (moment.allowComment == true)
                                        MomentsButton(
                                          icon: ImageConstants.comment,
                                          count: moment.commentCount,
                                          onTap: () {
                                            _showComment(moment.id ?? '');
                                          },
                                        ),
                                      if (widget.showMoreButton == true)
                                        MomentsButton(
                                          icon: ImageConstants.more,
                                          count: moment.commentCount,
                                          withText: false,
                                          onTap: () {
                                            _showMoreOption(moment);
                                          },
                                        ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ))),
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                        height: likeHeight,
                        width: likeWidth,
                        duration: const Duration(milliseconds: 100),
                        child: SvgPicture.asset(
                          ImageConstants.like,
                          package: 'max_moments',
                        )),
                  )
                ]),
              );
            },
          ),
        ],
      ),
    );
  }

  _showLoading() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const SpinKitFoldingCube(
                color: Colors.amber,
                size: 30.0,
              ),
            ));
      },
    );
  }

  _showComment(String id) {
    return bottomSheet(
      context,
      (BuildContext context, ScrollController scrollController) {
        return StatefulBuilder(builder: (BuildContext context, mySetState) {
          return Expanded(
              child: CommentWidget(
            momentId: id,
            controller: scrollController,
            accessToken: widget.accessToken,
            url: widget.url,
            apiKey: widget.apiKey,
          ));
        });
      },
      title: 'Comment',
    );
  }

  _showMoreOption(Moment moment) {
    return bottomSheet(
      context,
      (BuildContext context, ScrollController scrollController) {
        return StatefulBuilder(builder: (BuildContext context, mySetState) {
          return Expanded(
              child: MoreOptionWidget(
            onTapDelete: () {
              Navigator.pop(context);
              _bloc.add(DeleteMomentsEvent(
                  accessToken: widget.accessToken,
                  apiKey: widget.apiKey,
                  url: widget.url,
                  momentId: moment.id));
            },
            onTapEdit: () async {
              bool? isEdited = await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MaxMomentsManager(
                            accessToken: widget.accessToken,
                            apiKey: widget.apiKey,
                            url: widget.url,
                            urlGateway: widget.urlGateway,
                            isEdit: true,
                            momentFile: moment,
                          )));

              if (isEdited == true) {
                _getHitView(id: moment.id);
                widget.onEdited!();
              }
            },
          ));
        });
      },
      title: 'More',
      minChildSize: 0.25,
    );
  }

  void _getHitView({String? id}) {
    _bloc.add(GetMomentsDetailEvent(id ?? momentsList![_currentPage].id,
        url: widget.url,
        accessToken: widget.accessToken,
        apiKey: widget.apiKey));
  }

  void _getMomentList() {
    _bloc.add(GetMomentsListEvent(
      params: widget.additionalParams,
      url: widget.url,
      accessToken: widget.accessToken,
      apiKey: widget.apiKey,
    ));
  }
}
