// employee_bloc.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staffspot/repository/employee_repository.dart';
import 'package:staffspot/models/employee.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;
  EmployeeBloc({required this.employeeRepository}) : super(EmployeeInitial()) {
    on<LoadEmployeeEvent>((event, emit) async {
      emit(EmployeeLoading());
      try {
        final items = await employeeRepository.getEmployee();
        emit(EmployeeLoaded(items.values));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    });
  }
}
