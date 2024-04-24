import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:max_moments/src/api/moment_api.dart';
import 'package:max_moments/src/models/all_comment_list_result/all_comment_list_result.dart';
import 'package:max_moments/src/models/all_reply_list_result/all_reply_list_result.dart';
import 'package:max_moments/src/models/comment_detail/comment_detail_result.dart';
import 'package:max_moments/src/models/file_upload_gateway/file_upload.dart';
import 'package:max_moments/src/models/file_upload_gateway/files.dart';
import 'package:max_moments/src/models/moment_list_result/moment_list_result.dart';
import 'package:max_moments/src/models/moments_detail_result/moments_detail_result.dart';
import 'package:max_moments/src/models/post_comment_result/post_comment_result.dart';
import 'package:max_moments/src/models/post_reply_result/post_reply_result.dart';
import 'package:max_moments/src/models/reply_detail/reply_detail_result.dart';
import 'package:max_moments/src/models/response_model/response.dart';

part 'moment_event.dart';
part 'moment_state.dart';

class MomentsBloc extends Bloc<MomentsEvent, MomentsState> {
  final MomentAPI _api;

  MomentsBloc({MomentAPI? api})
      : _api = api ?? MomentAPI(),
        super(MomentsInitialState()) {
    on<GetMomentsListEvent>(_getMomentList);
    on<GetMomentsDetailEvent>(_getMomentDetail);
    on<GetAllCommentEvent>(_getAllComment);
    on<GetAllReplyEvent>(_getMomentReply);
    on<PostReplyEvent>(_postReply);
    on<PostLikeDislikeEvent>(_postLikeDislike);
    on<PostCommentEvent>(_postComment);
    on<GetCommentDetailEvent>(_getCommentDetail);
    on<GetReplyDetailEvent>(_getReplyDetail);
    on<PostDoubleTapLikeEvent>(_postDoubleTapLike);
    on<CreateMomentsEvent>(_onAddMomentsEvent);
    on<UpdateMomentsEvent>(_onUpdateMomentsEvent);
    on<DeleteMomentsEvent>(_onDeleteMomentsEvent);
    on<PostMomentFilesEvent>(_onPostFileMomentsEvent);
    on<PostMomentThumbnailEvent>(_onPostFileThumbnailsEvent);
  }

