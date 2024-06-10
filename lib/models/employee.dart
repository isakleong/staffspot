class DataEmployee {
  List<Employee> values;

  DataEmployee({required this.values});

  factory DataEmployee.fromJson(Map<String, dynamic> json) => DataEmployee (
    values: List.from(json['values'].map((employee) => Employee.fromJson(employee)))
  );
}

class Employee {
  final int nik;
  final String firstName;
  final String lastName;
  final String alamat;
  final bool aktif;

  Employee({required this.nik, required this.firstName, required this.lastName, required this.alamat, required this.aktif});

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    nik : json['nik'] ?? 0,
    firstName : json['first_name'] ?? '',
    lastName : json['last_name'] ?? '',
    alamat : json['alamat'] ?? '',
    aktif : json['aktif'] ?? false,
  );
}
