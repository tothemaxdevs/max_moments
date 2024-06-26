part of 'moment_bloc.dart';

abstract class MomentsState {}

class MomentsInitialState extends MomentsState {}

class GetMomentsListLoadingState extends MomentsState {}

class GetMomentsListLoadedState extends MomentsState {
  final MomentListResult? data;
  GetMomentsListLoadedState(this.data);
}

class GetMomentsListErrorState extends MomentsState {
  final String? message;
  GetMomentsListErrorState(this.message);
}

class GetMomentsListFailedState extends MomentsState {
  final String? message;
  GetMomentsListFailedState(this.message);
}

class GetMomentsListEmptyState extends MomentsState {
  final String? message;
  GetMomentsListEmptyState(this.message);
}

class GetAllCommentLoadingState extends MomentsState {}

class GetAllCommentLoadedState extends MomentsState {
  final AllCommentListResult? data;
  GetAllCommentLoadedState(this.data);
}

class GetAllCommentErrorState extends MomentsState {
  final String? message;
  GetAllCommentErrorState(this.message);
}

class GetAllCommentFailedState extends MomentsState {
  final String? message;
  GetAllCommentFailedState(this.message);
}

class GetAllCommentEmptyState extends MomentsState {
  final String? message;
  GetAllCommentEmptyState(this.message);
}

class GetMomentDetailLoadingState extends MomentsState {}

class GetMomentDetailLoadedState extends MomentsState {
  final MomentsDetailResult? data;
  GetMomentDetailLoadedState(this.data);
}

class GetMomentDetailErrorState extends MomentsState {
  final String? message;
  GetMomentDetailErrorState(this.message);
}

class GetMomentDetailFailedState extends MomentsState {
  final String? message;
  GetMomentDetailFailedState(this.message);
}

class GetAllReplyLoadingState extends MomentsState {}

class GetAllReplyLoadedState extends MomentsState {
  final AllReplyListResult? data;
  final int? indexComment;
  GetAllReplyLoadedState({this.data, this.indexComment});
}

class GetAllReplyFailedState extends MomentsState {
  final String? message;
  GetAllReplyFailedState(this.message);
}

class GetAllReplyErrorState extends MomentsState {
  final String? message;
  GetAllReplyErrorState(this.message);
}

class GetAllReplyEmptyState extends MomentsState {
  final String? message;
  GetAllReplyEmptyState(this.message);
}

class GetMomentReplyFailedState extends MomentsState {
  final String? message;
  GetMomentReplyFailedState(this.message);
}

class PostLikeDislikeLoadingState extends MomentsState {}

class PostLikeDislikeLoadedState extends MomentsState {
  final Response? data;
  String? id;
  PostLikeDislikeLoadedState({this.data, this.id});
}

class PostLikeDislikeErrorState extends MomentsState {
  final String? message;
  PostLikeDislikeErrorState(this.message);
}

class PostLikeDislikeFailedState extends MomentsState {
  final String? message;
  PostLikeDislikeFailedState(this.message);
}

class PostDoubleTapLikeLoadingState extends MomentsState {}

class PostDoubleTapLikeLoadedState extends MomentsState {
  final Response? data;
  final String? id;
  PostDoubleTapLikeLoadedState({this.data, this.id});
}

class PostDoubleTapLikeErrorState extends MomentsState {
  final String? message;
  PostDoubleTapLikeErrorState(this.message);
}

class PostDoubleTapLikeFailedState extends MomentsState {
  final String? message;
  PostDoubleTapLikeFailedState(this.message);
}

class PostCommentLoadingState extends MomentsState {}

class PostCommentLoadedState extends MomentsState {
  final PostCommentResult? data;
  PostCommentLoadedState(this.data);
}

class PostCommentErrorState extends MomentsState {
  final String? message;
  PostCommentErrorState(this.message);
}

class PostCommentFailedState extends MomentsState {
  final String? message;
  PostCommentFailedState(this.message);
}

