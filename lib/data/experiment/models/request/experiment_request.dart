import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'experiment_request.g.dart';

ExperimentRequest experimentRequestFromJson(String str) => ExperimentRequest.fromJson(json.decode(str));

String experimentRequestToJson(ExperimentRequest data) => json.encode(data.toJson());

@JsonSerializable()
class ExperimentRequest {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "category")
  final String? category;

  ExperimentRequest({
      this.name,
      this.category,
  });

  factory ExperimentRequest.fromJson(Map<String, dynamic> json) => _$ExperimentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExperimentRequestToJson(this);
}
