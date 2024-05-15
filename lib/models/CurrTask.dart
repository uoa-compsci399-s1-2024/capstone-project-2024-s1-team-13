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


/** This is an auto generated class representing the CurrTask type in your schema. */
class CurrTask extends amplify_core.Model {
  static const classType = const _CurrTaskModelType();
  final String id;
  final String? _taskFeeling;
  final String? _taskPassed;
  final String? _taskProgress;
  final List<String>? _taskSteps;
  final String? _currTaskName;
  final List<TaskNotes>? _currTaskTaNo;
  final Support? _currTaskSupp;
  final int? _checkedStepsCount;
  final int? _timesEvaluated;
  final Trainee? _traineeCurrTask;
  final List<String>? _taskStepImage;
  final String? _taskCoverImage;
  final String? _traineeID;
  final List<Sess>? _sessionList;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

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
  
  List<String>? get taskSteps {
    return _taskSteps;
  }
  
  String? get currTaskName {
    return _currTaskName;
  }
  
  List<TaskNotes>? get currTaskTaNo {
    return _currTaskTaNo;
  }
  
  Support? get currTaskSupp {
    return _currTaskSupp;
  }
  
  int? get checkedStepsCount {
    return _checkedStepsCount;
  }
  
  int? get timesEvaluated {
    return _timesEvaluated;
  }
  
  Trainee? get traineeCurrTask {
    return _traineeCurrTask;
  }
  
  List<String>? get taskStepImage {
    return _taskStepImage;
  }
  
  String? get taskCoverImage {
    return _taskCoverImage;
  }
  
