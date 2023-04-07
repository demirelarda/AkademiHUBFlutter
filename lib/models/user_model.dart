class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final int userPoint;
  final String selectedCourse;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userPoint,
    required this.selectedCourse,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      userPoint: data['userPoint'],
      selectedCourse: data['selectedCourse'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'userPoint': userPoint,
      'selectedCourse': selectedCourse,
    };
  }
}
