import 'package:bloclearn/employee.dart';
import 'package:bloclearn/employeeBloc.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee App'),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeeListStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) return const Text('Error!');

            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '${snapshot.data![index].id}',
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data![index].name,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              '${snapshot.data![index].salary}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: const Icon(Icons.thumb_up),
                          onPressed: () {
                            _employeeBloc.employeeSalaryIncrementSink.add(
                              _employeeBloc
                                  .incrementSalary(snapshot.data![index]),
                            );
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: const Icon(Icons.thumb_down),
                          onPressed: () {
                            _employeeBloc.employeeSalaryDecrementSink.add(
                              _employeeBloc
                                  .decrementSalary(snapshot.data![index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
