import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_moments/max_moments.dart';
import 'package:max_moments/src/bloc/moment_bloc.dart';
import 'package:max_moments/src/components/comment_widget.dart';
import 'package:max_moments/src/components/more_option_widget.dart';
import 'package:max_moments/src/models/moment_list_result/moment.dart';
import 'package:max_moments/utils/view/page_view.dart';
import 'package:max_moments/utils/view/view_utils.dart';
import 'components/moments_button.dart';

class MaxMoments extends StatefulWidget {
  MaxMoments(
      {Key? key,
      required this.url,
      required this.apiKey,
      required this.accessToken,
      this.onTapDelete,
      this.onTapEdit,
      this.showMoreButton = true,
      this.additionalParams,
      this.additionalButton})
      : super(key: key);

  String url, apiKey, accessToken;
  Function(Moment)? onTapEdit, onTapDelete;
  bool? showMoreButton;
  Map<String, dynamic>? additionalParams;
  Widget? additionalButton;

  @override
  State<MaxMoments> createState() => _MaxMomentsState();
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
    _bloc.add(GetMomentsListEvent(
      params: widget.additionalParams,
      url: widget.url,
      accessToken: widget.accessToken,
      apiKey: widget.apiKey,
    ));
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
      // Preload next video

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
      _controllers.forEach((element) {
        element.setVolume(0.0);
      });
    } else {
      _controllers.forEach((element) {
        element.setVolume(10.0);
      });
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
              int index = momentsList!.indexWhere(
                  (element) => element.id == state.data!.moment!.id);
              log(index.toString());
              momentsList![index].isLiked = state.data!.moment!.isLiked;
              momentsList![index].likeCount = state.data!.moment!.likeCount;
              momentsList![index].commentCount =
                  state.data!.moment!.commentCount;
              setState(() {});
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
            }
          },
        ),
      ),
    );
  }

  Stack _buildView() {
    return Stack(
      children: [
        PageView.builder(
          itemCount: momentsList!.length,
          scrollDirection: Axis.vertical,
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
                    // right: 5,
                    child: Container(
                        // height: 50,
                        width: MediaQuery.sizeOf(context).width,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
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
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.amber,
                                                image: DecorationImage(
                                                    image: NetworkImage(moment
                                                            .restaurantPhoto ??
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
                                                fontWeight: FontWeight.w400),
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
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.79,
                                            height: height,
                                            child: Text(
                                              moment.caption ?? '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  overflow: readMore == false
                                                      ? TextOverflow.ellipsis
                                                      : null),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    widget.additionalButton!,
                                    MomentsButton(
                                      icon: moment.isLiked == false
                                          ? ImageConstants.unlike
                                          : ImageConstants.like,
                                      count: moment.likeCount,
                                      onTap: () {
                                        likeUnlike(index, id: moment.id);
                                      },
                                    ),
                                    MomentsButton(
                                      icon: ImageConstants.comment,
                                      count: moment.commentCount,
                                      onTap: () {
                                        _showComment(moment);
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

                //animated Like Icon
                Align(
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                      height: likeHeight,
                      width: likeWidth,
                      duration: const Duration(milliseconds: 100),
                      child: SvgPicture.asset(
                        ImageConstants.like,
                        package: 'max_moments',
                      )

                      // curve: Curves.bounceInOut,
                      ),
                )
              ]),
            );
            // return VideoPlayerScreen(videoUrl: videoUrls[index]);
          },
        ),
      ],
    );
  }

  _showComment(Moment moment) {
    return bottomSheet(
      context,
      (BuildContext context, ScrollController scrollController) {
        return StatefulBuilder(builder: (BuildContext context, mySetState) {
          return Expanded(
              child: CommentWidget(
            moment: moment,
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
            moment: moment,
            onTapDelete: widget.onTapDelete,
            onTapEdit: widget.onTapEdit,
          ));
        });
      },
      title: 'More',
      maxChildSize: 0.25, // Full screen on scroll
      minChildSize: 0.25,
    );
  }

  void _getHitView({String? id}) {
    _bloc.add(GetMomentsDetailEvent(id ?? momentsList![_currentPage].id,
        url: widget.url,
        accessToken: widget.accessToken,
        apiKey: widget.apiKey));
  }
}
