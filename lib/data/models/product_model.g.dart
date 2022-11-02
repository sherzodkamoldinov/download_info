// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      categoryId: json['category_id'] as int? ?? 0,
      fileUrl: json['file_url'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      price: json['price'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'price': instance.price,
      'name': instance.name,
      'file_url': instance.fileUrl,
    };
