import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_moments/max_moments.dart';
import 'package:max_moments/src/bloc/moment_bloc.dart';
import 'package:max_moments/src/components/comment_widget.dart';
import 'package:max_moments/src/components/more_option_widget.dart';
import 'package:max_moments/src/config/whitecodel_reels.dart';
import 'package:max_moments/src/max_moments_manager.dart';
import 'package:max_moments/src/models/moment_list_result/moment.dart';
import 'package:max_moments/utils/view/page_view.dart';
import 'package:max_moments/utils/view/view_utils.dart';
import 'package:video_player/video_player.dart';
import 'components/moments_button.dart';

class MaxMoments extends StatefulWidget {
  final String url;
  final String urlGateway;
  final String urlCustomer;
  final String apiKey;
  final String accessToken;
  final Function()? onEdited;
  final Function(String?)? onTapDelete;
  final Function(String?)? onMomentChanged;
  final bool showMoreButton;
  final bool showBookmark;
  final Map<String, dynamic>? additionalParams;
  final Widget? additionalButton;

  const MaxMoments({
    Key? key,
    required this.url,
    required this.urlGateway,
    required this.urlCustomer,
    required this.apiKey,
    required this.accessToken,
    this.onEdited,
    this.onTapDelete,
    this.onMomentChanged,
    this.showMoreButton = true,
    this.showBookmark = false,
    this.additionalParams,
    this.additionalButton,
  }) : super(key: key);

  @override
  _MaxMomentsState createState() => _MaxMomentsState();
}

class _MaxMomentsState extends State<MaxMoments> {
  int _currentPage = 0;
  bool isMute = false;
  bool readMore = false;
  bool isFirstLoading = true;
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

  void bookmark(int index, {String? id}) {
    Map<String, dynamic> payload = {};
    payload['target_id'] = id;
    payload['target_type'] = 'RestaurantMoment';

    _bloc.add(PostTapBookmarkEvent(
        id: id,
        url: widget.urlCustomer,
        accessToken: widget.accessToken,
        apiKey: widget.apiKey,
        body: payload));
  }

  void muteUnmuteAll(VideoPlayerController videoPlayerController) {
    isMute = !isMute;
    if (isMute == true) {
      videoPlayerController.setVolume(0.0);
    } else {
      videoPlayerController.setVolume(10.0);
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
        // GestureDetector(
        //   onTap: () {
        //     // muteUnmuteAll();
        //   },
        //   child: Container(
        //       height: 30,
        //       width: 30,
        //       color: Colors.transparent,
        //       child: Icon(
        //         isMute == false
        //             ? Icons.volume_up_outlined
        //             : Icons.volume_off_outlined,
        //         color: Colors.white,
        //       )),
        // )
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
                mode = PageMode.loaded;
                isFirstLoading = false;
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
              momentsList![index].caption = state.data!.moment!.caption;
              momentsList![index].isBookmark = state.data!.moment!.isBookmark;
              momentsList![index].allowComment =
                  state.data!.moment!.allowComment;
              momentsList![index].commentCount =
                  state.data!.moment!.commentCount;
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
            } else if (state is PostBookmarkLoadingState) {
            } else if (state is PostBookmarkLoadedState) {
              _getHitView(id: state.id);
            } else if (state is PostBookmarkFailedState) {
              showToastError(context, state.message!);
            } else if (state is PostBookmarkErrorState) {
              showToastError(context, state.message!);
            }
          },
        ),
      ),
    );
  }

  Widget _buildView() {
    return isFirstLoading == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : WhiteCodelReels(
            key: UniqueKey(),
            context: context,
            loader: const Center(
              child: CircularProgressIndicator(),
            ),
            isCaching: true,
            videoList: List.generate(
                momentsList!.length, (index) => momentsList![index].media!),
            builder:
                (context, index, child, videoPlayerController, pageController) {
              bool isReadMore = false;
              StreamController<double> videoProgressController =
                  StreamController<double>();

              videoPlayerController.addListener(() {
                double videoProgress =
                    videoPlayerController.value.position.inMilliseconds /
                        videoPlayerController.value.duration.inMilliseconds;
                videoProgressController.add(videoProgress);
              });

              return Stack(children: [
                child,
                Positioned(
                    bottom: 10,
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
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
                                                          momentsList![index]
                                                                  .avatar ??
                                                              ''),
                                                      fit: BoxFit.cover)),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              momentsList![index].uploader ??
                                                  '',
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
                                                momentsList![index].caption ??
                                                    '',
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
                                ),
                                sizeW(10),
                                Column(
                                  children: [
                                    widget.additionalButton ?? const SizedBox(),
                                    MomentsButton(
                                      icon: ImageConstants.view,
                                      count: abbreviateNumber(
                                          momentsList![index].views ?? 0),
                                      onTap: null,
                                    ),
                                    MomentsButton(
                                      icon: momentsList![index].isLiked == false
                                          ? ImageConstants.unlike
                                          : ImageConstants.like,
                                      count:
                                          '${momentsList![index].likeCount ?? 0}',
                                      onTap: () {
                                        likeUnlike(index,
                                            id: momentsList![index].id);
                                      },
                                    ),
                                    if (momentsList![index].allowComment ==
                                        true)
                                      MomentsButton(
                                        icon: ImageConstants.comment,
                                        count:
                                            '${momentsList![index].commentCount ?? 0}',
                                        onTap: () {
                                          _showComment(
                                              momentsList![index].id ?? '');
                                        },
                                      ),
                                    if (widget.showBookmark == true)
                                      MomentsButton(
                                        icon: momentsList![index].isBookmark ==
                                                false
                                            ? ImageConstants.bookmark
                                            : ImageConstants.bookmarked,
                                        onTap: () {
                                          bookmark(index,
                                              id: momentsList![index].id);
                                        },
                                      ),
                                    if (widget.showMoreButton == true)
                                      MomentsButton(
                                        icon: ImageConstants.more,
                                        withText: false,
                                        onTap: () {
                                          _showMoreOption(momentsList![index]);
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
                ),
                StreamBuilder(
                  stream: videoProgressController.stream,
                  builder: (context, snapshot) {
                    return Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: SliderComponentShape.noThumb,
                          overlayShape: SliderComponentShape.noOverlay,
                          trackHeight: 2,
                        ),
                        child: Slider(
                          value: (snapshot.data ?? 0).clamp(0.0, 1.0),
                          min: 0.0,
                          max: 1.0,
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey,

                          onChanged: (value) {
                            final position = videoPlayerController
                                    .value.duration.inMilliseconds *
                                value;
                            videoPlayerController.seekTo(
                                Duration(milliseconds: position.toInt()));
                          },
                          // onChangeEnd: (value) {
                          //   videoPlayerController.play();
                          // },
                        ),
                      ),
                    );
                  },
                ),
              ]);
            });
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