class PostReplyLoadingState extends MomentsState {}

class PostReplyLoadedState extends MomentsState {
  final PostReplyResult? data;
  int? indexComment;
  PostReplyLoadedState({this.data, this.indexComment});
}

class PostReplyErrorState extends MomentsState {
  final String? message;
  PostReplyErrorState(this.message);
}

class PostReplyFailedState extends MomentsState {
  final String? message;
  PostReplyFailedState(this.message);
}

class GetCommentDetailLoadingState extends MomentsState {}

class GetCommentDetailLoadedState extends MomentsState {
  final CommentDetailResult? data;
  GetCommentDetailLoadedState(this.data);
}

class GetCommentDetailErrorState extends MomentsState {
  final String? message;
  GetCommentDetailErrorState(this.message);
}

class GetCommentDetailFailedState extends MomentsState {
  final String? message;
  GetCommentDetailFailedState(this.message);
}

class GetReplyDetailLoadingState extends MomentsState {}

class GetReplyDetailLoadedState extends MomentsState {
  final ReplyDetailResult? data;
  int? indexComment;
  GetReplyDetailLoadedState({this.data, this.indexComment});
}

class GetReplyDetailErrorState extends MomentsState {
  final String? message;
  GetReplyDetailErrorState(this.message);
}

class GetReplyDetailFailedState extends MomentsState {
  final String? message;
  GetReplyDetailFailedState(this.message);
}

class CreateMomentLoadingState extends MomentsState {
  CreateMomentLoadingState();
}

class CreateMomentLoadedState extends MomentsState {
  CreateMomentLoadedState();
}

class CreateMomentFailedState extends MomentsState {
  final String message;
  CreateMomentFailedState(this.message);
}

class CreateMomentErrorState extends MomentsState {
  final String message;
  CreateMomentErrorState(this.message);
}

class UpdateMomentLoadingState extends MomentsState {
  UpdateMomentLoadingState();
}

class UpdateMomentLoadedState extends MomentsState {
  UpdateMomentLoadedState();
}

class UpdateMomentFailedState extends MomentsState {
  final String message;
  UpdateMomentFailedState(this.message);
}

class UpdateMomentErrorState extends MomentsState {
  final String message;
  UpdateMomentErrorState(this.message);
}

class DeleteMomentLoadingState extends MomentsState {
  DeleteMomentLoadingState();
}

class DeleteMomentLoadedState extends MomentsState {
  DeleteMomentLoadedState();
}

class DeleteMomentFailedState extends MomentsState {
  final String message;
  DeleteMomentFailedState(this.message);
}

class DeleteMomentErrorState extends MomentsState {
  final String message;
  DeleteMomentErrorState(this.message);
}

class UploadMomentFileLoadingState extends MomentsState {
  UploadMomentFileLoadingState();
}

class UploadMomentFileProgressState extends MomentsState {
  final double progress;
  UploadMomentFileProgressState(this.progress);
}

class UploadMomentFileLoadedState extends MomentsState {
  Files? data;
  UploadMomentFileLoadedState(this.data);
}

class UploadMomentFileFailedState extends MomentsState {
  final String message;
  UploadMomentFileFailedState(this.message);
}

class UploadMomentFileErrorState extends MomentsState {
  final String message;
  UploadMomentFileErrorState(this.message);
}

class UploadMomentThumbnailLoadingState extends MomentsState {}

class UploadMomentThumbnailProgressState extends MomentsState {
  final double progress;
  UploadMomentThumbnailProgressState(this.progress);
}

class UploadMomentThumbnailLoadedState extends MomentsState {
  Files? data;
  UploadMomentThumbnailLoadedState(this.data);
}

class UploadMomentThumbnailFailedState extends MomentsState {
  final String message;
  UploadMomentThumbnailFailedState(this.message);
}

class UploadMomentThumbnailErrorState extends MomentsState {
  final String message;
  UploadMomentThumbnailErrorState(this.message);
}
