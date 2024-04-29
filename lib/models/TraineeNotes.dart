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


/** This is an auto generated class representing the TraineeNotes type in your schema. */
class TraineeNotes extends amplify_core.Model {
  static const classType = const _TraineeNotesModelType();
  final String id;
  final String? _noteTitle;
  final String? _noteDesc;
  final String? _supportID;
  final String? _adminID;
  final Trainee? _traineeNotesTrainee;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TraineeNotesModelIdentifier get modelIdentifier {
      return TraineeNotesModelIdentifier(
        id: id
      );
  }
  
  String? get noteTitle {
    return _noteTitle;
  }
  
  String? get noteDesc {
    return _noteDesc;
  }
  
  String? get supportID {
    return _supportID;
  }
  
  String? get adminID {
    return _adminID;
  }
  
  Trainee? get traineeNotesTrainee {
    return _traineeNotesTrainee;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const TraineeNotes._internal({required this.id, noteTitle, noteDesc, supportID, adminID, traineeNotesTrainee, createdAt, updatedAt}): _noteTitle = noteTitle, _noteDesc = noteDesc, _supportID = supportID, _adminID = adminID, _traineeNotesTrainee = traineeNotesTrainee, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory TraineeNotes({String? id, String? noteTitle, String? noteDesc, String? supportID, String? adminID, Trainee? traineeNotesTrainee}) {
    return TraineeNotes._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      noteTitle: noteTitle,
      noteDesc: noteDesc,
      supportID: supportID,
      adminID: adminID,
      traineeNotesTrainee: traineeNotesTrainee);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TraineeNotes &&
      id == other.id &&
      _noteTitle == other._noteTitle &&
      _noteDesc == other._noteDesc &&
      _supportID == other._supportID &&
      _adminID == other._adminID &&
      _traineeNotesTrainee == other._traineeNotesTrainee;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("TraineeNotes {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("noteTitle=" + "$_noteTitle" + ", ");
    buffer.write("noteDesc=" + "$_noteDesc" + ", ");
    buffer.write("supportID=" + "$_supportID" + ", ");
    buffer.write("adminID=" + "$_adminID" + ", ");
    buffer.write("traineeNotesTrainee=" + (_traineeNotesTrainee != null ? _traineeNotesTrainee!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  TraineeNotes copyWith({String? noteTitle, String? noteDesc, String? supportID, String? adminID, Trainee? traineeNotesTrainee}) {
    return TraineeNotes._internal(
      id: id,
      noteTitle: noteTitle ?? this.noteTitle,
      noteDesc: noteDesc ?? this.noteDesc,
      supportID: supportID ?? this.supportID,
      adminID: adminID ?? this.adminID,
      traineeNotesTrainee: traineeNotesTrainee ?? this.traineeNotesTrainee);
  }
  
  TraineeNotes copyWithModelFieldValues({
    ModelFieldValue<String?>? noteTitle,
    ModelFieldValue<String?>? noteDesc,
    ModelFieldValue<String?>? supportID,
    ModelFieldValue<String?>? adminID,
    ModelFieldValue<Trainee?>? traineeNotesTrainee
  }) {
    return TraineeNotes._internal(
      id: id,
      noteTitle: noteTitle == null ? this.noteTitle : noteTitle.value,
      noteDesc: noteDesc == null ? this.noteDesc : noteDesc.value,
      supportID: supportID == null ? this.supportID : supportID.value,
      adminID: adminID == null ? this.adminID : adminID.value,
      traineeNotesTrainee: traineeNotesTrainee == null ? this.traineeNotesTrainee : traineeNotesTrainee.value
    );
  }
  
  TraineeNotes.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _noteTitle = json['noteTitle'],
      _noteDesc = json['noteDesc'],
      _supportID = json['supportID'],
      _adminID = json['adminID'],
      _traineeNotesTrainee = json['traineeNotesTrainee']?['serializedData'] != null
        ? Trainee.fromJson(new Map<String, dynamic>.from(json['traineeNotesTrainee']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'noteTitle': _noteTitle, 'noteDesc': _noteDesc, 'supportID': _supportID, 'adminID': _adminID, 'traineeNotesTrainee': _traineeNotesTrainee?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'noteTitle': _noteTitle,
    'noteDesc': _noteDesc,
    'supportID': _supportID,
    'adminID': _adminID,
    'traineeNotesTrainee': _traineeNotesTrainee,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<TraineeNotesModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<TraineeNotesModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NOTETITLE = amplify_core.QueryField(fieldName: "noteTitle");
  static final NOTEDESC = amplify_core.QueryField(fieldName: "noteDesc");
  static final SUPPORTID = amplify_core.QueryField(fieldName: "supportID");
  static final ADMINID = amplify_core.QueryField(fieldName: "adminID");
  static final TRAINEENOTESTRAINEE = amplify_core.QueryField(
    fieldName: "traineeNotesTrainee",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Trainee'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TraineeNotes";
    modelSchemaDefinition.pluralName = "TraineeNotes";
    
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
      amplify_core.ModelIndex(fields: const ["adminID"], name: "byAdmin")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TraineeNotes.NOTETITLE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TraineeNotes.NOTEDESC,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TraineeNotes.SUPPORTID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TraineeNotes.ADMINID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: TraineeNotes.TRAINEENOTESTRAINEE,
      isRequired: false,
      targetNames: ['traineeNotesTraineeNotesTraineeId'],
      ofModelName: 'Trainee'
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

class _TraineeNotesModelType extends amplify_core.ModelType<TraineeNotes> {
  const _TraineeNotesModelType();
  
  @override
  TraineeNotes fromJson(Map<String, dynamic> jsonData) {
    return TraineeNotes.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'TraineeNotes';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [TraineeNotes] in your schema.
 */
class TraineeNotesModelIdentifier implements amplify_core.ModelIdentifier<TraineeNotes> {
  final String id;

  /** Create an instance of TraineeNotesModelIdentifier using [id] the primary key. */
  const TraineeNotesModelIdentifier({
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
  String toString() => 'TraineeNotesModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TraineeNotesModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}