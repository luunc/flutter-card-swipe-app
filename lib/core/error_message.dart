import 'package:dio/dio.dart';

String getErrorMessage(Exception e) {
  try {
    final finalE = e as DioError;
    if (500 < finalE.response.statusCode && finalE.response.statusCode < 599)
      return 'Server error. Please try again a few moment later';

    return 'Network error';
  } catch (e) {
    return 'Unknow error';
  }
}
