import 'package:finalnewsapiproject/constants/const.dart';
import 'package:finalnewsapiproject/models/headline_model.dart';
import 'package:finalnewsapiproject/network/repo/headline_repo.dart';
import 'package:finalnewsapiproject/network/resp_obj.dart';
import 'package:flutter/material.dart';

class HeadlineProvider extends ChangeNotifier {
  HeadlineRepo headlineRepo = HeadlineRepo();

  RespObj respObj = RespObj(apiState: ApiState.initial, data: null);

  Future<void> getApiData(String categoryName) async {
    final response =
        await headlineRepo.getDesiredList(headlineEndpoint, categoryName);

    if (response.apiState == ApiState.success) {
      List<dynamic> articlesJson = response.data['articles'];

      final modelData =
          articlesJson.map((item) => HeadlineModel.fromJson(item)).toList();

      respObj = RespObj(apiState: ApiState.success, data: modelData);
      notifyListeners();
    } else {
      respObj = RespObj(apiState: ApiState.failure, data: response.data);
      notifyListeners();
    }
  }
}
