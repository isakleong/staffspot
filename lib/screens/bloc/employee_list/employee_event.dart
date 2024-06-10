// employee_event.dart

part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class LoadEmployeeEvent extends EmployeeEvent {
  @override
  List<Object?> get props => [];
}

class SearchEmployeeEvent extends EmployeeEvent {
  final String query;

  const SearchEmployeeEvent(this.query);

  @override
  List<Object?> get props => [query];
}
