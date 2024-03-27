import 'package:dio/dio.dart';
import 'package:max_moments/utils/service/api_service.dart';

class MomentAPI {
  final ApiService _apiService;

  MomentAPI() : _apiService = ApiService();

  static const String moments = 'moments';
  static const String momentDetail = 'moments';
  static const String likeDislike = 'like-moment';
  static const String comment = 'comment-moment';
  static const String reply = 'reply-moment';
  static const String allReply = 'all-replies';
  static const String allComment = 'all-comments';
  static const String doubleTapLike = 'double-tap-like';

  Map<String, dynamic>? nullBody = {};

  Future<Response> getMomentList(
      {params,
      required String url,
      required String accessToken,
      required String apiKey}) async {
    Response response = await _apiService.get('$url$moments',
        queryParam: params, apiKey: apiKey, accessToken: accessToken);
    return response;
  }

  Future<Response> getMomentDetail(id,
      {required String url,
      required String accessToken,
      required String apiKey}) async {
    Response response = await _apiService.get('$url$momentDetail/$id',
        apiKey: apiKey, accessToken: accessToken);
    return response;
  }

  Future<Response> getCommentDetail(id,
      {required String url,
      required String accessToken,
      required String apiKey}) async {
    Response response = await _apiService.get('$url$comment/$id',
        apiKey: apiKey, accessToken: accessToken);
    return response;
  }

  Future<Response> getReplyDetail(id,
      {required String url,
      required String accessToken,
      required String apiKey}) async {
    Response response = await _apiService.get('$url$reply/$id',
        apiKey: apiKey, accessToken: accessToken);
    return response;
  }

  Future<Response> getAllComment(
      {id,
      params,
      required String url,
      required String accessToken,
      required String apiKey}) async {
    Response response = await _apiService.get('$url$allComment/$id',
        queryParam: params, apiKey: apiKey, accessToken: accessToken);
    return response;
  }

  Future<Response> getReplyList(
      {id,
      params,
      required String url,
      required String accessToken,
      required String apiKey}) async {
    Response response = await _apiService.get('$url$allReply/$id',
        queryParam: params, apiKey: apiKey, accessToken: accessToken);
    return response;
  }

  Future<Response> postComment(
      {id,
      body,
      required String url,
      required String accessToken,
      required String apiKey}) async {
    Response response = await _apiService.post('$url$comment/$id', body,
        apiKey: apiKey, accessToken: accessToken);
    return response;
  }

  Future<Response> postReply(
      {id,
      params,
      required String url,
      required String accessToken,
      required String apiKey}) async {
    Response response = await _apiService.post('$url$reply/$id', params,
        apiKey: apiKey, accessToken: accessToken);
    return response;
  }

  Future<Response> postLikeDislike(id,
      {required String url,
      required String accessToken,
      required String apiKey}) async {
    Response response = await _apiService.post('$url$likeDislike/$id', nullBody,
        apiKey: apiKey, accessToken: accessToken);
    return response;
  }

  Future<Response> postDoubleTapLike(id,
      {required String url,
      required String accessToken,
      required String apiKey}) async {
    Response response = await _apiService.post(
        '$url$doubleTapLike/$id', nullBody,
        apiKey: apiKey, accessToken: accessToken);
    return response;
  }
}
