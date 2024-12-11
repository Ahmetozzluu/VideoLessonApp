// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginResponseModel {
  final int? id;
  final bool? success;
  final String? message;
  final String? errorMessage;

  LoginResponseModel({
    this.id,
    this.success,
    this.message,
    this.errorMessage,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'] ?? "",
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      errorMessage: json['errorMessage'] ?? "",
    );
  }

 /* Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'errorMessage': errorMessage,
      };*/
}

