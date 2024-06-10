// employee_form_event.dart
part of 'employee_form_bloc.dart';

abstract class EmployeeFormEvent {}

class SubmitEmployeeForm extends EmployeeFormEvent {
  final int nik;
  final String firstName;
  final String lastName;
  final String address;
  final bool active;

  SubmitEmployeeForm({
    required this.nik,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.active,
  });
}
