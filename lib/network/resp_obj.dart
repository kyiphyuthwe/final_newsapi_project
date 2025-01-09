enum ApiState { initial, loading, success, failure }

enum ErrorState {
  notFound,
  unauthorized,
  forbidden,
  server,
  badRequest,
  tooManyRequest,
  unknown
}

class RespObj {
  final dynamic data;
  final ApiState apiState;
  final ErrorState? errorState;

  RespObj({required this.data, required this.apiState, this.errorState});
}
