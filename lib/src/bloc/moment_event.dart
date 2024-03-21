part of 'moment_bloc.dart';

abstract class MomentsEvent {}

final class GetMomentsListEvent extends MomentsEvent {
  final Map<String, dynamic>? params;
  GetMomentsListEvent({this.params});
}

final class GetMomentsDetailEvent extends MomentsEvent {
  final String? id;
  GetMomentsDetailEvent(this.id);
}

final class GetAllCommentEvent extends MomentsEvent {
  final String? id;
  final Map<String, dynamic>? params;
  GetAllCommentEvent({this.id, this.params});
}

final class GetAllReplyEvent extends MomentsEvent {
  final String? id;
  final Map<String, dynamic>? params;
  final int? indexComment;
  GetAllReplyEvent({this.id, this.params, this.indexComment});
}

final class GetMomentCommentEvent extends MomentsEvent {
  final String? id;
  GetMomentCommentEvent(this.id);
}

final class PostCommentEvent extends MomentsEvent {
  final String? id;
  final Map<String, dynamic>? body;
  PostCommentEvent({this.body, this.id});
}

final class PostReplyEvent extends MomentsEvent {
  final String? id;
  final Map<String, dynamic>? body;
  int? indexComment;
  PostReplyEvent({this.body, this.id, this.indexComment});
}

final class PostLikeDislikeEvent extends MomentsEvent {
  final String? id;
  PostLikeDislikeEvent({this.id});
}

final class PostDoubleTapLikeEvent extends MomentsEvent {
  final String? id;
  PostDoubleTapLikeEvent({this.id});
}

final class GetCommentDetailEvent extends MomentsEvent {
  final String? id;
  GetCommentDetailEvent(this.id);
}

final class GetReplyDetailEvent extends MomentsEvent {
  final String? id;
  int? indexComment;
  GetReplyDetailEvent(this.id, this.indexComment);
}
