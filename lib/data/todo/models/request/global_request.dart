import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'global_request.g.dart';

GlobalRequest globalRequestFromJson(String str) => GlobalRequest.fromJson(json.decode(str));

String globalRequestToJson(GlobalRequest data) => json.encode(data.toJson());

@JsonSerializable()
class GlobalRequest {
  @JsonKey(name: "ids")
  final List<int>? ids;

  GlobalRequest({
      this.ids,
  });

  factory GlobalRequest.fromJson(Map<String, dynamic> json) => _$GlobalRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalRequestToJson(this);
}
