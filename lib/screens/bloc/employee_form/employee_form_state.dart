part of 'employee_form_bloc.dart';

abstract class EmployeeFormState {}

class EmployeeFormInitial extends EmployeeFormState {}

class EmployeeFormLoading extends EmployeeFormState {}

class EmployeeFormSuccess extends EmployeeFormState {}

class EmployeeFormError extends EmployeeFormState {
  final String message;

  EmployeeFormError(this.message);
}
