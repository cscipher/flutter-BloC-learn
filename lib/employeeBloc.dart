import 'dart:async';
import 'employee.dart';

class EmployeeBloc {
  // dummy data
  final List<Employee> _employeeList = [
    Employee(1, 'cipher', 91000.0),
    Employee(2, 'harsh', 84500.0),
    Employee(3, 'xeno', 78650.0),
    Employee(4, 'shin', 99990.0),
  ];

  // stream controller is the 'gate' through which we can add, remove, and listen to the stream
  final _employeeListStreamController = StreamController<List<Employee>>();

  //inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  // sink getters (input)
  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  // stream getters (output)
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  //inc getters
  StreamSink<Employee> get employeeSalaryIncrementSink =>
      _employeeSalaryIncrementStreamController.sink;
  //dec getters
  StreamSink<Employee> get employeeSalaryDecrementSink =>
      _employeeSalaryDecrementStreamController.sink;

  // core functions (logical funcs)
  void _incrementSalary(Employee event) {
    double salary = event.salary;
    double incrementedSalary = salary * 20 / 100;
    _employeeList[_employeeList.indexOf(event)] =
        Employee(event.id, event.name, salary + incrementedSalary);
    employeeListSink.add(_employeeList);
  }

  void _decrementSalary(Employee event) {
    double salary = event.salary;
    double decrementedSalary = salary * 20 / 100;
    _employeeList[_employeeList.indexOf(event)] =
        Employee(event.id, event.name, salary - decrementedSalary);
    employeeListSink.add(_employeeList);
  }

  // increment salary method getter
  Function(Employee) get incrementSalary => _incrementSalary;
  // decrement salary method getter
  Function(Employee) get decrementSalary => _decrementSalary;

  // constructor
  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  //dispose
  void dispose() {
    _employeeListStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
  }
}
