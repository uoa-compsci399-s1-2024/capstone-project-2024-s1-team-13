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


/** This is an auto generated class representing the Notifications type in your schema. */
class Notifications extends amplify_core.Model {
  static const classType = const _NotificationsModelType();
  final String id;
  final String? _content;
  final amplify_core.TemporalTimestamp? _timestamp;
  final String? _supportID;
  final String? _adminID;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  NotificationsModelIdentifier get modelIdentifier {
      return NotificationsModelIdentifier(
        id: id
      );
  }
  
  String? get content {
    return _content;
  }
  
  amplify_core.TemporalTimestamp? get timestamp {
    return _timestamp;
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
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Notifications._internal({required this.id, content, timestamp, required supportID, required adminID, createdAt, updatedAt}): _content = content, _timestamp = timestamp, _supportID = supportID, _adminID = adminID, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Notifications({String? id, String? content, amplify_core.TemporalTimestamp? timestamp, required String supportID, required String adminID}) {
    return Notifications._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      content: content,
      timestamp: timestamp,
      supportID: supportID,
      adminID: adminID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Notifications &&
      id == other.id &&
      _content == other._content &&
      _timestamp == other._timestamp &&
      _supportID == other._supportID &&
      _adminID == other._adminID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Notifications {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("timestamp=" + (_timestamp != null ? _timestamp!.toString() : "null") + ", ");
    buffer.write("supportID=" + "$_supportID" + ", ");
    buffer.write("adminID=" + "$_adminID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Notifications copyWith({String? content, amplify_core.TemporalTimestamp? timestamp, String? supportID, String? adminID}) {
    return Notifications._internal(
      id: id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      supportID: supportID ?? this.supportID,
      adminID: adminID ?? this.adminID);
  }
  
  Notifications copyWithModelFieldValues({
    ModelFieldValue<String?>? content,
    ModelFieldValue<amplify_core.TemporalTimestamp?>? timestamp,
    ModelFieldValue<String>? supportID,
    ModelFieldValue<String>? adminID
  }) {
    return Notifications._internal(
      id: id,
      content: content == null ? this.content : content.value,
      timestamp: timestamp == null ? this.timestamp : timestamp.value,
      supportID: supportID == null ? this.supportID : supportID.value,
      adminID: adminID == null ? this.adminID : adminID.value
    );
  }
  
  Notifications.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _content = json['content'],
      _timestamp = json['timestamp'] != null ? amplify_core.TemporalTimestamp.fromSeconds(json['timestamp']) : null,
      _supportID = json['supportID'],
      _adminID = json['adminID'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'content': _content, 'timestamp': _timestamp?.toSeconds(), 'supportID': _supportID, 'adminID': _adminID, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'content': _content,
    'timestamp': _timestamp,
    'supportID': _supportID,
    'adminID': _adminID,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<NotificationsModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<NotificationsModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final CONTENT = amplify_core.QueryField(fieldName: "content");
  static final TIMESTAMP = amplify_core.QueryField(fieldName: "timestamp");
  static final SUPPORTID = amplify_core.QueryField(fieldName: "supportID");
  static final ADMINID = amplify_core.QueryField(fieldName: "adminID");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Notifications";
    modelSchemaDefinition.pluralName = "Notifications";
    
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
      key: Notifications.CONTENT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Notifications.TIMESTAMP,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Notifications.SUPPORTID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Notifications.ADMINID,
      isRequired: true,
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

class _NotificationsModelType extends amplify_core.ModelType<Notifications> {
  const _NotificationsModelType();
  
  @override
  Notifications fromJson(Map<String, dynamic> jsonData) {
    return Notifications.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Notifications';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Notifications] in your schema.
 */
class NotificationsModelIdentifier implements amplify_core.ModelIdentifier<Notifications> {
  final String id;

  /** Create an instance of NotificationsModelIdentifier using [id] the primary key. */
  const NotificationsModelIdentifier({
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
  String toString() => 'NotificationsModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is NotificationsModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}