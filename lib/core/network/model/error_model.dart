import 'package:equatable/equatable.dart';

class NetworkErrorModel extends Equatable {
  final int? statusCode;
  final String? statusMessage;

  const NetworkErrorModel({this.statusCode, this.statusMessage});

  factory NetworkErrorModel.fromJson(Map<String, dynamic> json) {
    return NetworkErrorModel(
      statusCode: json['status_code'] is int
          ? json['status_code']
          : int.tryParse(json['status_code'].toString()),
      statusMessage: json['status_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'status_message': statusMessage,
    };
  }

  @override
  String toString() =>
      'NetworkErrorModel(statusCode: $statusCode, statusMessage: $statusMessage)';

  @override
  List<Object?> get props => [statusCode, statusMessage];
}
