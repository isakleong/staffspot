import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:staffspot/models/employee.dart';

class EmployeeRepository {
  final dio = Dio(BaseOptions(baseUrl: 'https://tiraapi-dev.tigaraksa.co.id/tes-programer-mobile'));

  Future<DataEmployee> getEmployee() async {
    final response = await dio.get('/api/karyawan/all');
    return DataEmployee.fromJson(response.data);
  }

  postEmployee(int nik, String fname, String lname, String address, bool active) async {
    var params =  {
      'nik': nik,
      'first_name': fname,
      'last_name': lname,
      'alamat': address,
      'aktif': active
    };
    var bodyData = jsonEncode([params]);

    print(bodyData);

     var result = await dio.post(
      '/karyawan/insert',
      data: bodyData,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ));

      if (result.statusCode == 204) {
        return "success";
      } else {
        throw Exception('Failed to post employee');
      }
  }

}