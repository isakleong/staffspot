// employee_form_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staffspot/repository/employee_repository.dart';

part 'employee_form_event.dart';
part 'employee_form_state.dart';

class EmployeeFormBloc extends Bloc<EmployeeFormEvent, EmployeeFormState> {
  final EmployeeRepository repository;

  EmployeeFormBloc(this.repository) : super(EmployeeFormInitial()) {
    on<SubmitEmployeeForm>(_onSubmitEmployeeForm);
  }

  Future<void> _onSubmitEmployeeForm(
      SubmitEmployeeForm event, Emitter<EmployeeFormState> emit) async {
    emit(EmployeeFormLoading());
    try {
      await repository.postEmployee(
        event.nik,
        event.firstName,
        event.lastName,
        event.address,
        event.active,
      );
      emit(EmployeeFormSuccess());
    } catch (e) {
      emit(EmployeeFormError(e.toString()));
    }
  }
}
