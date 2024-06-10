import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:staffspot/repository/employee_repository.dart';
import 'package:staffspot/screens/bloc/employee_form/employee_form_bloc.dart';
import 'package:staffspot/screens/bloc/employee_list/employee_bloc.dart';
import 'package:staffspot/widgets/textview.dart';

class AddEmployee extends StatelessWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeFormBloc(EmployeeRepository()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/images/bg-insert.svg',
                fit: BoxFit.cover,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade700,
                        elevation: 5,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Icon(Icons.arrow_back,
                          size: 25, color: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    const Expanded(child: InsertForm()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InsertForm extends StatefulWidget {
  const InsertForm({Key? key}) : super(key: key);

  @override
  _InsertFormState createState() => _InsertFormState();
}

class _InsertFormState extends State<InsertForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nikController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _addressController;

  final FocusNode nikNode = FocusNode();
  final FocusNode fnameNode = FocusNode();
  final FocusNode lnameNode = FocusNode();
  final FocusNode addressNode = FocusNode();

  bool isNikFocus = false;
  bool isFnameFocus = false;
  bool isLnameFocus = false;
  bool isAddressFocus = false;

  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _nikController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _addressController = TextEditingController();

    nikNode.addListener(() {
      setState(() {
        isNikFocus = nikNode.hasFocus;
      });
    });
    fnameNode.addListener(() {
      setState(() {
        isFnameFocus = fnameNode.hasFocus;
      });
    });
    lnameNode.addListener(() {
      setState(() {
        isLnameFocus = lnameNode.hasFocus;
      });
    });
    addressNode.addListener(() {
      setState(() {
        isAddressFocus = addressNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _nikController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocListener<EmployeeFormBloc, EmployeeFormState>(
      listener: (context, state) {
        if (state is EmployeeFormSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Data Karyawan berhasil ditambahkan!')),
          );
          Navigator.pop(context);
          BlocProvider.of<EmployeeBloc>(context).add(LoadEmployeeEvent());
        } else if (state is EmployeeFormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: BlocBuilder<EmployeeFormBloc, EmployeeFormState>(
        builder: (context, state) {
          if (state is EmployeeFormLoading) {
            return Center(
              child: Lottie.asset(
                'assets/animations/loading.json',
                width: width * 0.5,
                fit: BoxFit.contain,
              ),
            );
          }
          return Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                TextFormField(
                  controller: _nikController,
                  focusNode: nikNode,
                  decoration: InputDecoration(
                    hintText: "NIK",
                    filled: true,
                    fillColor: Colors.teal.shade100,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.badge,
                        color: isNikFocus ? Colors.teal : Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter NIK';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _firstNameController,
                  focusNode: fnameNode,
                  decoration: InputDecoration(
                    hintText: "Nama Depan",
                    filled: true,
                    fillColor: Colors.teal.shade100,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.person,
                        color: isFnameFocus ? Colors.teal : Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  focusNode: lnameNode,
                  decoration: InputDecoration(
                    hintText: "Nama Belakang",
                    filled: true,
                    fillColor: Colors.teal.shade100,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.person,
                        color: isLnameFocus ? Colors.teal : Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  focusNode: addressNode,
                  decoration: InputDecoration(
                    hintText: "Alamat",
                    filled: true,
                    fillColor: Colors.teal.shade100,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.home,
                        color: isAddressFocus ? Colors.teal : Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text("Active"),
                    Switch(
                      value: _isActive,
                      onChanged: (value) {
                        setState(() {
                          _isActive = value;
                        });
                      },
                      activeColor: Colors.teal,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade700,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final nik = int.parse(_nikController.text);
                      final firstName = _firstNameController.text;
                      final lastName = _lastNameController.text;
                      final address = _addressController.text;
                      context.read<EmployeeFormBloc>().add(SubmitEmployeeForm(
                            nik: nik,
                            firstName: firstName,
                            lastName: lastName,
                            address: address,
                            active: _isActive,
                          ));
                    }
                  },
                  child: const TextView(
                    headings: "H2",
                    text: "SIMPAN",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
