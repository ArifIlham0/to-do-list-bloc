import 'dart:convert';

String deleteToDoRequestToJson(DeleteToDoRequest data) =>
    json.encode(data.toJson());

class DeleteToDoRequest {
  final List<int>? ids;

  DeleteToDoRequest({
    this.ids,
  });

  Map<String, dynamic> toJson() => {
        "ids": List<dynamic>.from(ids!.map((x) => x)),
      };
}
