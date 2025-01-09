import 'package:finalnewsapiproject/network/resp_obj.dart';
import 'package:finalnewsapiproject/network/service.dart';

class EverythingRepository {
  final everythingService = Service();
  Future<RespObj> getDesiredList(String endpointUrl) async {
    final response = await everythingService.get(endpointUrl, params: {
      "q": "tesla",
      "sortBy": "publishedAt",
      "apiKey": "e8c1a73f83954b2e9537e57fdb96527a",
    });
    return response;
  }
}
