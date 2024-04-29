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


/** This is an auto generated class representing the Task type in your schema. */
class Task extends amplify_core.Model {
  static const classType = const _TaskModelType();
  final String id;
  final String? _taskTitle;
  final List<String>? _taskStep;
  final String? _adminID;
  final List<String>? _taskStepImage;
  final String? _taskCoverImage;
  final List<TaskNotes>? _taskTaskNotes;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TaskModelIdentifier get modelIdentifier {
      return TaskModelIdentifier(
        id: id
      );
  }
  
  String? get taskTitle {
    return _taskTitle;
  }
  
  List<String>? get taskStep {
    return _taskStep;
  }
  
  String get adminID {
    try {
      return _adminID!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String>? get taskStepImage {
    return _taskStepImage;
  }
  
  String? get taskCoverImage {
    return _taskCoverImage;
  }
  
  List<TaskNotes>? get taskTaskNotes {
    return _taskTaskNotes;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Task._internal({required this.id, taskTitle, taskStep, required adminID, taskStepImage, taskCoverImage, taskTaskNotes, createdAt, updatedAt}): _taskTitle = taskTitle, _taskStep = taskStep, _adminID = adminID, _taskStepImage = taskStepImage, _taskCoverImage = taskCoverImage, _taskTaskNotes = taskTaskNotes, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Task({String? id, String? taskTitle, List<String>? taskStep, required String adminID, List<String>? taskStepImage, String? taskCoverImage, List<TaskNotes>? taskTaskNotes}) {
    return Task._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      taskTitle: taskTitle,
      taskStep: taskStep != null ? List<String>.unmodifiable(taskStep) : taskStep,
      adminID: adminID,
      taskStepImage: taskStepImage != null ? List<String>.unmodifiable(taskStepImage) : taskStepImage,
      taskCoverImage: taskCoverImage,
      taskTaskNotes: taskTaskNotes != null ? List<TaskNotes>.unmodifiable(taskTaskNotes) : taskTaskNotes);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Task &&
      id == other.id &&
      _taskTitle == other._taskTitle &&
      DeepCollectionEquality().equals(_taskStep, other._taskStep) &&
      _adminID == other._adminID &&
      DeepCollectionEquality().equals(_taskStepImage, other._taskStepImage) &&
      _taskCoverImage == other._taskCoverImage &&
      DeepCollectionEquality().equals(_taskTaskNotes, other._taskTaskNotes);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Task {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("taskTitle=" + "$_taskTitle" + ", ");
    buffer.write("taskStep=" + (_taskStep != null ? _taskStep!.toString() : "null") + ", ");
    buffer.write("adminID=" + "$_adminID" + ", ");
    buffer.write("taskStepImage=" + (_taskStepImage != null ? _taskStepImage!.toString() : "null") + ", ");
    buffer.write("taskCoverImage=" + "$_taskCoverImage" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Task copyWith({String? taskTitle, List<String>? taskStep, String? adminID, List<String>? taskStepImage, String? taskCoverImage, List<TaskNotes>? taskTaskNotes}) {
    return Task._internal(
      id: id,
      taskTitle: taskTitle ?? this.taskTitle,
      taskStep: taskStep ?? this.taskStep,
      adminID: adminID ?? this.adminID,
      taskStepImage: taskStepImage ?? this.taskStepImage,
      taskCoverImage: taskCoverImage ?? this.taskCoverImage,
      taskTaskNotes: taskTaskNotes ?? this.taskTaskNotes);
  }
  
  Task copyWithModelFieldValues({
    ModelFieldValue<String?>? taskTitle,
    ModelFieldValue<List<String>?>? taskStep,
    ModelFieldValue<String>? adminID,
    ModelFieldValue<List<String>?>? taskStepImage,
    ModelFieldValue<String?>? taskCoverImage,
    ModelFieldValue<List<TaskNotes>?>? taskTaskNotes
  }) {
    return Task._internal(
      id: id,
      taskTitle: taskTitle == null ? this.taskTitle : taskTitle.value,
      taskStep: taskStep == null ? this.taskStep : taskStep.value,
      adminID: adminID == null ? this.adminID : adminID.value,
      taskStepImage: taskStepImage == null ? this.taskStepImage : taskStepImage.value,
      taskCoverImage: taskCoverImage == null ? this.taskCoverImage : taskCoverImage.value,
      taskTaskNotes: taskTaskNotes == null ? this.taskTaskNotes : taskTaskNotes.value
    );
  }
  
  Task.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _taskTitle = json['taskTitle'],
      _taskStep = json['taskStep']?.cast<String>(),
      _adminID = json['adminID'],
      _taskStepImage = json['taskStepImage']?.cast<String>(),
      _taskCoverImage = json['taskCoverImage'],
      _taskTaskNotes = json['taskTaskNotes'] is List
        ? (json['taskTaskNotes'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => TaskNotes.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'taskTitle': _taskTitle, 'taskStep': _taskStep, 'adminID': _adminID, 'taskStepImage': _taskStepImage, 'taskCoverImage': _taskCoverImage, 'taskTaskNotes': _taskTaskNotes?.map((TaskNotes? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'taskTitle': _taskTitle,
    'taskStep': _taskStep,
    'adminID': _adminID,
    'taskStepImage': _taskStepImage,
    'taskCoverImage': _taskCoverImage,
    'taskTaskNotes': _taskTaskNotes,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<TaskModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<TaskModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TASKTITLE = amplify_core.QueryField(fieldName: "taskTitle");
  static final TASKSTEP = amplify_core.QueryField(fieldName: "taskStep");
  static final ADMINID = amplify_core.QueryField(fieldName: "adminID");
  static final TASKSTEPIMAGE = amplify_core.QueryField(fieldName: "taskStepImage");
  static final TASKCOVERIMAGE = amplify_core.QueryField(fieldName: "taskCoverImage");
  static final TASKTASKNOTES = amplify_core.QueryField(
    fieldName: "taskTaskNotes",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TaskNotes'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Task";
    modelSchemaDefinition.pluralName = "Tasks";
    
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
      amplify_core.ModelIndex(fields: const ["adminID"], name: "byAdmin")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Task.TASKTITLE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Task.TASKSTEP,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Task.ADMINID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Task.TASKSTEPIMAGE,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Task.TASKCOVERIMAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Task.TASKTASKNOTES,
      isRequired: false,
      ofModelName: 'TaskNotes',
      associatedKey: TaskNotes.TASKID
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

class _TaskModelType extends amplify_core.ModelType<Task> {
  const _TaskModelType();
  
  @override
  Task fromJson(Map<String, dynamic> jsonData) {
    return Task.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Task';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Task] in your schema.
 */
class TaskModelIdentifier implements amplify_core.ModelIdentifier<Task> {
  final String id;

  /** Create an instance of TaskModelIdentifier using [id] the primary key. */
  const TaskModelIdentifier({
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
  String toString() => 'TaskModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TaskModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}