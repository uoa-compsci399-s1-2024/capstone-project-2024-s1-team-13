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


/** This is an auto generated class representing the Sess type in your schema. */
class Sess {
  final List<String>? _aSess;

  List<String>? get aSess {
    return _aSess;
  }
  
  const Sess._internal({aSess}): _aSess = aSess;
  
  factory Sess({List<String>? aSess}) {
    return Sess._internal(
      aSess: aSess != null ? List<String>.unmodifiable(aSess) : aSess);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Sess &&
      DeepCollectionEquality().equals(_aSess, other._aSess);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Sess {");
    buffer.write("aSess=" + (_aSess != null ? _aSess!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Sess copyWith({List<String>? aSess}) {
    return Sess._internal(
      aSess: aSess ?? this.aSess);
  }
  
  Sess copyWithModelFieldValues({
    ModelFieldValue<List<String>?>? aSess
  }) {
    return Sess._internal(
      aSess: aSess == null ? this.aSess : aSess.value
    );
  }
  
  Sess.fromJson(Map<String, dynamic> json)  
    : _aSess = json['aSess']?.cast<String>();
  
  Map<String, dynamic> toJson() => {
    'aSess': _aSess
  };
  
  Map<String, Object?> toMap() => {
    'aSess': _aSess
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Sess";
    modelSchemaDefinition.pluralName = "Sesses";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'aSess',
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
  });
}