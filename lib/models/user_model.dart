class UserModel {
  final String id;
  final String name;
  final String surname;
  final String selectedCourse;
  final int userPoints;

  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.selectedCourse,
    required this.userPoints,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      selectedCourse: map['selectedCourse'],
      userPoints: map['userPoints'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'selectedCourse': selectedCourse,
      'userPoints': userPoints,
    };
  }
}
