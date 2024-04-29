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


/** This is an auto generated class representing the Recipe type in your schema. */
class Recipe extends amplify_core.Model {
  static const classType = const _RecipeModelType();
  final String id;
  final String? _recipeTitle;
  final List<String>? _recipeStep;
  final String? _adminID;
  final List<String>? _recipeStepImage;
  final String? _recipeCoverImage;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  RecipeModelIdentifier get modelIdentifier {
      return RecipeModelIdentifier(
        id: id
      );
  }
  
  String? get recipeTitle {
    return _recipeTitle;
  }
  
  List<String>? get recipeStep {
    return _recipeStep;
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
  
  List<String>? get recipeStepImage {
    return _recipeStepImage;
  }
  
  String? get recipeCoverImage {
    return _recipeCoverImage;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Recipe._internal({required this.id, recipeTitle, recipeStep, required adminID, recipeStepImage, recipeCoverImage, createdAt, updatedAt}): _recipeTitle = recipeTitle, _recipeStep = recipeStep, _adminID = adminID, _recipeStepImage = recipeStepImage, _recipeCoverImage = recipeCoverImage, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Recipe({String? id, String? recipeTitle, List<String>? recipeStep, required String adminID, List<String>? recipeStepImage, String? recipeCoverImage}) {
    return Recipe._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      recipeTitle: recipeTitle,
      recipeStep: recipeStep != null ? List<String>.unmodifiable(recipeStep) : recipeStep,
      adminID: adminID,
      recipeStepImage: recipeStepImage != null ? List<String>.unmodifiable(recipeStepImage) : recipeStepImage,
      recipeCoverImage: recipeCoverImage);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Recipe &&
      id == other.id &&
      _recipeTitle == other._recipeTitle &&
      DeepCollectionEquality().equals(_recipeStep, other._recipeStep) &&
      _adminID == other._adminID &&
      DeepCollectionEquality().equals(_recipeStepImage, other._recipeStepImage) &&
      _recipeCoverImage == other._recipeCoverImage;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Recipe {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("recipeTitle=" + "$_recipeTitle" + ", ");
    buffer.write("recipeStep=" + (_recipeStep != null ? _recipeStep!.toString() : "null") + ", ");
    buffer.write("adminID=" + "$_adminID" + ", ");
    buffer.write("recipeStepImage=" + (_recipeStepImage != null ? _recipeStepImage!.toString() : "null") + ", ");
    buffer.write("recipeCoverImage=" + "$_recipeCoverImage" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Recipe copyWith({String? recipeTitle, List<String>? recipeStep, String? adminID, List<String>? recipeStepImage, String? recipeCoverImage}) {
    return Recipe._internal(
      id: id,
      recipeTitle: recipeTitle ?? this.recipeTitle,
      recipeStep: recipeStep ?? this.recipeStep,
      adminID: adminID ?? this.adminID,
      recipeStepImage: recipeStepImage ?? this.recipeStepImage,
      recipeCoverImage: recipeCoverImage ?? this.recipeCoverImage);
  }
  
  Recipe copyWithModelFieldValues({
    ModelFieldValue<String?>? recipeTitle,
    ModelFieldValue<List<String>?>? recipeStep,
    ModelFieldValue<String>? adminID,
    ModelFieldValue<List<String>?>? recipeStepImage,
    ModelFieldValue<String?>? recipeCoverImage
  }) {
    return Recipe._internal(
      id: id,
      recipeTitle: recipeTitle == null ? this.recipeTitle : recipeTitle.value,
      recipeStep: recipeStep == null ? this.recipeStep : recipeStep.value,
      adminID: adminID == null ? this.adminID : adminID.value,
      recipeStepImage: recipeStepImage == null ? this.recipeStepImage : recipeStepImage.value,
      recipeCoverImage: recipeCoverImage == null ? this.recipeCoverImage : recipeCoverImage.value
    );
  }
  
  Recipe.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _recipeTitle = json['recipeTitle'],
      _recipeStep = json['recipeStep']?.cast<String>(),
      _adminID = json['adminID'],
      _recipeStepImage = json['recipeStepImage']?.cast<String>(),
      _recipeCoverImage = json['recipeCoverImage'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'recipeTitle': _recipeTitle, 'recipeStep': _recipeStep, 'adminID': _adminID, 'recipeStepImage': _recipeStepImage, 'recipeCoverImage': _recipeCoverImage, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'recipeTitle': _recipeTitle,
    'recipeStep': _recipeStep,
    'adminID': _adminID,
    'recipeStepImage': _recipeStepImage,
    'recipeCoverImage': _recipeCoverImage,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<RecipeModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<RecipeModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final RECIPETITLE = amplify_core.QueryField(fieldName: "recipeTitle");
  static final RECIPESTEP = amplify_core.QueryField(fieldName: "recipeStep");
  static final ADMINID = amplify_core.QueryField(fieldName: "adminID");
  static final RECIPESTEPIMAGE = amplify_core.QueryField(fieldName: "recipeStepImage");
  static final RECIPECOVERIMAGE = amplify_core.QueryField(fieldName: "recipeCoverImage");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Recipe";
    modelSchemaDefinition.pluralName = "Recipes";
    
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
      key: Recipe.RECIPETITLE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.RECIPESTEP,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.ADMINID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.RECIPESTEPIMAGE,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.RECIPECOVERIMAGE,
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

class _RecipeModelType extends amplify_core.ModelType<Recipe> {
  const _RecipeModelType();
  
  @override
  Recipe fromJson(Map<String, dynamic> jsonData) {
    return Recipe.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Recipe';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Recipe] in your schema.
 */
class RecipeModelIdentifier implements amplify_core.ModelIdentifier<Recipe> {
  final String id;

  /** Create an instance of RecipeModelIdentifier using [id] the primary key. */
  const RecipeModelIdentifier({
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
  String toString() => 'RecipeModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is RecipeModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}