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


/** This is an auto generated class representing the CurrTask type in your schema. */
class CurrTask extends amplify_core.Model {
  static const classType = const _CurrTaskModelType();
  final String id;
  final String? _taskFeeling;
  final String? _taskPassed;
  final String? _taskProgress;
  final String? _taskSteps;
  final String? _currTaskName;
  final TaskNotes? _currTaskTaNo;
  final Support? _currTaskSupp;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _currTaskCurrTaskTaNoId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  CurrTaskModelIdentifier get modelIdentifier {
      return CurrTaskModelIdentifier(
        id: id
      );
  }
  
  String? get taskFeeling {
    return _taskFeeling;
  }
  
  String? get taskPassed {
    return _taskPassed;
  }
  
  String? get taskProgress {
    return _taskProgress;
  }
  
  String? get taskSteps {
    return _taskSteps;
  }
  
  String? get currTaskName {
    return _currTaskName;
  }
  
  TaskNotes? get currTaskTaNo {
    return _currTaskTaNo;
  }
  
  Support? get currTaskSupp {
    return _currTaskSupp;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get currTaskCurrTaskTaNoId {
    return _currTaskCurrTaskTaNoId;
  }
  
  const CurrTask._internal({required this.id, taskFeeling, taskPassed, taskProgress, taskSteps, currTaskName, currTaskTaNo, currTaskSupp, createdAt, updatedAt, currTaskCurrTaskTaNoId}): _taskFeeling = taskFeeling, _taskPassed = taskPassed, _taskProgress = taskProgress, _taskSteps = taskSteps, _currTaskName = currTaskName, _currTaskTaNo = currTaskTaNo, _currTaskSupp = currTaskSupp, _createdAt = createdAt, _updatedAt = updatedAt, _currTaskCurrTaskTaNoId = currTaskCurrTaskTaNoId;
  
  factory CurrTask({String? id, String? taskFeeling, String? taskPassed, String? taskProgress, String? taskSteps, String? currTaskName, TaskNotes? currTaskTaNo, Support? currTaskSupp, String? currTaskCurrTaskTaNoId}) {
    return CurrTask._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      taskFeeling: taskFeeling,
      taskPassed: taskPassed,
      taskProgress: taskProgress,
      taskSteps: taskSteps,
      currTaskName: currTaskName,
      currTaskTaNo: currTaskTaNo,
      currTaskSupp: currTaskSupp,
      currTaskCurrTaskTaNoId: currTaskCurrTaskTaNoId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrTask &&
      id == other.id &&
      _taskFeeling == other._taskFeeling &&
      _taskPassed == other._taskPassed &&
      _taskProgress == other._taskProgress &&
      _taskSteps == other._taskSteps &&
      _currTaskName == other._currTaskName &&
      _currTaskTaNo == other._currTaskTaNo &&
      _currTaskSupp == other._currTaskSupp &&
      _currTaskCurrTaskTaNoId == other._currTaskCurrTaskTaNoId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CurrTask {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("taskFeeling=" + "$_taskFeeling" + ", ");
    buffer.write("taskPassed=" + "$_taskPassed" + ", ");
    buffer.write("taskProgress=" + "$_taskProgress" + ", ");
    buffer.write("taskSteps=" + "$_taskSteps" + ", ");
    buffer.write("currTaskName=" + "$_currTaskName" + ", ");
    buffer.write("currTaskSupp=" + (_currTaskSupp != null ? _currTaskSupp!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("currTaskCurrTaskTaNoId=" + "$_currTaskCurrTaskTaNoId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CurrTask copyWith({String? taskFeeling, String? taskPassed, String? taskProgress, String? taskSteps, String? currTaskName, TaskNotes? currTaskTaNo, Support? currTaskSupp, String? currTaskCurrTaskTaNoId}) {
    return CurrTask._internal(
      id: id,
      taskFeeling: taskFeeling ?? this.taskFeeling,
      taskPassed: taskPassed ?? this.taskPassed,
      taskProgress: taskProgress ?? this.taskProgress,
      taskSteps: taskSteps ?? this.taskSteps,
      currTaskName: currTaskName ?? this.currTaskName,
      currTaskTaNo: currTaskTaNo ?? this.currTaskTaNo,
      currTaskSupp: currTaskSupp ?? this.currTaskSupp,
      currTaskCurrTaskTaNoId: currTaskCurrTaskTaNoId ?? this.currTaskCurrTaskTaNoId);
  }
  
  CurrTask copyWithModelFieldValues({
    ModelFieldValue<String?>? taskFeeling,
    ModelFieldValue<String?>? taskPassed,
    ModelFieldValue<String?>? taskProgress,
    ModelFieldValue<String?>? taskSteps,
    ModelFieldValue<String?>? currTaskName,
    ModelFieldValue<TaskNotes?>? currTaskTaNo,
    ModelFieldValue<Support?>? currTaskSupp,
    ModelFieldValue<String?>? currTaskCurrTaskTaNoId
  }) {
    return CurrTask._internal(
      id: id,
      taskFeeling: taskFeeling == null ? this.taskFeeling : taskFeeling.value,
      taskPassed: taskPassed == null ? this.taskPassed : taskPassed.value,
      taskProgress: taskProgress == null ? this.taskProgress : taskProgress.value,
      taskSteps: taskSteps == null ? this.taskSteps : taskSteps.value,
      currTaskName: currTaskName == null ? this.currTaskName : currTaskName.value,
      currTaskTaNo: currTaskTaNo == null ? this.currTaskTaNo : currTaskTaNo.value,
      currTaskSupp: currTaskSupp == null ? this.currTaskSupp : currTaskSupp.value,
      currTaskCurrTaskTaNoId: currTaskCurrTaskTaNoId == null ? this.currTaskCurrTaskTaNoId : currTaskCurrTaskTaNoId.value
    );
  }
  
  CurrTask.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _taskFeeling = json['taskFeeling'],
      _taskPassed = json['taskPassed'],
      _taskProgress = json['taskProgress'],
      _taskSteps = json['taskSteps'],
      _currTaskName = json['currTaskName'],
      _currTaskTaNo = json['currTaskTaNo']?['serializedData'] != null
        ? TaskNotes.fromJson(new Map<String, dynamic>.from(json['currTaskTaNo']['serializedData']))
        : null,
      _currTaskSupp = json['currTaskSupp']?['serializedData'] != null
        ? Support.fromJson(new Map<String, dynamic>.from(json['currTaskSupp']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _currTaskCurrTaskTaNoId = json['currTaskCurrTaskTaNoId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'taskFeeling': _taskFeeling, 'taskPassed': _taskPassed, 'taskProgress': _taskProgress, 'taskSteps': _taskSteps, 'currTaskName': _currTaskName, 'currTaskTaNo': _currTaskTaNo?.toJson(), 'currTaskSupp': _currTaskSupp?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'currTaskCurrTaskTaNoId': _currTaskCurrTaskTaNoId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'taskFeeling': _taskFeeling,
    'taskPassed': _taskPassed,
    'taskProgress': _taskProgress,
    'taskSteps': _taskSteps,
    'currTaskName': _currTaskName,
    'currTaskTaNo': _currTaskTaNo,
    'currTaskSupp': _currTaskSupp,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'currTaskCurrTaskTaNoId': _currTaskCurrTaskTaNoId
  };

  static final amplify_core.QueryModelIdentifier<CurrTaskModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<CurrTaskModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TASKFEELING = amplify_core.QueryField(fieldName: "taskFeeling");
  static final TASKPASSED = amplify_core.QueryField(fieldName: "taskPassed");
  static final TASKPROGRESS = amplify_core.QueryField(fieldName: "taskProgress");
  static final TASKSTEPS = amplify_core.QueryField(fieldName: "taskSteps");
  static final CURRTASKNAME = amplify_core.QueryField(fieldName: "currTaskName");
  static final CURRTASKTANO = amplify_core.QueryField(
    fieldName: "currTaskTaNo",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TaskNotes'));
  static final CURRTASKSUPP = amplify_core.QueryField(
    fieldName: "currTaskSupp",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Support'));
  static final CURRTASKCURRTASKTANOID = amplify_core.QueryField(fieldName: "currTaskCurrTaskTaNoId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CurrTask";
    modelSchemaDefinition.pluralName = "CurrTasks";
    
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
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["supportID"], name: "bySupport")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.TASKFEELING,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.TASKPASSED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.TASKPROGRESS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.TASKSTEPS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.CURRTASKNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: CurrTask.CURRTASKTANO,
      isRequired: false,
      ofModelName: 'TaskNotes',
      associatedKey: TaskNotes.ID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: CurrTask.CURRTASKSUPP,
      isRequired: false,
      targetNames: ['supportID'],
      ofModelName: 'Support'
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.CURRTASKCURRTASKTANOID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}

class _CurrTaskModelType extends amplify_core.ModelType<CurrTask> {
  const _CurrTaskModelType();
  
  @override
  CurrTask fromJson(Map<String, dynamic> jsonData) {
    return CurrTask.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'CurrTask';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [CurrTask] in your schema.
 */
class CurrTaskModelIdentifier implements amplify_core.ModelIdentifier<CurrTask> {
  final String id;

  /** Create an instance of CurrTaskModelIdentifier using [id] the primary key. */
  const CurrTaskModelIdentifier({
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
  String toString() => 'CurrTaskModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is CurrTaskModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}