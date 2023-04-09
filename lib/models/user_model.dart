class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final int userPoint;
  final String selectedCourse;
  final int mainCourseCompletion;
  final int entCompletion;
  final int englishCompletion;
  final bool isModerator;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userPoint,
    required this.selectedCourse,
    required this.mainCourseCompletion,
    required this.entCompletion,
    required this.englishCompletion,
    required this.isModerator,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      userPoint: data['userPoint'] ?? 0,
      selectedCourse: data['selectedCourse'] ?? '',
      mainCourseCompletion: data['mainCourseCompletion'] ?? 0,
      entCompletion: data['entCompletion'] ?? 0,
      englishCompletion: data['englishCompletion'] ?? 0,
      isModerator: data['isModerator'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'userPoint': userPoint,
      'selectedCourse': selectedCourse,
      'mainCourseCompletion': mainCourseCompletion,
      'entCompletion': entCompletion,
      'englishCompletion': englishCompletion,
      'isModerator':isModerator,
    };
  }
}
