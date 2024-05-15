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


/** This is an auto generated class representing the Session type in your schema. */
class Session extends amplify_core.Model {
  static const classType = const _SessionModelType();
  final String id;
  final String? _traineeID;
  final String? _taskID;
  final List<Sess>? _sessionList;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  SessionModelIdentifier get modelIdentifier {
      return SessionModelIdentifier(
        id: id
      );
  }
  
  String? get traineeID {
    return _traineeID;
  }
  
  String? get taskID {
    return _taskID;
  }
  
  List<Sess>? get sessionList {
    return _sessionList;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Session._internal({required this.id, traineeID, taskID, sessionList, createdAt, updatedAt}): _traineeID = traineeID, _taskID = taskID, _sessionList = sessionList, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Session({String? id, String? traineeID, String? taskID, List<Sess>? sessionList}) {
    return Session._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      traineeID: traineeID,
      taskID: taskID,
      sessionList: sessionList != null ? List<Sess>.unmodifiable(sessionList) : sessionList);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Session &&
      id == other.id &&
      _traineeID == other._traineeID &&
      _taskID == other._taskID &&
      DeepCollectionEquality().equals(_sessionList, other._sessionList);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Session {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("traineeID=" + "$_traineeID" + ", ");
    buffer.write("taskID=" + "$_taskID" + ", ");
    buffer.write("sessionList=" + (_sessionList != null ? _sessionList!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Session copyWith({String? traineeID, String? taskID, List<Sess>? sessionList}) {
    return Session._internal(
      id: id,
      traineeID: traineeID ?? this.traineeID,
      taskID: taskID ?? this.taskID,
      sessionList: sessionList ?? this.sessionList);
  }
  
  Session copyWithModelFieldValues({
    ModelFieldValue<String?>? traineeID,
    ModelFieldValue<String?>? taskID,
    ModelFieldValue<List<Sess>?>? sessionList
  }) {
    return Session._internal(
      id: id,
      traineeID: traineeID == null ? this.traineeID : traineeID.value,
      taskID: taskID == null ? this.taskID : taskID.value,
      sessionList: sessionList == null ? this.sessionList : sessionList.value
    );
  }
  
  Session.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _traineeID = json['traineeID'],
      _taskID = json['taskID'],
      _sessionList = json['sessionList'] is List
        ? (json['sessionList'] as List)
          .where((e) => e != null)
          .map((e) => Sess.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'traineeID': _traineeID, 'taskID': _taskID, 'sessionList': _sessionList?.map((Sess? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'traineeID': _traineeID,
    'taskID': _taskID,
    'sessionList': _sessionList,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<SessionModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<SessionModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TRAINEEID = amplify_core.QueryField(fieldName: "traineeID");
  static final TASKID = amplify_core.QueryField(fieldName: "taskID");
  static final SESSIONLIST = amplify_core.QueryField(fieldName: "sessionList");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Session";
    modelSchemaDefinition.pluralName = "Sessions";
    
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
      key: Session.TRAINEEID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Session.TASKID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'sessionList',
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Sess')
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

class _SessionModelType extends amplify_core.ModelType<Session> {
  const _SessionModelType();
  
  @override
  Session fromJson(Map<String, dynamic> jsonData) {
    return Session.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Session';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Session] in your schema.
 */
class SessionModelIdentifier implements amplify_core.ModelIdentifier<Session> {
  final String id;

  /** Create an instance of SessionModelIdentifier using [id] the primary key. */
  const SessionModelIdentifier({
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
  String toString() => 'SessionModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is SessionModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}