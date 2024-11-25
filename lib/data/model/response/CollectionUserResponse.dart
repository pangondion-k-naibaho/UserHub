import 'package:json_annotation/json_annotation.dart';
import 'UserResponse.dart'; // Import model UserResponse

part 'CollectionUserResponse.g.dart';

@JsonSerializable()
class CollectionUserResponse {
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<UserResponse> data;

  CollectionUserResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory CollectionUserResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionUserResponseToJson(this);

  @override
  String toString() {
    return 'CollectionUserResponse{page: $page, perPage: $perPage, total: $total, totalPages: $totalPages, data: $data}';
  }
}
