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


/** This is an auto generated class representing the Admin type in your schema. */
class Admin extends amplify_core.Model {
  static const classType = const _AdminModelType();
  final String id;
  final String? _userName;
  final String? _password;
  final List<Trainee>? _adminTrainees;
  final List<Task>? _adminTasks;
  final List<Recipe>? _adminRecipes;
  final List<Notifications>? _adminNotifs;
  final List<TaskNotes>? _adminTaNo;
  final List<TraineeNotes>? _adminTrNo;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  AdminModelIdentifier get modelIdentifier {
      return AdminModelIdentifier(
        id: id
      );
  }
  
  String? get userName {
    return _userName;
  }
  
  String? get password {
    return _password;
  }
  
  List<Trainee>? get adminTrainees {
    return _adminTrainees;
  }
  
  List<Task>? get adminTasks {
    return _adminTasks;
  }
  
  List<Recipe>? get adminRecipes {
    return _adminRecipes;
  }
  
  List<Notifications>? get adminNotifs {
    return _adminNotifs;
  }
  
  List<TaskNotes>? get adminTaNo {
    return _adminTaNo;
  }
  
  List<TraineeNotes>? get adminTrNo {
    return _adminTrNo;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Admin._internal({required this.id, userName, password, adminTrainees, adminTasks, adminRecipes, adminNotifs, adminTaNo, adminTrNo, createdAt, updatedAt}): _userName = userName, _password = password, _adminTrainees = adminTrainees, _adminTasks = adminTasks, _adminRecipes = adminRecipes, _adminNotifs = adminNotifs, _adminTaNo = adminTaNo, _adminTrNo = adminTrNo, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Admin({String? id, String? userName, String? password, List<Trainee>? adminTrainees, List<Task>? adminTasks, List<Recipe>? adminRecipes, List<Notifications>? adminNotifs, List<TaskNotes>? adminTaNo, List<TraineeNotes>? adminTrNo}) {
    return Admin._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      userName: userName,
      password: password,
      adminTrainees: adminTrainees != null ? List<Trainee>.unmodifiable(adminTrainees) : adminTrainees,
      adminTasks: adminTasks != null ? List<Task>.unmodifiable(adminTasks) : adminTasks,
      adminRecipes: adminRecipes != null ? List<Recipe>.unmodifiable(adminRecipes) : adminRecipes,
      adminNotifs: adminNotifs != null ? List<Notifications>.unmodifiable(adminNotifs) : adminNotifs,
      adminTaNo: adminTaNo != null ? List<TaskNotes>.unmodifiable(adminTaNo) : adminTaNo,
      adminTrNo: adminTrNo != null ? List<TraineeNotes>.unmodifiable(adminTrNo) : adminTrNo);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Admin &&
      id == other.id &&
      _userName == other._userName &&
      _password == other._password &&
      DeepCollectionEquality().equals(_adminTrainees, other._adminTrainees) &&
      DeepCollectionEquality().equals(_adminTasks, other._adminTasks) &&
      DeepCollectionEquality().equals(_adminRecipes, other._adminRecipes) &&
      DeepCollectionEquality().equals(_adminNotifs, other._adminNotifs) &&
      DeepCollectionEquality().equals(_adminTaNo, other._adminTaNo) &&
      DeepCollectionEquality().equals(_adminTrNo, other._adminTrNo);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Admin {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userName=" + "$_userName" + ", ");
    buffer.write("password=" + "$_password" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Admin copyWith({String? userName, String? password, List<Trainee>? adminTrainees, List<Task>? adminTasks, List<Recipe>? adminRecipes, List<Notifications>? adminNotifs, List<TaskNotes>? adminTaNo, List<TraineeNotes>? adminTrNo}) {
    return Admin._internal(
      id: id,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      adminTrainees: adminTrainees ?? this.adminTrainees,
      adminTasks: adminTasks ?? this.adminTasks,
      adminRecipes: adminRecipes ?? this.adminRecipes,
      adminNotifs: adminNotifs ?? this.adminNotifs,
      adminTaNo: adminTaNo ?? this.adminTaNo,
      adminTrNo: adminTrNo ?? this.adminTrNo);
  }
  
  Admin copyWithModelFieldValues({
    ModelFieldValue<String?>? userName,
    ModelFieldValue<String?>? password,
    ModelFieldValue<List<Trainee>?>? adminTrainees,
    ModelFieldValue<List<Task>?>? adminTasks,
    ModelFieldValue<List<Recipe>?>? adminRecipes,
    ModelFieldValue<List<Notifications>?>? adminNotifs,
    ModelFieldValue<List<TaskNotes>?>? adminTaNo,
    ModelFieldValue<List<TraineeNotes>?>? adminTrNo
  }) {
    return Admin._internal(
      id: id,
      userName: userName == null ? this.userName : userName.value,
      password: password == null ? this.password : password.value,
      adminTrainees: adminTrainees == null ? this.adminTrainees : adminTrainees.value,
      adminTasks: adminTasks == null ? this.adminTasks : adminTasks.value,
      adminRecipes: adminRecipes == null ? this.adminRecipes : adminRecipes.value,
      adminNotifs: adminNotifs == null ? this.adminNotifs : adminNotifs.value,
      adminTaNo: adminTaNo == null ? this.adminTaNo : adminTaNo.value,
      adminTrNo: adminTrNo == null ? this.adminTrNo : adminTrNo.value
    );
  }
  
  Admin.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userName = json['userName'],
      _password = json['password'],
      _adminTrainees = json['adminTrainees'] is List
        ? (json['adminTrainees'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Trainee.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _adminTasks = json['adminTasks'] is List
        ? (json['adminTasks'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Task.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _adminRecipes = json['adminRecipes'] is List
        ? (json['adminRecipes'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Recipe.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _adminNotifs = json['adminNotifs'] is List
        ? (json['adminNotifs'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Notifications.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _adminTaNo = json['adminTaNo'] is List
        ? (json['adminTaNo'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => TaskNotes.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _adminTrNo = json['adminTrNo'] is List
        ? (json['adminTrNo'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => TraineeNotes.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userName': _userName, 'password': _password, 'adminTrainees': _adminTrainees?.map((Trainee? e) => e?.toJson()).toList(), 'adminTasks': _adminTasks?.map((Task? e) => e?.toJson()).toList(), 'adminRecipes': _adminRecipes?.map((Recipe? e) => e?.toJson()).toList(), 'adminNotifs': _adminNotifs?.map((Notifications? e) => e?.toJson()).toList(), 'adminTaNo': _adminTaNo?.map((TaskNotes? e) => e?.toJson()).toList(), 'adminTrNo': _adminTrNo?.map((TraineeNotes? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'userName': _userName,
    'password': _password,
    'adminTrainees': _adminTrainees,
    'adminTasks': _adminTasks,
    'adminRecipes': _adminRecipes,
    'adminNotifs': _adminNotifs,
    'adminTaNo': _adminTaNo,
    'adminTrNo': _adminTrNo,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<AdminModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<AdminModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final USERNAME = amplify_core.QueryField(fieldName: "userName");
  static final PASSWORD = amplify_core.QueryField(fieldName: "password");
  static final ADMINTRAINEES = amplify_core.QueryField(
    fieldName: "adminTrainees",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Trainee'));
  static final ADMINTASKS = amplify_core.QueryField(
    fieldName: "adminTasks",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Task'));
  static final ADMINRECIPES = amplify_core.QueryField(
    fieldName: "adminRecipes",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Recipe'));
  static final ADMINNOTIFS = amplify_core.QueryField(
    fieldName: "adminNotifs",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Notifications'));
  static final ADMINTANO = amplify_core.QueryField(
    fieldName: "adminTaNo",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TaskNotes'));
  static final ADMINTRNO = amplify_core.QueryField(
    fieldName: "adminTrNo",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TraineeNotes'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Admin";
    modelSchemaDefinition.pluralName = "Admins";
    
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
      key: Admin.USERNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Admin.PASSWORD,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Admin.ADMINTRAINEES,
      isRequired: false,
      ofModelName: 'Trainee',
      associatedKey: Trainee.ADMINID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Admin.ADMINTASKS,
      isRequired: false,
      ofModelName: 'Task',
      associatedKey: Task.ADMINID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Admin.ADMINRECIPES,
      isRequired: false,
      ofModelName: 'Recipe',
      associatedKey: Recipe.ADMINID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Admin.ADMINNOTIFS,
      isRequired: false,
      ofModelName: 'Notifications',
      associatedKey: Notifications.ADMINID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Admin.ADMINTANO,
      isRequired: false,
      ofModelName: 'TaskNotes',
      associatedKey: TaskNotes.ADMINID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Admin.ADMINTRNO,
      isRequired: false,
      ofModelName: 'TraineeNotes',
      associatedKey: TraineeNotes.ADMINID
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

class _AdminModelType extends amplify_core.ModelType<Admin> {
  const _AdminModelType();
  
  @override
  Admin fromJson(Map<String, dynamic> jsonData) {
    return Admin.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Admin';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Admin] in your schema.
 */
class AdminModelIdentifier implements amplify_core.ModelIdentifier<Admin> {
  final String id;

  /** Create an instance of AdminModelIdentifier using [id] the primary key. */
  const AdminModelIdentifier({
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
  String toString() => 'AdminModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is AdminModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}