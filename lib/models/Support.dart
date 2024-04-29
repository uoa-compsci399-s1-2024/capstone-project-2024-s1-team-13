/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Support type in your schema. */
class Support extends amplify_core.Model {
  static const classType = const _SupportModelType();
  final String id;
  final String? _sharedPassword;
  final List<Trainee>? _suppTrainees;
  final List<TraineeNotes>? _suppTrNo;
  final List<CurrTask>? _suppCT;
  final List<Notifications>? _suppNotifs;
  final List<TaskNotes>? _suppTaNo;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  SupportModelIdentifier get modelIdentifier {
      return SupportModelIdentifier(
        id: id
      );
  }
  
  String? get sharedPassword {
    return _sharedPassword;
  }
  
  List<Trainee>? get suppTrainees {
    return _suppTrainees;
  }
  
  List<TraineeNotes>? get suppTrNo {
    return _suppTrNo;
  }
  
  List<CurrTask>? get suppCT {
    return _suppCT;
  }
  
  List<Notifications>? get suppNotifs {
    return _suppNotifs;
  }
  
  List<TaskNotes>? get suppTaNo {
    return _suppTaNo;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Support._internal({required this.id, sharedPassword, suppTrainees, suppTrNo, suppCT, suppNotifs, suppTaNo, createdAt, updatedAt}): _sharedPassword = sharedPassword, _suppTrainees = suppTrainees, _suppTrNo = suppTrNo, _suppCT = suppCT, _suppNotifs = suppNotifs, _suppTaNo = suppTaNo, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Support({String? id, String? sharedPassword, List<Trainee>? suppTrainees, List<TraineeNotes>? suppTrNo, List<CurrTask>? suppCT, List<Notifications>? suppNotifs, List<TaskNotes>? suppTaNo}) {
    return Support._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      sharedPassword: sharedPassword,
      suppTrainees: suppTrainees != null ? List<Trainee>.unmodifiable(suppTrainees) : suppTrainees,
      suppTrNo: suppTrNo != null ? List<TraineeNotes>.unmodifiable(suppTrNo) : suppTrNo,
      suppCT: suppCT != null ? List<CurrTask>.unmodifiable(suppCT) : suppCT,
      suppNotifs: suppNotifs != null ? List<Notifications>.unmodifiable(suppNotifs) : suppNotifs,
      suppTaNo: suppTaNo != null ? List<TaskNotes>.unmodifiable(suppTaNo) : suppTaNo);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Support &&
      id == other.id &&
      _sharedPassword == other._sharedPassword &&
      DeepCollectionEquality().equals(_suppTrainees, other._suppTrainees) &&
      DeepCollectionEquality().equals(_suppTrNo, other._suppTrNo) &&
      DeepCollectionEquality().equals(_suppCT, other._suppCT) &&
      DeepCollectionEquality().equals(_suppNotifs, other._suppNotifs) &&
      DeepCollectionEquality().equals(_suppTaNo, other._suppTaNo);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Support {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("sharedPassword=" + "$_sharedPassword" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Support copyWith({String? sharedPassword, List<Trainee>? suppTrainees, List<TraineeNotes>? suppTrNo, List<CurrTask>? suppCT, List<Notifications>? suppNotifs, List<TaskNotes>? suppTaNo}) {
    return Support._internal(
      id: id,
      sharedPassword: sharedPassword ?? this.sharedPassword,
      suppTrainees: suppTrainees ?? this.suppTrainees,
      suppTrNo: suppTrNo ?? this.suppTrNo,
      suppCT: suppCT ?? this.suppCT,
      suppNotifs: suppNotifs ?? this.suppNotifs,
      suppTaNo: suppTaNo ?? this.suppTaNo);
  }
  
  Support copyWithModelFieldValues({
    ModelFieldValue<String?>? sharedPassword,
    ModelFieldValue<List<Trainee>?>? suppTrainees,
    ModelFieldValue<List<TraineeNotes>?>? suppTrNo,
    ModelFieldValue<List<CurrTask>?>? suppCT,
    ModelFieldValue<List<Notifications>?>? suppNotifs,
    ModelFieldValue<List<TaskNotes>?>? suppTaNo
  }) {
    return Support._internal(
      id: id,
      sharedPassword: sharedPassword == null ? this.sharedPassword : sharedPassword.value,
      suppTrainees: suppTrainees == null ? this.suppTrainees : suppTrainees.value,
      suppTrNo: suppTrNo == null ? this.suppTrNo : suppTrNo.value,
      suppCT: suppCT == null ? this.suppCT : suppCT.value,
      suppNotifs: suppNotifs == null ? this.suppNotifs : suppNotifs.value,
      suppTaNo: suppTaNo == null ? this.suppTaNo : suppTaNo.value
    );
  }
  
  Support.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _sharedPassword = json['sharedPassword'],
      _suppTrainees = json['suppTrainees'] is List
        ? (json['suppTrainees'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Trainee.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _suppTrNo = json['suppTrNo'] is List
        ? (json['suppTrNo'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => TraineeNotes.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _suppCT = json['suppCT'] is List
        ? (json['suppCT'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => CurrTask.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _suppNotifs = json['suppNotifs'] is List
        ? (json['suppNotifs'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Notifications.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _suppTaNo = json['suppTaNo'] is List
        ? (json['suppTaNo'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => TaskNotes.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'sharedPassword': _sharedPassword, 'suppTrainees': _suppTrainees?.map((Trainee? e) => e?.toJson()).toList(), 'suppTrNo': _suppTrNo?.map((TraineeNotes? e) => e?.toJson()).toList(), 'suppCT': _suppCT?.map((CurrTask? e) => e?.toJson()).toList(), 'suppNotifs': _suppNotifs?.map((Notifications? e) => e?.toJson()).toList(), 'suppTaNo': _suppTaNo?.map((TaskNotes? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'sharedPassword': _sharedPassword,
    'suppTrainees': _suppTrainees,
    'suppTrNo': _suppTrNo,
    'suppCT': _suppCT,
    'suppNotifs': _suppNotifs,
    'suppTaNo': _suppTaNo,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<SupportModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<SupportModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final SHAREDPASSWORD = amplify_core.QueryField(fieldName: "sharedPassword");
  static final SUPPTRAINEES = amplify_core.QueryField(
    fieldName: "suppTrainees",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Trainee'));
  static final SUPPTRNO = amplify_core.QueryField(
    fieldName: "suppTrNo",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TraineeNotes'));
  static final SUPPCT = amplify_core.QueryField(
    fieldName: "suppCT",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'CurrTask'));
  static final SUPPNOTIFS = amplify_core.QueryField(
    fieldName: "suppNotifs",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Notifications'));
  static final SUPPTANO = amplify_core.QueryField(
    fieldName: "suppTaNo",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TaskNotes'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Support";
    modelSchemaDefinition.pluralName = "Supports";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Support.SHAREDPASSWORD,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Support.SUPPTRAINEES,
      isRequired: false,
      ofModelName: 'Trainee',
      associatedKey: Trainee.SUPPORTID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Support.SUPPTRNO,
      isRequired: false,
      ofModelName: 'TraineeNotes',
      associatedKey: TraineeNotes.SUPPORTID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Support.SUPPCT,
      isRequired: false,
      ofModelName: 'CurrTask',
      associatedKey: CurrTask.CURRTASKSUPP
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Support.SUPPNOTIFS,
      isRequired: false,
      ofModelName: 'Notifications',
      associatedKey: Notifications.SUPPORTID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Support.SUPPTANO,
      isRequired: false,
      ofModelName: 'TaskNotes',
      associatedKey: TaskNotes.SUPPORTID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _SupportModelType extends amplify_core.ModelType<Support> {
  const _SupportModelType();
  
  @override
  Support fromJson(Map<String, dynamic> jsonData) {
    return Support.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Support';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Support] in your schema.
 */
class SupportModelIdentifier implements amplify_core.ModelIdentifier<Support> {
  final String id;

  /** Create an instance of SupportModelIdentifier using [id] the primary key. */
  const SupportModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'SupportModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is SupportModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}