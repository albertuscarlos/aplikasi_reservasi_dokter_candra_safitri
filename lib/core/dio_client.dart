import 'package:dio/dio.dart';

final dioClient = Dio(
  BaseOptions(
    headers: {
      'Accept': '*/*',
      'Content-Type': 'application/json',
    },
    receiveDataWhenStatusError: true,
    contentType: 'application/json',
  ),
);
