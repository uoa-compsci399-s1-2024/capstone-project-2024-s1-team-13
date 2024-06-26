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

import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'Admin.dart';
import 'CurrTask.dart';
import 'JudgementCall.dart';
import 'Notifications.dart';
import 'Recipe.dart';
import 'Session.dart';
import 'Support.dart';
import 'Task.dart';
import 'TaskFeeling.dart';
import 'TaskNotes.dart';
import 'Trainee.dart';
import 'TraineeNotes.dart';
import 'Sess.dart';

export 'Admin.dart';
export 'CurrTask.dart';
export 'JudgementCall.dart';
export 'Notifications.dart';
export 'Recipe.dart';
export 'Sess.dart';
export 'Session.dart';
export 'Support.dart';
export 'Task.dart';
export 'TaskFeeling.dart';
export 'TaskNotes.dart';
export 'Trainee.dart';
export 'TraineeNotes.dart';

class ModelProvider implements amplify_core.ModelProviderInterface {
  @override
  String version = "fe1c40d8036283b9ecf8baa61c41c83b";
  @override
  List<amplify_core.ModelSchema> modelSchemas = [Admin.schema, CurrTask.schema, JudgementCall.schema, Notifications.schema, Recipe.schema, Session.schema, Support.schema, Task.schema, TaskFeeling.schema, TaskNotes.schema, Trainee.schema, TraineeNotes.schema];
  @override
  List<amplify_core.ModelSchema> customTypeSchemas = [Sess.schema];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;
  
  amplify_core.ModelType getModelTypeByModelName(String modelName) {
    switch(modelName) {
      case "Admin":
        return Admin.classType;
      case "CurrTask":
        return CurrTask.classType;
      case "JudgementCall":
        return JudgementCall.classType;
      case "Notifications":
        return Notifications.classType;
      case "Recipe":
        return Recipe.classType;
      case "Session":
        return Session.classType;
      case "Support":
        return Support.classType;
      case "Task":
        return Task.classType;
      case "TaskFeeling":
        return TaskFeeling.classType;
      case "TaskNotes":
        return TaskNotes.classType;
      case "Trainee":
        return Trainee.classType;
      case "TraineeNotes":
        return TraineeNotes.classType;
      default:
        throw Exception("Failed to find model in model provider for model name: " + modelName);
    }
  }
}


class ModelFieldValue<T> {
  const ModelFieldValue.value(this.value);

  final T value;
}
