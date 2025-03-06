// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_breeds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DogBreeds _$DogBreedsFromJson(Map<String, dynamic> json) => DogBreeds(
  message: (json['message'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
  ),
  status: json['status'] as String,
);

Map<String, dynamic> _$DogBreedsToJson(DogBreeds instance) => <String, dynamic>{
  'message': instance.message,
  'status': instance.status,
};
