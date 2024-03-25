import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:max_moments/src/bloc/moment_bloc.dart';
import 'package:max_moments/src/components/comment_box_widget.dart';
import 'package:max_moments/src/components/comment_user_widget.dart';
import 'package:max_moments/src/models/all_reply_list_result/pagination.dart';
import 'package:max_moments/src/models/all_reply_list_result/replies.dart';
import 'package:max_moments/src/models/moment_list_result/moment.dart';
import 'package:max_moments/utils/view/page_view.dart';
import 'package:max_moments/src/models/all_comment_list_result/item.dart'
    as cmnt;
import 'package:max_moments/utils/view/view_utils.dart';

class CommentWidget extends StatefulWidget {
  ScrollController? controller;
  Moment moment;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  CommentWidget(
      {super.key,
      this.controller,
      required this.moment,
      required this.accessToken,
      required this.apiKey,
      required this.url});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final MomentsBloc _bloc = MomentsBloc();
  Map<String, dynamic> prmComment = {};
  PageMode mode = PageMode.loading;

  List<cmnt.Item> commentList = [];

  CommentBoxData? commentBoxData;
  @override
  void initState() {
    prmComment['limit'] = 20;
    prmComment['page'] = 1;
    commentBoxData = CommentBoxData(isReply: false, targetId: widget.moment.id);
    _bloc.add(GetAllCommentEvent(
        id: widget.moment.id,
        params: prmComment,
        url: widget.url,
        accessToken: widget.accessToken,
        apiKey: widget.apiKey));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocConsumer<MomentsBloc, MomentsState>(
          builder: (context, state) {
            return _viewState();
          },
          listener: (context, state) {
            if (state is GetAllCommentLoadingState) {
              mode = PageMode.loading;
            } else if (state is GetAllCommentLoadedState) {
              commentList.addAll(state.data!.comments!.items!);
              mode = PageMode.loaded;
            } else if (state is GetAllCommentEmptyState) {
              mode = PageMode.empty;
            } else if (state is GetAllCommentFailedState) {
              mode = PageMode.failed;
            } else if (state is GetAllCommentErrorState) {
              mode = PageMode.error;
            } else if (state is GetAllReplyLoadingState) {
            } else if (state is GetAllReplyLoadedState) {
              final index = state.indexComment!;
              final comment = commentList[index];
              final dataReplies = state.data?.replies;

              if (dataReplies != null) {
                comment.replies =
                    comment.replies ?? Replies(); // Initialize replies if null
                comment.replies!.items ??= []; // Initialize items if null
                comment.replies!.items!.addAll(dataReplies.items!);
                comment.replies!.pagination = dataReplies.pagination;
              } else {
                comment.replies = dataReplies;
              }
              setState(() {});
            } else if (state is GetAllReplyFailedState) {
              showToastError(context, state.message!);
            } else if (state is GetAllReplyErrorState) {
              showToastError(context, state.message!);
            } else if (state is PostCommentLoadingState) {
            } else if (state is PostCommentLoadedState) {
              _bloc.add(GetCommentDetailEvent(state.data!.comment!.id,
                  url: widget.url,
                  accessToken: widget.accessToken,
                  apiKey: widget.apiKey));
            } else if (state is PostCommentFailedState) {
              showToastError(context, state.message!);
            } else if (state is PostCommentErrorState) {
              showToastError(context, state.message!);
            } else if (state is PostReplyLoadingState) {
            } else if (state is PostReplyLoadedState) {
              _bloc.add(GetReplyDetailEvent(
                  state.data!.reply!.id, state.indexComment,
                  url: widget.url,
                  accessToken: widget.accessToken,
                  apiKey: widget.apiKey));
            } else if (state is PostReplyFailedState) {
              showToastError(context, state.message!);
            } else if (state is PostReplyErrorState) {
              showToastError(context, state.message!);
            } else if (state is GetCommentDetailLoadingState) {
            } else if (state is GetCommentDetailLoadedState) {
              commentList.insert(0, state.data!.comment);
            } else if (state is GetCommentDetailFailedState) {
              showToastError(context, state.message!);
            } else if (state is GetCommentDetailErrorState) {
              showToastError(context, state.message!);
            } else if (state is GetReplyDetailLoadingState) {
            } else if (state is GetReplyDetailLoadedState) {
              commentList[state.indexComment!].replies != null
                  ? commentList[state.indexComment!]
                      .replies!
                      .items!
                      .insert(0, state.data!.reply)
                  : commentList[state.indexComment!].replies = Replies(
                      items: [state.data!.reply],
                      pagination: Pagination(
                          totalItem: 1,
                          currentPage: 1,
                          limit: 10,
                          totalPage: 1));
            } else if (state is GetReplyDetailFailedState) {
              showToastError(context, state.message!);
            } else if (state is GetReplyDetailErrorState) {
              showToastError(context, state.message!);
            }
          },
        ),
      ),
    );
  }

  Widget _viewState() {
    return MyPageView(
      view: _buildView(),
      mode: mode,
    );
  }

  Widget _buildView() {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          controller: widget.controller,
          itemCount: commentList.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (BuildContext context, int index) {
            var comments = commentList[index];
            return UserCommentWidget(
              avatar: comments.userAvatar!,
              comment: comments.comment!,
              name: comments.name!,
              passedTime: comments.momentsPassed!,
              replyCount: comments.replyCount! -
                  (comments.replies != null
                      ? comments.replies!.pagination!.totalItem!
                      : 0),
              isMerchant: comments.isMerchant ?? false,
              onTapReply: () {
                _setComment(
                    targetId: comments.id,
                    replyTo: comments.name,
                    isReply: true,
                    index: index);
              },
              onTapViewReply: () {
                _seeReply(comments, index);
              },
              replySection: ListView.builder(
                itemCount: comments.replies != null
                    ? comments.replies!.items!.length
                    : 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int i) {
                  var replies = comments.replies!.items![i];
                  return UserCommentWidget(
                    avatar: replies.userAvatar!,
                    comment: replies.reply!,
                    name: replies.name!,
                    passedTime: replies.momentsPassed!,
                    isMerchant: replies.isMerchant ?? false,
                  );
                },
              ),
            );
          },
        )),
        CommentBox(
          isReply: commentBoxData!.isReply!,
          replyTo: commentBoxData!.replyTo,
          onTapCloseReply: () {
            _setComment(targetId: widget.moment.id);
          },
          onTapComment: (v) {
            Map<String, dynamic> body = {'comment': v};
            _bloc.add(PostCommentEvent(
                body: body,
                id: commentBoxData!.targetId,
                url: widget.url,
                accessToken: widget.accessToken,
                apiKey: widget.apiKey));
          },
          onTapReply: (v) {
            Map<String, dynamic> body = {'reply': v};
            _bloc.add(PostReplyEvent(
                body: body,
                id: commentBoxData!.targetId,
                indexComment: commentBoxData!.indexComment,
                url: widget.url,
                accessToken: widget.accessToken,
                apiKey: widget.apiKey));
            commentBoxData!.isReply = false;
            _setComment(targetId: widget.moment.id);
            setState(() {});
          },
          avatar: '',
        )
      ],
    );
  }

  _setComment(
      {bool isReply = false, String? targetId, String? replyTo, int? index}) {
    commentBoxData!.isReply = isReply;
    commentBoxData!.targetId = targetId;
    commentBoxData!.replyTo = replyTo ?? '';
    commentBoxData!.indexComment = index ?? 0;
    setState(() {});
  }

  void _seeReply(cmnt.Item comments, int index) {
    Map<String, dynamic> params = {
      'limit': 10,
      'page': comments.replies != null
          ? comments.replies!.pagination!.totalItem! + 1
          : 1
    };
    _bloc.add(GetAllReplyEvent(
        id: comments.id,
        params: params,
        indexComment: index,
        url: widget.url,
        accessToken: widget.accessToken,
        apiKey: widget.apiKey));
  }
}