  _getMomentList(GetMomentsListEvent event, Emitter<MomentsState> emit) async {
    try {
      emit(GetMomentsListLoadingState());
      Response response = await _api.getMomentList(
          params: event.params,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (response.statusCode == 200) {
        MomentListResult result = MomentListResult.fromJson(
            ResponseData.fromJson(response.data).data);
        if (result.moments!.isEmpty) {
          emit(GetMomentsListEmptyState(response.statusMessage));
        } else {
          emit(GetMomentsListLoadedState(result));
        }
      } else {
        emit(GetMomentsListErrorState(response.statusMessage));
      }
    } on DioException catch (error) {
      emit(GetMomentsListErrorState(error.message));
    }
  }

  _getMomentDetail(
      GetMomentsDetailEvent event, Emitter<MomentsState> emit) async {
    try {
      emit(GetMomentDetailLoadingState());
      Response response = await _api.getMomentDetail(event.id,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (response.statusCode == 200) {
        emit(GetMomentDetailLoadedState(MomentsDetailResult.fromJson(
            ResponseData.fromJson(response.data).data)));
      } else {
        emit(GetMomentDetailErrorState(response.statusMessage));
      }
    } on DioException catch (error) {
      emit(GetMomentDetailErrorState(error.message));
    }
  }

  _getCommentDetail(
      GetCommentDetailEvent event, Emitter<MomentsState> emit) async {
    try {
      emit(GetCommentDetailLoadingState());
      Response response = await _api.getCommentDetail(event.id,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (response.statusCode == 200) {
        emit(GetCommentDetailLoadedState(CommentDetailResult.fromJson(
            ResponseData.fromJson(response.data).data)));
      } else {
        emit(GetCommentDetailErrorState(response.statusMessage));
      }
    } on DioException catch (error) {
      emit(GetCommentDetailErrorState(error.message));
    }
  }

  _getReplyDetail(GetReplyDetailEvent event, Emitter<MomentsState> emit) async {
    try {
      emit(GetReplyDetailLoadingState());
      Response response = await _api.getReplyDetail(event.id,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (response.statusCode == 200) {
        emit(GetReplyDetailLoadedState(
            data: ReplyDetailResult.fromJson(
                ResponseData.fromJson(response.data).data),
            indexComment: event.indexComment));
      } else {
        emit(GetReplyDetailErrorState(response.statusMessage));
      }
    } on DioException catch (error) {
      emit(GetReplyDetailErrorState(error.message));
    }
  }

  _getAllComment(GetAllCommentEvent event, Emitter<MomentsState> emit) async {
    try {
      emit(GetAllCommentLoadingState());
      Response response = await _api.getAllComment(
          params: event.params,
          id: event.id,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (response.statusCode == 200) {
        AllCommentListResult result = AllCommentListResult.fromJson(
            ResponseData.fromJson(response.data).data);
        if (result.comments!.isEmpty) {
          emit(GetAllCommentEmptyState(response.statusMessage));
        } else {
          emit(GetAllCommentLoadedState(result));
        }
      } else {
        emit(GetAllCommentErrorState(response.statusMessage));
      }
    } on DioException catch (error) {
      emit(GetAllCommentErrorState(error.message));
    }
  }

  _getMomentReply(GetAllReplyEvent event, Emitter<MomentsState> emit) async {
    try {
      emit(GetAllReplyLoadingState());
      Response response = await _api.getReplyList(
          params: event.params,
          id: event.id,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (response.statusCode == 200) {
        AllReplyListResult result = AllReplyListResult.fromJson(
            ResponseData.fromJson(response.data).data);
        if (result.replies!.isEmpty) {
          emit(GetAllReplyEmptyState(response.statusMessage));
        } else {
          emit(GetAllReplyLoadedState(
              data: result, indexComment: event.indexComment));
        }
      } else {
        emit(GetAllReplyFailedState(response.statusMessage));
      }
    } on DioException catch (error) {
      emit(GetAllReplyErrorState(error.message));
    }
  }

  _postLikeDislike(
      PostLikeDislikeEvent event, Emitter<MomentsState> emit) async {
    try {
      emit(PostLikeDislikeLoadingState());
      Response response = await _api.postLikeDislike(event.id,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (response.statusCode == 200) {
        emit(PostLikeDislikeLoadedState(data: response, id: event.id));
      } else {
        emit(PostLikeDislikeFailedState(response.statusMessage));
      }
    } on DioException catch (error) {
      emit(PostLikeDislikeErrorState(error.message));
    }
  }

  _postDoubleTapLike(
      PostDoubleTapLikeEvent event, Emitter<MomentsState> emit) async {
    try {
      emit(PostDoubleTapLikeLoadingState());
      Response response = await _api.postDoubleTapLike(event.id,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (response.statusCode == 200) {
        emit(PostDoubleTapLikeLoadedState(data: response, id: event.id));
      } else {
        emit(PostDoubleTapLikeFailedState(response.statusMessage));
      }
    } on DioException catch (error) {
      emit(PostDoubleTapLikeErrorState(error.message));
    }
  }

  _postComment(PostCommentEvent event, Emitter<MomentsState> emit) async {
    try {
      emit(PostCommentLoadingState());
      Response response = await _api.postComment(
          body: event.body,
          id: event.id,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (response.statusCode == 200) {
        emit(PostCommentLoadedState(PostCommentResult.fromJson(
            ResponseData.fromJson(response.data).data)));
      } else {
        emit(PostCommentFailedState(response.statusMessage));
      }
    } on DioException catch (error) {
      emit(PostCommentErrorState(error.message));
    }
  }

  _postReply(PostReplyEvent event, Emitter<MomentsState> emit) async {
    try {
      emit(PostReplyLoadingState());
      Response response = await _api.postReply(
          params: event.body,
          id: event.id,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (response.statusCode == 200) {
        emit(PostReplyLoadedState(
            data: PostReplyResult.fromJson(
                ResponseData.fromJson(response.data).data),
            indexComment: event.indexComment));
      } else {
        emit(PostReplyFailedState(response.statusMessage));
      }
    } on DioException catch (error) {
      emit(PostReplyErrorState(error.message));
    }
  }

  _onAddMomentsEvent(
      CreateMomentsEvent event, Emitter<MomentsState> emit) async {
    emit(CreateMomentLoadingState());
    try {
      final data = await _api.createMoment(
          body: event.body,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);

      if (data.statusCode == 200) {
        emit(CreateMomentLoadedState());
      } else {
        emit(CreateMomentFailedState(data.statusMessage!));
      }
    } on DioException catch (error) {
      emit(CreateMomentErrorState(error.message!));
    }
  }

  _onUpdateMomentsEvent(
      UpdateMomentsEvent event, Emitter<MomentsState> emit) async {
    emit(UpdateMomentLoadingState());
    try {
      final data = await _api.postUpdateMoments(
          id: event.momentId,
          body: event.body,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);
      if (data.statusCode == 200) {
        emit(UpdateMomentLoadedState());
      } else {
        emit(UpdateMomentFailedState(data.statusMessage!));
      }
    } on DioException catch (error) {
      emit(UpdateMomentErrorState(error.message!));
    }
  }

  _onDeleteMomentsEvent(
      DeleteMomentsEvent event, Emitter<MomentsState> emit) async {
    emit(DeleteMomentLoadingState());
    try {
      final data = await _api.deleteMoment(
          id: event.momentId,
          apiKey: event.apiKey!,
          url: event.url!,
          accessToken: event.accessToken!);

      if (data.statusCode == 200) {
        emit(DeleteMomentLoadedState());
      } else {
        emit(DeleteMomentFailedState(data.statusMessage!));
      }
    } on DioException catch (error) {
      emit(DeleteMomentErrorState(error.message!));
    }
  }

  _onPostFileMomentsEvent(
      PostMomentFilesEvent event, Emitter<MomentsState> emit) async {
    emit(UploadMomentFileLoadingState());
    try {
      Response data = await _api.postMomentFiles(
        params: event.params,
        body: event.body,
        apiKey: event.apiKey!,
        url: event.url!,
        accessToken: event.accessToken!,
        onReceiveProgress: (received, total) {
          final progress = (received / total) * 100;
          emit(UploadMomentFileProgressState(progress));
          emit(MomentsInitialState());
        },
      );

      if (data.statusCode == 200) {
        emit(UploadMomentFileLoadedState(
            FileUpload.fromJson(ResponseData.fromJson(data.data).data)
                .files![0]));
      } else {
        emit(UploadMomentFileFailedState(data.statusMessage!));
      }
    } on DioException catch (error) {
      emit(UploadMomentFileErrorState(error.message!));
    }
  }

  _onPostFileThumbnailsEvent(
      PostMomentThumbnailEvent event, Emitter<MomentsState> emit) async {
    emit(UploadMomentThumbnailLoadingState());
    try {
      Response data = await _api.postMomentFiles(
        params: event.params,
        body: event.body,
        apiKey: event.apiKey!,
        url: event.url!,
        accessToken: event.accessToken!,
        onReceiveProgress: (received, total) {
          final progress = (received / total) * 100;
          emit(UploadMomentThumbnailProgressState(progress));
          emit(MomentsInitialState());
        },
      );

      if (data.statusCode == 200) {
        emit(UploadMomentThumbnailLoadedState(
            FileUpload.fromJson(ResponseData.fromJson(data.data).data)
                .files![0]));
      } else {
        emit(UploadMomentThumbnailFailedState(data.statusMessage!));
      }
    } on DioException catch (error) {
      emit(UploadMomentThumbnailErrorState(error.message!));
    }
  }
}
