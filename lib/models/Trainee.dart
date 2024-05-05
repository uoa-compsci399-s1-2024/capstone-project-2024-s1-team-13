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


/** This is an auto generated class representing the Trainee type in your schema. */
class Trainee extends amplify_core.Model {
  static const classType = const _TraineeModelType();
  final String id;
  final String? _traineePhoto;
  final String? _firstName;
  final String? _lastName;
  final CurrTask? _traineesCT;
  final TraineeNotes? _traineesTrNo;
  final String? _supportID;
  final String? _adminID;
  final List<TaskNotes>? _TrTaskNotes;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _traineeTraineesCTId;
  final String? _traineeTraineesTrNoId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TraineeModelIdentifier get modelIdentifier {
      return TraineeModelIdentifier(
        id: id
      );
  }
  
  String? get traineePhoto {
    return _traineePhoto;
  }
  
  String? get firstName {
    return _firstName;
  }
  
  String? get lastName {
    return _lastName;
  }
  
  CurrTask? get traineesCT {
    return _traineesCT;
  }
  
  TraineeNotes? get traineesTrNo {
    return _traineesTrNo;
  }
  
  String get supportID {
    try {
      return _supportID!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  List<TaskNotes>? get TrTaskNotes {
    return _TrTaskNotes;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get traineeTraineesCTId {
    return _traineeTraineesCTId;
  }
  
  String? get traineeTraineesTrNoId {
    return _traineeTraineesTrNoId;
  }
  
  const Trainee._internal({required this.id, traineePhoto, firstName, lastName, traineesCT, traineesTrNo, required supportID, required adminID, TrTaskNotes, createdAt, updatedAt, traineeTraineesCTId, traineeTraineesTrNoId}): _traineePhoto = traineePhoto, _firstName = firstName, _lastName = lastName, _traineesCT = traineesCT, _traineesTrNo = traineesTrNo, _supportID = supportID, _adminID = adminID, _TrTaskNotes = TrTaskNotes, _createdAt = createdAt, _updatedAt = updatedAt, _traineeTraineesCTId = traineeTraineesCTId, _traineeTraineesTrNoId = traineeTraineesTrNoId;
  
  factory Trainee({String? id, String? traineePhoto, String? firstName, String? lastName, CurrTask? traineesCT, TraineeNotes? traineesTrNo, required String supportID, required String adminID, List<TaskNotes>? TrTaskNotes, String? traineeTraineesCTId, String? traineeTraineesTrNoId}) {
    return Trainee._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      traineePhoto: traineePhoto,
      firstName: firstName,
      lastName: lastName,
      traineesCT: traineesCT,
      traineesTrNo: traineesTrNo,
      supportID: supportID,
      adminID: adminID,
      TrTaskNotes: TrTaskNotes != null ? List<TaskNotes>.unmodifiable(TrTaskNotes) : TrTaskNotes,
      traineeTraineesCTId: traineeTraineesCTId,
      traineeTraineesTrNoId: traineeTraineesTrNoId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Trainee &&
      id == other.id &&
      _traineePhoto == other._traineePhoto &&
      _firstName == other._firstName &&
      _lastName == other._lastName &&
      _traineesCT == other._traineesCT &&
      _traineesTrNo == other._traineesTrNo &&
      _supportID == other._supportID &&
      _adminID == other._adminID &&
      DeepCollectionEquality().equals(_TrTaskNotes, other._TrTaskNotes) &&
      _traineeTraineesCTId == other._traineeTraineesCTId &&
      _traineeTraineesTrNoId == other._traineeTraineesTrNoId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Trainee {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("traineePhoto=" + "$_traineePhoto" + ", ");
    buffer.write("firstName=" + "$_firstName" + ", ");
    buffer.write("lastName=" + "$_lastName" + ", ");
    buffer.write("supportID=" + "$_supportID" + ", ");
    buffer.write("adminID=" + "$_adminID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("traineeTraineesCTId=" + "$_traineeTraineesCTId" + ", ");
    buffer.write("traineeTraineesTrNoId=" + "$_traineeTraineesTrNoId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Trainee copyWith({String? traineePhoto, String? firstName, String? lastName, CurrTask? traineesCT, TraineeNotes? traineesTrNo, String? supportID, String? adminID, List<TaskNotes>? TrTaskNotes, String? traineeTraineesCTId, String? traineeTraineesTrNoId}) {
    return Trainee._internal(
      id: id,
      traineePhoto: traineePhoto ?? this.traineePhoto,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      traineesCT: traineesCT ?? this.traineesCT,
      traineesTrNo: traineesTrNo ?? this.traineesTrNo,
      supportID: supportID ?? this.supportID,
      adminID: adminID ?? this.adminID,
      TrTaskNotes: TrTaskNotes ?? this.TrTaskNotes,
      traineeTraineesCTId: traineeTraineesCTId ?? this.traineeTraineesCTId,
      traineeTraineesTrNoId: traineeTraineesTrNoId ?? this.traineeTraineesTrNoId);
  }
  
  Trainee copyWithModelFieldValues({
    ModelFieldValue<String?>? traineePhoto,
    ModelFieldValue<String?>? firstName,
    ModelFieldValue<String?>? lastName,
    ModelFieldValue<CurrTask?>? traineesCT,
    ModelFieldValue<TraineeNotes?>? traineesTrNo,
    ModelFieldValue<String>? supportID,
    ModelFieldValue<String>? adminID,
    ModelFieldValue<List<TaskNotes>?>? TrTaskNotes,
    ModelFieldValue<String?>? traineeTraineesCTId,
    ModelFieldValue<String?>? traineeTraineesTrNoId
  }) {
    return Trainee._internal(
      id: id,
      traineePhoto: traineePhoto == null ? this.traineePhoto : traineePhoto.value,
      firstName: firstName == null ? this.firstName : firstName.value,
      lastName: lastName == null ? this.lastName : lastName.value,
      traineesCT: traineesCT == null ? this.traineesCT : traineesCT.value,
      traineesTrNo: traineesTrNo == null ? this.traineesTrNo : traineesTrNo.value,
      supportID: supportID == null ? this.supportID : supportID.value,
      adminID: adminID == null ? this.adminID : adminID.value,
      TrTaskNotes: TrTaskNotes == null ? this.TrTaskNotes : TrTaskNotes.value,
      traineeTraineesCTId: traineeTraineesCTId == null ? this.traineeTraineesCTId : traineeTraineesCTId.value,
      traineeTraineesTrNoId: traineeTraineesTrNoId == null ? this.traineeTraineesTrNoId : traineeTraineesTrNoId.value
    );
  }
  
  Trainee.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _traineePhoto = json['traineePhoto'],
      _firstName = json['firstName'],
      _lastName = json['lastName'],
      _traineesCT = json['traineesCT']?['serializedData'] != null
        ? CurrTask.fromJson(new Map<String, dynamic>.from(json['traineesCT']['serializedData']))
        : null,
      _traineesTrNo = json['traineesTrNo']?['serializedData'] != null
        ? TraineeNotes.fromJson(new Map<String, dynamic>.from(json['traineesTrNo']['serializedData']))
        : null,
      _supportID = json['supportID'],
      _adminID = json['adminID'],
      _TrTaskNotes = json['TrTaskNotes'] is List
        ? (json['TrTaskNotes'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => TaskNotes.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _traineeTraineesCTId = json['traineeTraineesCTId'],
      _traineeTraineesTrNoId = json['traineeTraineesTrNoId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'traineePhoto': _traineePhoto, 'firstName': _firstName, 'lastName': _lastName, 'traineesCT': _traineesCT?.toJson(), 'traineesTrNo': _traineesTrNo?.toJson(), 'supportID': _supportID, 'adminID': _adminID, 'TrTaskNotes': _TrTaskNotes?.map((TaskNotes? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'traineeTraineesCTId': _traineeTraineesCTId, 'traineeTraineesTrNoId': _traineeTraineesTrNoId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'traineePhoto': _traineePhoto,
    'firstName': _firstName,
    'lastName': _lastName,
    'traineesCT': _traineesCT,
    'traineesTrNo': _traineesTrNo,
    'supportID': _supportID,
    'adminID': _adminID,
    'TrTaskNotes': _TrTaskNotes,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'traineeTraineesCTId': _traineeTraineesCTId,
    'traineeTraineesTrNoId': _traineeTraineesTrNoId
  };

  static final amplify_core.QueryModelIdentifier<TraineeModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<TraineeModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TRAINEEPHOTO = amplify_core.QueryField(fieldName: "traineePhoto");
  static final FIRSTNAME = amplify_core.QueryField(fieldName: "firstName");
  static final LASTNAME = amplify_core.QueryField(fieldName: "lastName");
  static final TRAINEESCT = amplify_core.QueryField(
    fieldName: "traineesCT",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'CurrTask'));
  static final TRAINEESTRNO = amplify_core.QueryField(
    fieldName: "traineesTrNo",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TraineeNotes'));
  static final SUPPORTID = amplify_core.QueryField(fieldName: "supportID");
  static final ADMINID = amplify_core.QueryField(fieldName: "adminID");
  static final TRTASKNOTES = amplify_core.QueryField(
    fieldName: "TrTaskNotes",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TaskNotes'));
  static final TRAINEETRAINEESCTID = amplify_core.QueryField(fieldName: "traineeTraineesCTId");
  static final TRAINEETRAINEESTRNOID = amplify_core.QueryField(fieldName: "traineeTraineesTrNoId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Trainee";
    modelSchemaDefinition.pluralName = "Trainees";
    
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
      key: Trainee.TRAINEEPHOTO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Trainee.FIRSTNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Trainee.LASTNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: Trainee.TRAINEESCT,
      isRequired: false,
      ofModelName: 'CurrTask',
      associatedKey: CurrTask.TRAINEECURRTASK
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: Trainee.TRAINEESTRNO,
      isRequired: false,
      ofModelName: 'TraineeNotes',
      associatedKey: TraineeNotes.TRAINEENOTESTRAINEE
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Trainee.SUPPORTID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Trainee.ADMINID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Trainee.TRTASKNOTES,
      isRequired: false,
      ofModelName: 'TaskNotes',
      associatedKey: TaskNotes.TRAINEEID
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
      key: Trainee.TRAINEETRAINEESCTID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Trainee.TRAINEETRAINEESTRNOID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}

class _TraineeModelType extends amplify_core.ModelType<Trainee> {
  const _TraineeModelType();
  
  @override
  Trainee fromJson(Map<String, dynamic> jsonData) {
    return Trainee.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Trainee';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Trainee] in your schema.
 */
class TraineeModelIdentifier implements amplify_core.ModelIdentifier<Trainee> {
  final String id;

  /** Create an instance of TraineeModelIdentifier using [id] the primary key. */
  const TraineeModelIdentifier({
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
  String toString() => 'TraineeModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TraineeModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}