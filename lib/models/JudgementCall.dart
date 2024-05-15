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


/** This is an auto generated class representing the JudgementCall type in your schema. */
class JudgementCall extends amplify_core.Model {
  static const classType = const _JudgementCallModelType();
  final String id;
  final String? _traineeID;
  final String? _taskID;
  final String? _call;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  JudgementCallModelIdentifier get modelIdentifier {
      return JudgementCallModelIdentifier(
        id: id
      );
  }
  
  String? get traineeID {
    return _traineeID;
  }
  
  String? get taskID {
    return _taskID;
  }
  
  String? get call {
    return _call;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const JudgementCall._internal({required this.id, traineeID, taskID, call, createdAt, updatedAt}): _traineeID = traineeID, _taskID = taskID, _call = call, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory JudgementCall({String? id, String? traineeID, String? taskID, String? call}) {
    return JudgementCall._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      traineeID: traineeID,
      taskID: taskID,
      call: call);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JudgementCall &&
      id == other.id &&
      _traineeID == other._traineeID &&
      _taskID == other._taskID &&
      _call == other._call;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("JudgementCall {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("traineeID=" + "$_traineeID" + ", ");
    buffer.write("taskID=" + "$_taskID" + ", ");
    buffer.write("call=" + "$_call" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  JudgementCall copyWith({String? traineeID, String? taskID, String? call}) {
    return JudgementCall._internal(
      id: id,
      traineeID: traineeID ?? this.traineeID,
      taskID: taskID ?? this.taskID,
      call: call ?? this.call);
  }
  
  JudgementCall copyWithModelFieldValues({
    ModelFieldValue<String?>? traineeID,
    ModelFieldValue<String?>? taskID,
    ModelFieldValue<String?>? call
  }) {
    return JudgementCall._internal(
      id: id,
      traineeID: traineeID == null ? this.traineeID : traineeID.value,
      taskID: taskID == null ? this.taskID : taskID.value,
      call: call == null ? this.call : call.value
    );
  }
  
  JudgementCall.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _traineeID = json['traineeID'],
      _taskID = json['taskID'],
      _call = json['call'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'traineeID': _traineeID, 'taskID': _taskID, 'call': _call, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'traineeID': _traineeID,
    'taskID': _taskID,
    'call': _call,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<JudgementCallModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<JudgementCallModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TRAINEEID = amplify_core.QueryField(fieldName: "traineeID");
  static final TASKID = amplify_core.QueryField(fieldName: "taskID");
  static final CALL = amplify_core.QueryField(fieldName: "call");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "JudgementCall";
    modelSchemaDefinition.pluralName = "JudgementCalls";
    
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
      key: JudgementCall.TRAINEEID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JudgementCall.TASKID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JudgementCall.CALL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
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

class _JudgementCallModelType extends amplify_core.ModelType<JudgementCall> {
  const _JudgementCallModelType();
  
  @override
  JudgementCall fromJson(Map<String, dynamic> jsonData) {
    return JudgementCall.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'JudgementCall';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [JudgementCall] in your schema.
 */
class JudgementCallModelIdentifier implements amplify_core.ModelIdentifier<JudgementCall> {
  final String id;

  /** Create an instance of JudgementCallModelIdentifier using [id] the primary key. */
  const JudgementCallModelIdentifier({
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
  String toString() => 'JudgementCallModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is JudgementCallModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}