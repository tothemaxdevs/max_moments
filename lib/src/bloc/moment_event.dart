part of 'moment_bloc.dart';

abstract class MomentsEvent {}

final class GetMomentsListEvent extends MomentsEvent {
  final Map<String, dynamic>? params;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  GetMomentsListEvent(
      {this.params,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

final class GetMomentsDetailEvent extends MomentsEvent {
  final String? id;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  GetMomentsDetailEvent(this.id,
      {required this.accessToken, required this.apiKey, required this.url});
}

final class GetAllCommentEvent extends MomentsEvent {
  final String? id;
  final Map<String, dynamic>? params;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  GetAllCommentEvent(
      {this.id,
      this.params,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

final class GetAllReplyEvent extends MomentsEvent {
  final String? id;
  final Map<String, dynamic>? params;
  final int? indexComment;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  GetAllReplyEvent(
      {this.id,
      this.params,
      this.indexComment,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

final class GetMomentCommentEvent extends MomentsEvent {
  final String? id;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  GetMomentCommentEvent(this.id,
      {required this.accessToken, required this.apiKey, required this.url});
}

final class PostCommentEvent extends MomentsEvent {
  final String? id;
  final Map<String, dynamic>? body;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  PostCommentEvent(
      {this.body,
      this.id,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

final class PostReplyEvent extends MomentsEvent {
  final String? id;
  final Map<String, dynamic>? body;
  int? indexComment;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  PostReplyEvent(
      {this.body,
      this.id,
      this.indexComment,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

final class PostLikeDislikeEvent extends MomentsEvent {
  final String? id;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  PostLikeDislikeEvent(
      {this.id,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

final class PostDoubleTapLikeEvent extends MomentsEvent {
  final String? id;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  PostDoubleTapLikeEvent(
      {this.id,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

final class GetCommentDetailEvent extends MomentsEvent {
  final String? id;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  GetCommentDetailEvent(this.id,
      {required this.accessToken, required this.apiKey, required this.url});
}

final class GetReplyDetailEvent extends MomentsEvent {
  final String? id;
  int? indexComment;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  GetReplyDetailEvent(this.id, this.indexComment,
      {required this.accessToken, required this.apiKey, required this.url});
}

class CreateMomentsEvent extends MomentsEvent {
  Map<String, dynamic> body;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  CreateMomentsEvent(
      {required this.body,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

class UpdateMomentsEvent extends MomentsEvent {
  final String? momentId;
  final Map? body;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  UpdateMomentsEvent(
      {this.momentId,
      this.body,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

class DeleteMomentsEvent extends MomentsEvent {
  final String? momentId;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  DeleteMomentsEvent(
      {this.momentId,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

class PostMomentFilesEvent extends MomentsEvent {
  final Map<String, dynamic> params;
  final Map<String, dynamic> body;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  PostMomentFilesEvent(
      {required this.body,
      required this.params,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}

class PostMomentThumbnailEvent extends MomentsEvent {
  final Map<String, dynamic> params;
  final Map<String, dynamic> body;
  final String? url;
  final String? accessToken;
  final String? apiKey;
  PostMomentThumbnailEvent(
      {required this.body,
      required this.params,
      required this.accessToken,
      required this.apiKey,
      required this.url});
}
