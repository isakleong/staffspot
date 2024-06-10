import 'package:dio/dio.dart';
import 'package:staffspot/models/employee.dart';

class EmployeeRepository {
  final dio = Dio(BaseOptions(baseUrl: 'https://tiraapi-dev.tigaraksa.co.id/tes-programer-mobile/api'));

  Future<DataEmployee> getEmployee() async {
    final response = await dio.get('/karyawan/all');
    return DataEmployee.fromJson(response.data);
  }
}