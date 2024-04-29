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


/** This is an auto generated class representing the TaskNotes type in your schema. */
class TaskNotes extends amplify_core.Model {
  static const classType = const _TaskNotesModelType();
  final String id;
  final String? _taskTitle;
  final String? _taskDesc;
  final String? _supportID;
  final String? _adminID;
  final String? _traineeID;
  final String? _taskID;
  final Trainee? _trainee;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TaskNotesModelIdentifier get modelIdentifier {
      return TaskNotesModelIdentifier(
        id: id
      );
  }
  
  String? get taskTitle {
    return _taskTitle;
  }
  
  String? get taskDesc {
    return _taskDesc;
  }
  
  String? get supportID {
    return _supportID;
  }
  
  String? get adminID {
    return _adminID;
  }
  
  String? get traineeID {
    return _traineeID;
  }
  
  String? get taskID {
    return _taskID;
  }
  
  Trainee? get trainee {
    return _trainee;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const TaskNotes._internal({required this.id, taskTitle, taskDesc, supportID, adminID, traineeID, taskID, trainee, createdAt, updatedAt}): _taskTitle = taskTitle, _taskDesc = taskDesc, _supportID = supportID, _adminID = adminID, _traineeID = traineeID, _taskID = taskID, _trainee = trainee, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory TaskNotes({String? id, String? taskTitle, String? taskDesc, String? supportID, String? adminID, String? traineeID, String? taskID, Trainee? trainee}) {
    return TaskNotes._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      taskTitle: taskTitle,
      taskDesc: taskDesc,
      supportID: supportID,
      adminID: adminID,
      traineeID: traineeID,
      taskID: taskID,
      trainee: trainee);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskNotes &&
      id == other.id &&
      _taskTitle == other._taskTitle &&
      _taskDesc == other._taskDesc &&
      _supportID == other._supportID &&
      _adminID == other._adminID &&
      _traineeID == other._traineeID &&
      _taskID == other._taskID &&
      _trainee == other._trainee;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("TaskNotes {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("taskTitle=" + "$_taskTitle" + ", ");
    buffer.write("taskDesc=" + "$_taskDesc" + ", ");
    buffer.write("supportID=" + "$_supportID" + ", ");
    buffer.write("adminID=" + "$_adminID" + ", ");
    buffer.write("traineeID=" + "$_traineeID" + ", ");
    buffer.write("taskID=" + "$_taskID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  TaskNotes copyWith({String? taskTitle, String? taskDesc, String? supportID, String? adminID, String? traineeID, String? taskID, Trainee? trainee}) {
    return TaskNotes._internal(
      id: id,
      taskTitle: taskTitle ?? this.taskTitle,
      taskDesc: taskDesc ?? this.taskDesc,
      supportID: supportID ?? this.supportID,
      adminID: adminID ?? this.adminID,
      traineeID: traineeID ?? this.traineeID,
      taskID: taskID ?? this.taskID,
      trainee: trainee ?? this.trainee);
  }
  
  TaskNotes copyWithModelFieldValues({
    ModelFieldValue<String?>? taskTitle,
    ModelFieldValue<String?>? taskDesc,
    ModelFieldValue<String?>? supportID,
    ModelFieldValue<String?>? adminID,
    ModelFieldValue<String?>? traineeID,
    ModelFieldValue<String?>? taskID,
    ModelFieldValue<Trainee?>? trainee
  }) {
    return TaskNotes._internal(
      id: id,
      taskTitle: taskTitle == null ? this.taskTitle : taskTitle.value,
      taskDesc: taskDesc == null ? this.taskDesc : taskDesc.value,
      supportID: supportID == null ? this.supportID : supportID.value,
      adminID: adminID == null ? this.adminID : adminID.value,
      traineeID: traineeID == null ? this.traineeID : traineeID.value,
      taskID: taskID == null ? this.taskID : taskID.value,
      trainee: trainee == null ? this.trainee : trainee.value
    );
  }
  
  TaskNotes.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _taskTitle = json['taskTitle'],
      _taskDesc = json['taskDesc'],
      _supportID = json['supportID'],
      _adminID = json['adminID'],
      _traineeID = json['traineeID'],
      _taskID = json['taskID'],
      _trainee = json['trainee']?['serializedData'] != null
        ? Trainee.fromJson(new Map<String, dynamic>.from(json['trainee']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'taskTitle': _taskTitle, 'taskDesc': _taskDesc, 'supportID': _supportID, 'adminID': _adminID, 'traineeID': _traineeID, 'taskID': _taskID, 'trainee': _trainee?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'taskTitle': _taskTitle,
    'taskDesc': _taskDesc,
    'supportID': _supportID,
    'adminID': _adminID,
    'traineeID': _traineeID,
    'taskID': _taskID,
    'trainee': _trainee,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<TaskNotesModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<TaskNotesModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TASKTITLE = amplify_core.QueryField(fieldName: "taskTitle");
  static final TASKDESC = amplify_core.QueryField(fieldName: "taskDesc");
  static final SUPPORTID = amplify_core.QueryField(fieldName: "supportID");
  static final ADMINID = amplify_core.QueryField(fieldName: "adminID");
  static final TRAINEEID = amplify_core.QueryField(fieldName: "traineeID");
  static final TASKID = amplify_core.QueryField(fieldName: "taskID");
  static final TRAINEE = amplify_core.QueryField(
    fieldName: "trainee",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Trainee'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TaskNotes";
    modelSchemaDefinition.pluralName = "TaskNotes";
    
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
      amplify_core.ModelIndex(fields: const ["supportID"], name: "bySupport"),
      amplify_core.ModelIndex(fields: const ["adminID"], name: "byAdmin"),
      amplify_core.ModelIndex(fields: const ["traineeID"], name: "byTrainee"),
      amplify_core.ModelIndex(fields: const ["taskID"], name: "byTask")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TaskNotes.TASKTITLE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TaskNotes.TASKDESC,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TaskNotes.SUPPORTID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TaskNotes.ADMINID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TaskNotes.TRAINEEID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TaskNotes.TASKID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: TaskNotes.TRAINEE,
      isRequired: false,
      ofModelName: 'Trainee',
      associatedKey: Trainee.ID
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

class _TaskNotesModelType extends amplify_core.ModelType<TaskNotes> {
  const _TaskNotesModelType();
  
  @override
  TaskNotes fromJson(Map<String, dynamic> jsonData) {
    return TaskNotes.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'TaskNotes';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [TaskNotes] in your schema.
 */
class TaskNotesModelIdentifier implements amplify_core.ModelIdentifier<TaskNotes> {
  final String id;

  /** Create an instance of TaskNotesModelIdentifier using [id] the primary key. */
  const TaskNotesModelIdentifier({
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
  String toString() => 'TaskNotesModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TaskNotesModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}