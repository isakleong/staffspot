part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class LoadEmployeeEvent extends EmployeeEvent {
  @override
  List<Object?> get props => [];
}
