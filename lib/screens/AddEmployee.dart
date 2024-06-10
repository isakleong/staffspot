import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddEmployee extends StatelessWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SvgPicture.asset(
                'assets/images/bg-home.svg',
                fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                  const SizedBox(height: 16,),
                  const Expanded(
                    child: InsertForm()
                  ),
                ],
              ),
            ),
          ],
        ),
      )
      
      
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

  final nikNode = FocusNode();
  final fnameNode = FocusNode();
  final lnameNode = FocusNode();
  final addressNode = FocusNode();
  final activeNode = FocusNode();

  bool isNikFocus = false;
  bool isFnameFocus = false;
  bool isLnameFocus = false;
  bool isAddressFocus = false;

  @override
  void initState() {
    super.initState();
    _nikController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _addressController = TextEditingController();

    nikNode.addListener(nikChange);
    fnameNode.addListener(fnameChange);
    lnameNode.addListener(lnameChange);
    addressNode.addListener(addressChange);
  }

  void nikChange() {
    setState(() {
      isNikFocus = nikNode.hasFocus;
    });
  }

  void fnameChange() {
    setState(() {
      isFnameFocus = fnameNode.hasFocus;
    });
  }

  void lnameChange() {
    setState(() {
      isLnameFocus = lnameNode.hasFocus;
    });
  }

  void addressChange() {
    setState(() {
      isAddressFocus = addressNode.hasFocus;
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
    return Form(
      key: _formKey,
      child: ListView(
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is validated, submit data
                final nik = int.parse(_nikController.text);
                final firstName = _firstNameController.text;
                final lastName = _lastNameController.text;
                final address = _addressController.text;
                // Dispatch event to insert employee
                // You will implement this part with BLoC
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
