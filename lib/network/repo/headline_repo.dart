import 'package:finalnewsapiproject/network/resp_obj.dart';
import 'package:finalnewsapiproject/network/service.dart';

class HeadlineRepo {
  final headlineService = Service();

  Future<RespObj> getDesiredList(
      String endpointUrl, String categoryName) async {
    final response = await headlineService.get(endpointUrl, params: {
      "country": "us",
      "category": categoryName,
      "apiKey": "e8c1a73f83954b2e9537e57fdb96527a"
    });
    return response;
  }
}
