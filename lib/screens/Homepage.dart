import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:staffspot/repository/employee_repository.dart';
import 'package:staffspot/screens/AddEmployee.dart';
import 'package:staffspot/screens/bloc/employee_bloc.dart';
import 'package:staffspot/widgets/textview.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EmployeeBloc(employeeRepository: EmployeeRepository())..add(LoadEmployeeEvent()),
      child: WillPopScope(
        onWillPop: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal.shade700,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddEmployee()),
              );
            },
            child: Icon(Icons.add),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                SvgPicture.asset(
                    'assets/images/bg-home.svg',
                    fit: BoxFit.cover,
                ),
                BlocBuilder<EmployeeBloc, EmployeeState>(
                  builder: (context, state) {
                    if(state is EmployeeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if(state is EmployeeLoaded) {
                      final employeeItem = state.items;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: employeeItem.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                elevation: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.grey.shade300)
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: -15,
                                          left: -45,
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.teal.withOpacity(0.4)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 25),
                                              child: Center(
                                                child: TextView(
                                                  headings: "H3",
                                                  text: (index + 1).toString(),
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  isAutoSize: true,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 80, right: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 20),
                                               Row(
                                                children: [
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.teal,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(Icons.badge,
                                                        color: Colors.white,
                                                        size: 18),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const SizedBox(
                                                    width: 150,
                                                    child: TextView(headings: "H3", text: "NIK", fontSize: 16, maxLines: 1, isAutoSize: true,textAlign: TextAlign.start)
                                                  ),
                                                  Expanded(
                                                    child: TextView(headings: "H3", text: employeeItem[index].nik.toString(), fontSize: 16, color: Colors.black, isAutoSize: true, textAlign: TextAlign.start, maxLines: 1),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.teal,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(Icons.person,
                                                        color: Colors.white,
                                                        size: 18),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const SizedBox(
                                                    width: 150,
                                                    child: TextView(headings: "H3", text: "Nama Lengkap", fontSize: 16, maxLines: 1, isAutoSize: true,textAlign: TextAlign.start)
                                                  ),
                                                  Expanded(
                                                    child: TextView(headings: "H3", text: "${employeeItem[index].firstName} ${employeeItem[index].lastName}", fontSize: 16, color: Colors.black, isAutoSize: true, textAlign: TextAlign.start, maxLines: 1),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.teal,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(Icons.home,
                                                        color: Colors.white,
                                                        size: 18),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const SizedBox(
                                                    width: 150,
                                                    child: TextView(headings: "H3", text: "Alamat", fontSize: 16, maxLines: 1, isAutoSize: true,textAlign: TextAlign.start)
                                                  ),
                                                  Expanded(
                                                    child: TextView(headings: "H3", text: employeeItem[index].alamat, fontSize: 16, color: Colors.black, isAutoSize: true, textAlign: TextAlign.start, maxLines: 1),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.teal,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(Icons.check,
                                                        color: Colors.white,
                                                        size: 18),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const SizedBox(
                                                    width: 150,
                                                    child: TextView(headings: "H3", text: "Status", fontSize: 16, maxLines: 1, isAutoSize: true,textAlign: TextAlign.start)
                                                  ),
                                                  Expanded(
                                                    child: TextView(headings: "H3", text: employeeItem[index].aktif ? "Aktif" : "Tidak Aktif", fontSize: 16, color: Colors.black, isAutoSize: true, textAlign: TextAlign.start, maxLines: 1),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if(state is EmployeeError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                )
              ]
            ),
          ),
        ),
      )
    );
  }
}
