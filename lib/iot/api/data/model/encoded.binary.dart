// To parse this JSON data, do
//
//     final encodedBinary = encodedBinaryFromJson(jsonString);

import 'dart:convert';

EncodedBinary encodedBinaryFromJson(String str) => EncodedBinary.fromJson(json.decode(str));

String encodedBinaryToJson(EncodedBinary data) => json.encode(data.toJson());

class EncodedBinary {
  String data;

  EncodedBinary({
    required this.data,
  });

  factory EncodedBinary.fromJson(Map<String, dynamic> json) => EncodedBinary(
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}
