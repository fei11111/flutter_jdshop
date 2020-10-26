import 'package:dio/dio.dart';
import 'result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    return new ResultData(response.data, response.data['success'],
        response.data['message']);
  }
}
