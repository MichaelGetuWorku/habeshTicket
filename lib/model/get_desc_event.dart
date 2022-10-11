class GetDescriptionEvent {
  GetDescriptionEvent({
    required this.type,
    required this.subType,
    this.homeTeam,
    this.awayTeam,
    required this.eventDescriptionText,
  });
  late final String type;
  late final String subType;
  late HomeTeam? homeTeam;
  late AwayTeam? awayTeam;
  late final String eventDescriptionText;

  factory GetDescriptionEvent.fromJson(Map<String, dynamic> json) {
    return GetDescriptionEvent(
      type: json['type'],
      eventDescriptionText: json['event_description_text'] ?? '',
      subType: json['sub-type'],
      homeTeam: json['home_team'] != null
          ? HomeTeam.fromJson(json['home_team'])
          : null,
      awayTeam: json['away_team'] != null
          ? AwayTeam.fromJson(json['away_team'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['sub-type'] = subType;
    _data['home_team'] = homeTeam!.toJson();
    _data['away_team'] = awayTeam!.toJson();
    return _data;
  }
}

class HomeTeam {
  HomeTeam({
    this.countryId,
    this.name,
    this.teamId,
  });
  late final String? countryId;
  late final String? name;
  late final dynamic teamId;

  factory HomeTeam.fromJson(Map<String, dynamic> json) {
    return HomeTeam(
      countryId: json["country_id"],
      name: json["name"],
      teamId: json["team_id"],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['team_id'] = teamId;
    return _data;
  }
}

class AwayTeam {
  AwayTeam({
    this.countryId,
    this.name,
    this.teamId,
  });
  late final String? countryId;
  late final String? name;
  late final dynamic teamId;

  factory AwayTeam.fromJson(Map<String, dynamic> json) {
    return AwayTeam(
      countryId: json["country_id"],
      name: json["name"],
      teamId: json["team_id"],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['team_id'] = teamId;
    return _data;
  }
}
