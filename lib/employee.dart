class Employee {
  int _id;
  String _name;
  double _salary;

  Employee(this._id, this._name, this._salary);

  //setters
  set name(String name) {
    _name = name;
  }
  set salary(double salary) {
    _salary = salary;
  }
  set id(int id) {
    _id = id;
  }

  //getters
  String get name => _name;
  double get salary => _salary;
  int get id => _id;
  
}