  String? get traineeID {
    return _traineeID;
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
  
  const CurrTask._internal({required this.id, taskFeeling, taskPassed, taskProgress, taskSteps, currTaskName, currTaskTaNo, currTaskSupp, checkedStepsCount, timesEvaluated, traineeCurrTask, taskStepImage, taskCoverImage, traineeID, sessionList, createdAt, updatedAt}): _taskFeeling = taskFeeling, _taskPassed = taskPassed, _taskProgress = taskProgress, _taskSteps = taskSteps, _currTaskName = currTaskName, _currTaskTaNo = currTaskTaNo, _currTaskSupp = currTaskSupp, _checkedStepsCount = checkedStepsCount, _timesEvaluated = timesEvaluated, _traineeCurrTask = traineeCurrTask, _taskStepImage = taskStepImage, _taskCoverImage = taskCoverImage, _traineeID = traineeID, _sessionList = sessionList, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory CurrTask({String? id, String? taskFeeling, String? taskPassed, String? taskProgress, List<String>? taskSteps, String? currTaskName, List<TaskNotes>? currTaskTaNo, Support? currTaskSupp, int? checkedStepsCount, int? timesEvaluated, Trainee? traineeCurrTask, List<String>? taskStepImage, String? taskCoverImage, String? traineeID, List<Sess>? sessionList}) {
    return CurrTask._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      taskFeeling: taskFeeling,
      taskPassed: taskPassed,
      taskProgress: taskProgress,
      taskSteps: taskSteps != null ? List<String>.unmodifiable(taskSteps) : taskSteps,
      currTaskName: currTaskName,
      currTaskTaNo: currTaskTaNo != null ? List<TaskNotes>.unmodifiable(currTaskTaNo) : currTaskTaNo,
      currTaskSupp: currTaskSupp,
      checkedStepsCount: checkedStepsCount,
      timesEvaluated: timesEvaluated,
      traineeCurrTask: traineeCurrTask,
      taskStepImage: taskStepImage != null ? List<String>.unmodifiable(taskStepImage) : taskStepImage,
      taskCoverImage: taskCoverImage,
      traineeID: traineeID,
      sessionList: sessionList != null ? List<Sess>.unmodifiable(sessionList) : sessionList);
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
      DeepCollectionEquality().equals(_taskSteps, other._taskSteps) &&
      _currTaskName == other._currTaskName &&
      DeepCollectionEquality().equals(_currTaskTaNo, other._currTaskTaNo) &&
      _currTaskSupp == other._currTaskSupp &&
      _checkedStepsCount == other._checkedStepsCount &&
      _timesEvaluated == other._timesEvaluated &&
      _traineeCurrTask == other._traineeCurrTask &&
      DeepCollectionEquality().equals(_taskStepImage, other._taskStepImage) &&
      _taskCoverImage == other._taskCoverImage &&
      _traineeID == other._traineeID &&
      DeepCollectionEquality().equals(_sessionList, other._sessionList);
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
    buffer.write("taskSteps=" + (_taskSteps != null ? _taskSteps!.toString() : "null") + ", ");
    buffer.write("currTaskName=" + "$_currTaskName" + ", ");
    buffer.write("currTaskSupp=" + (_currTaskSupp != null ? _currTaskSupp!.toString() : "null") + ", ");
    buffer.write("checkedStepsCount=" + (_checkedStepsCount != null ? _checkedStepsCount!.toString() : "null") + ", ");
    buffer.write("timesEvaluated=" + (_timesEvaluated != null ? _timesEvaluated!.toString() : "null") + ", ");
    buffer.write("traineeCurrTask=" + (_traineeCurrTask != null ? _traineeCurrTask!.toString() : "null") + ", ");
    buffer.write("taskStepImage=" + (_taskStepImage != null ? _taskStepImage!.toString() : "null") + ", ");
    buffer.write("taskCoverImage=" + "$_taskCoverImage" + ", ");
    buffer.write("traineeID=" + "$_traineeID" + ", ");
    buffer.write("sessionList=" + (_sessionList != null ? _sessionList!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CurrTask copyWith({String? taskFeeling, String? taskPassed, String? taskProgress, List<String>? taskSteps, String? currTaskName, List<TaskNotes>? currTaskTaNo, Support? currTaskSupp, int? checkedStepsCount, int? timesEvaluated, Trainee? traineeCurrTask, List<String>? taskStepImage, String? taskCoverImage, String? traineeID, List<Sess>? sessionList}) {
    return CurrTask._internal(
      id: id,
      taskFeeling: taskFeeling ?? this.taskFeeling,
      taskPassed: taskPassed ?? this.taskPassed,
      taskProgress: taskProgress ?? this.taskProgress,
      taskSteps: taskSteps ?? this.taskSteps,
      currTaskName: currTaskName ?? this.currTaskName,
      currTaskTaNo: currTaskTaNo ?? this.currTaskTaNo,
      currTaskSupp: currTaskSupp ?? this.currTaskSupp,
      checkedStepsCount: checkedStepsCount ?? this.checkedStepsCount,
      timesEvaluated: timesEvaluated ?? this.timesEvaluated,
      traineeCurrTask: traineeCurrTask ?? this.traineeCurrTask,
      taskStepImage: taskStepImage ?? this.taskStepImage,
      taskCoverImage: taskCoverImage ?? this.taskCoverImage,
      traineeID: traineeID ?? this.traineeID,
      sessionList: sessionList ?? this.sessionList);
  }
  
  CurrTask copyWithModelFieldValues({
    ModelFieldValue<String?>? taskFeeling,
    ModelFieldValue<String?>? taskPassed,
    ModelFieldValue<String?>? taskProgress,
    ModelFieldValue<List<String>?>? taskSteps,
    ModelFieldValue<String?>? currTaskName,
    ModelFieldValue<List<TaskNotes>?>? currTaskTaNo,
    ModelFieldValue<Support?>? currTaskSupp,
    ModelFieldValue<int?>? checkedStepsCount,
    ModelFieldValue<int?>? timesEvaluated,
    ModelFieldValue<Trainee?>? traineeCurrTask,
    ModelFieldValue<List<String>?>? taskStepImage,
    ModelFieldValue<String?>? taskCoverImage,
    ModelFieldValue<String?>? traineeID,
    ModelFieldValue<List<Sess>?>? sessionList
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
      checkedStepsCount: checkedStepsCount == null ? this.checkedStepsCount : checkedStepsCount.value,
      timesEvaluated: timesEvaluated == null ? this.timesEvaluated : timesEvaluated.value,
      traineeCurrTask: traineeCurrTask == null ? this.traineeCurrTask : traineeCurrTask.value,
      taskStepImage: taskStepImage == null ? this.taskStepImage : taskStepImage.value,
      taskCoverImage: taskCoverImage == null ? this.taskCoverImage : taskCoverImage.value,
      traineeID: traineeID == null ? this.traineeID : traineeID.value,
      sessionList: sessionList == null ? this.sessionList : sessionList.value
    );
  }
  
  CurrTask.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _taskFeeling = json['taskFeeling'],
      _taskPassed = json['taskPassed'],
      _taskProgress = json['taskProgress'],
      _taskSteps = json['taskSteps']?.cast<String>(),
      _currTaskName = json['currTaskName'],
      _currTaskTaNo = json['currTaskTaNo'] is List
        ? (json['currTaskTaNo'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => TaskNotes.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _currTaskSupp = json['currTaskSupp']?['serializedData'] != null
        ? Support.fromJson(new Map<String, dynamic>.from(json['currTaskSupp']['serializedData']))
        : null,
      _checkedStepsCount = (json['checkedStepsCount'] as num?)?.toInt(),
      _timesEvaluated = (json['timesEvaluated'] as num?)?.toInt(),
      _traineeCurrTask = json['traineeCurrTask']?['serializedData'] != null
        ? Trainee.fromJson(new Map<String, dynamic>.from(json['traineeCurrTask']['serializedData']))
        : null,
      _taskStepImage = json['taskStepImage']?.cast<String>(),
      _taskCoverImage = json['taskCoverImage'],
      _traineeID = json['traineeID'],
      _sessionList = json['sessionList'] is List
        ? (json['sessionList'] as List)
          .where((e) => e != null)
          .map((e) => Sess.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'taskFeeling': _taskFeeling, 'taskPassed': _taskPassed, 'taskProgress': _taskProgress, 'taskSteps': _taskSteps, 'currTaskName': _currTaskName, 'currTaskTaNo': _currTaskTaNo?.map((TaskNotes? e) => e?.toJson()).toList(), 'currTaskSupp': _currTaskSupp?.toJson(), 'checkedStepsCount': _checkedStepsCount, 'timesEvaluated': _timesEvaluated, 'traineeCurrTask': _traineeCurrTask?.toJson(), 'taskStepImage': _taskStepImage, 'taskCoverImage': _taskCoverImage, 'traineeID': _traineeID, 'sessionList': _sessionList?.map((Sess? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
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
    'checkedStepsCount': _checkedStepsCount,
    'timesEvaluated': _timesEvaluated,
    'traineeCurrTask': _traineeCurrTask,
    'taskStepImage': _taskStepImage,
    'taskCoverImage': _taskCoverImage,
    'traineeID': _traineeID,
    'sessionList': _sessionList,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
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
  static final CHECKEDSTEPSCOUNT = amplify_core.QueryField(fieldName: "checkedStepsCount");
  static final TIMESEVALUATED = amplify_core.QueryField(fieldName: "timesEvaluated");
  static final TRAINEECURRTASK = amplify_core.QueryField(
    fieldName: "traineeCurrTask",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Trainee'));
  static final TASKSTEPIMAGE = amplify_core.QueryField(fieldName: "taskStepImage");
  static final TASKCOVERIMAGE = amplify_core.QueryField(fieldName: "taskCoverImage");
  static final TRAINEEID = amplify_core.QueryField(fieldName: "traineeID");
  static final SESSIONLIST = amplify_core.QueryField(fieldName: "sessionList");
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
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.CURRTASKNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: CurrTask.CURRTASKTANO,
      isRequired: false,
      ofModelName: 'TaskNotes',
      associatedKey: TaskNotes.CURRTASKID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: CurrTask.CURRTASKSUPP,
      isRequired: false,
      targetNames: ['supportID'],
      ofModelName: 'Support'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.CHECKEDSTEPSCOUNT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.TIMESEVALUATED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: CurrTask.TRAINEECURRTASK,
      isRequired: false,
      targetNames: ['currTaskTraineeCurrTaskId'],
      ofModelName: 'Trainee'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.TASKSTEPIMAGE,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.TASKCOVERIMAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CurrTask.TRAINEEID,
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