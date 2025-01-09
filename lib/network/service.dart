import 'package:dio/dio.dart';
import 'package:finalnewsapiproject/constants/const.dart';
import 'package:finalnewsapiproject/network/resp_obj.dart';

class Service {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<RespObj> get(String endpointUrl,
      {required Map<String, String> params}) async {
    RespObj respObj;
    try {
      final response = await dio.get(endpointUrl, queryParameters: params);

      if (response.statusCode == 200) {
        respObj = RespObj(data: response.data, apiState: ApiState.success);
      } else {
        respObj = RespObj(data: "Something Wrong!", apiState: ApiState.failure);
      }
      return respObj;
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        if (statusCode == 404) {
          respObj = RespObj(
            data: "404 Page Not Found",
            apiState: ApiState.failure,
            errorState: ErrorState.notFound,
          );
        } else if (statusCode == 401) {
          respObj = RespObj(
            data: "401 Unauthorized Error",
            apiState: ApiState.failure,
            errorState: ErrorState.unauthorized,
          );
        } else if (statusCode == 403) {
          respObj = RespObj(
            data: "403 Forbidden Error",
            apiState: ApiState.failure,
            errorState: ErrorState.forbidden,
          );
        } else if (statusCode == 500) {
          respObj = RespObj(
            data: "500 Internal Server Error",
            apiState: ApiState.failure,
            errorState: ErrorState.server,
          );
        } else if (statusCode == 400) {
          respObj = RespObj(
            data: "400 Bad Request",
            apiState: ApiState.failure,
            errorState: ErrorState.badRequest,
          );
        } else if (statusCode == 429) {
          respObj = RespObj(
            data: "429 Too Many Request",
            apiState: ApiState.failure,
            errorState: ErrorState.tooManyRequest,
          );
        } else {
          respObj = RespObj(
            data: "Unknown",
            apiState: ApiState.failure,
            errorState: ErrorState.unknown,
          );
        }
        return respObj;
      }
      throw Exception(e.error.toString());
    }
  }
}
