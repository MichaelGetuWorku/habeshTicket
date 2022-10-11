import 'dart:convert';

class GetDetails {
  GetDetails({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.type,
  });
  late final String name;
  late final String description;
  late final int startDate;
  late final int endDate;
  late final Type type;

  factory GetDetails.fromJson(Map<String, dynamic> json) {
    return GetDetails(
      name: json['name'],
      description: json['description'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      type: Type.fromJson(json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['description'] = description;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['type'] = type.toJson();
    return _data;
  }
}

class Type {
  Type({
    required this.id,
  });
  late final String id;

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    return _data;
  }
}
