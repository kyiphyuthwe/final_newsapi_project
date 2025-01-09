import 'package:finalnewsapiproject/constants/const.dart';
import 'package:finalnewsapiproject/models/everything_model.dart';
import 'package:finalnewsapiproject/network/repo/everything_repo.dart';
import 'package:finalnewsapiproject/network/resp_obj.dart';
import 'package:flutter/material.dart';

class EverythingProvider extends ChangeNotifier {
  EverythingRepository everythingRepo = EverythingRepository();

  RespObj respObj = RespObj(apiState: ApiState.initial, data: null);

  Future<void> getApiData() async {
    final response = await everythingRepo.getDesiredList(everythingEndpoint);

    if (response.apiState == ApiState.success) {
      List<dynamic> articlesJson = response.data['articles'];

      final modelData =
          articlesJson.map((item) => EverythingModel.fromJson(item)).toList();

      respObj = RespObj(apiState: ApiState.success, data: modelData);
      notifyListeners();
    } else {
      respObj = RespObj(apiState: ApiState.failure, data: response.data);
      notifyListeners();
    }
  }
}
