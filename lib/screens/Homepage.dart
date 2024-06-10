import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:staffspot/repository/employee_repository.dart';
import 'package:staffspot/screens/AddEmployee.dart';
import 'package:staffspot/screens/bloc/employee_list/employee_bloc.dart';
import 'package:staffspot/widgets/textview.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();
    // context.read<EmployeeBloc>().add(LoadEmployeeEvent());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
                PageRouteBuilder(
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = 0.0;
                    var end = 1.0;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );

                    return FadeTransition(
                      opacity: animation.drive(tween),
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) => const AddEmployee(),
                ),
              );

            },
            child: const Icon(Icons.person_add),
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
                      return Center(
                        child: Lottie.asset(
                          'assets/animations/loading.json',
                          width: width * 0.5,
                          fit: BoxFit.contain,
                        ),
                      );
                    } else if(state is EmployeeLoaded) {
                      final employeeItem = state.items;
                      return RefreshIndicator(
                        onRefresh: () async {
                          // Dispatch the event to reload the employee data
                          context.read<EmployeeBloc>().add(LoadEmployeeEvent());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
                                            padding: const EdgeInsets.only(left: 60, right: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 20),
                                                 Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.badge,
                                                      color: Colors.teal,
                                                      size: 16
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Expanded(child: TextView(headings: "H3", text: "NIK", maxLines: 1, isAutoSize: true,textAlign: TextAlign.start)),
                                                    Expanded(
                                                      child: TextView(headings: "H3", text: employeeItem[index].nik.toString(), color: Colors.black, isAutoSize: true, textAlign: TextAlign.start, maxLines: 1),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.person,
                                                      color: Colors.teal,
                                                      size: 16
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Expanded(child: TextView(headings: "H3", text: "Nama", maxLines: 1, isAutoSize: true,textAlign: TextAlign.start)),
                                                    Expanded(
                                                      child: TextView(headings: "H3", text: "${employeeItem[index].firstName} ${employeeItem[index].lastName}", color: Colors.black, isAutoSize: true, textAlign: TextAlign.start, maxLines: 1),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.home,
                                                      color: Colors.teal,
                                                      size: 16
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Expanded(child: TextView(headings: "H3", text: "Alamat", maxLines: 1, isAutoSize: true,textAlign: TextAlign.start)),
                                                    Expanded(
                                                      child: TextView(headings: "H3", text: employeeItem[index].alamat, color: Colors.black, isAutoSize: true, textAlign: TextAlign.start, maxLines: 1),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.check,
                                                      color: Colors.teal,
                                                      size: 16
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Expanded(child: TextView(headings: "H3", text: "Status", maxLines: 1, isAutoSize: true,textAlign: TextAlign.start)),
                                                    Expanded(
                                                      child: TextView(headings: "H3", text: employeeItem[index].aktif ? "Aktif" : "Tidak Aktif", color: Colors.black, isAutoSize: true, textAlign: TextAlign.start, maxLines: 1),
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
