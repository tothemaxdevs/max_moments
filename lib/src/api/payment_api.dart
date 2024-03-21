import 'package:dio/dio.dart';
import 'package:max_moments/utils/environment/environment.dart';
import 'package:max_moments/utils/service/api_service.dart';

class MomentAPI {
  final ApiService _apiService;

  MomentAPI() : _apiService = ApiService();
  static const String api = Environment.endpointApi;
  static const String moments = 'merchant/moments';
  static const String momentDetail = 'merchant/moment';
  static const String likeDislike = 'merchant/like-moment';
  static const String comment = 'merchant/comment-moment';
  static const String reply = 'merchant/reply-moment';
  static const String allReply = 'merchant/all-replies';
  static const String allComment = 'merchant/all-comments';
  static const String doubleTapLike = 'merchant/double-tap-like';

  Map<String, dynamic>? nullBody = {};

  Future<Response> getMomentList({params}) async {
    Response response =
        await _apiService.get('$api$moments', queryParam: params);
    return response;
  }

  Future<Response> getMomentDetail(id) async {
    Response response = await _apiService.get('$api$momentDetail/$id');
    return response;
  }

  Future<Response> getCommentDetail(id) async {
    Response response = await _apiService.get('$api$comment/$id');
    return response;
  }

  Future<Response> getReplyDetail(id) async {
    Response response = await _apiService.get('$api$reply/$id');
    return response;
  }

  Future<Response> getAllComment({id, params}) async {
    Response response =
        await _apiService.get('$api$allComment/$id', queryParam: params);
    return response;
  }

  Future<Response> getReplyList({id, params}) async {
    Response response =
        await _apiService.get('$api$allReply/$id', queryParam: params);
    return response;
  }

  Future<Response> postComment({id, body}) async {
    Response response = await _apiService.post('$api$comment/$id', body);
    return response;
  }

  Future<Response> postReply({id, params}) async {
    Response response = await _apiService.post('$api$reply/$id', params);
    return response;
  }

  Future<Response> postLikeDislike(id) async {
    Response response =
        await _apiService.post('$api$likeDislike/$id', nullBody);
    return response;
  }

  Future<Response> postDoubleTapLike(id) async {
    Response response =
        await _apiService.post('$api$doubleTapLike/$id', nullBody);
    return response;
  }
}
