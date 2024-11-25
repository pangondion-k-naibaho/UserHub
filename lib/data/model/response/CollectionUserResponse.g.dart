// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectionUserResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionUserResponse _$CollectionUserResponseFromJson(
        Map<String, dynamic> json) =>
    CollectionUserResponse(
      page: (json['page'] as num?)?.toInt(),
      perPage: (json['perPage'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => UserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectionUserResponseToJson(
        CollectionUserResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'perPage': instance.perPage,
      'total': instance.total,
      'totalPages': instance.totalPages,
      'data': instance.data,
    };
