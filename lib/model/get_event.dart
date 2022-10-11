class GetEvent {
  GetEvent({
    required this.data,
    required this.error,
    required this.errorMsg,
  });
  late final Data data;
  late final bool error;
  late final String errorMsg;

  factory GetEvent.fromJson(Map<String, dynamic> json) {
    return GetEvent(
      data: Data.fromJson(json['data']),
      error: json['error'],
      errorMsg: json['error_msg'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['error'] = error;
    _data['error_msg'] = errorMsg;
    return _data;
  }
}

class Data {
  Data({
    required this.events,
  });
  late final List<Events> events;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      events: List.from(json['events']).map((e) => Events.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['events'] = events.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Events {
  Events({
    required this.eventDescription,
    required this.eventId,
    required this.eventStartTime,
    required this.eventTickets,
    required this.stadium,
  });
  late final EventDescription eventDescription;
  late final int eventId;
  late final String eventStartTime;
  late final List<EventTickets> eventTickets;
  late final Stadium stadium;

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      eventDescription: EventDescription.fromJson(json['event_description']),
      eventId: json['event_id'],
      eventStartTime: json['event_start_time'],
      eventTickets: List.from(json['event_tickets'])
          .map((e) => EventTickets.fromJson(e))
          .toList(),
      stadium: Stadium.fromJson(json['stadium']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['event_description'] = eventDescription;
    _data['event_id'] = eventId;
    _data['event_start_time'] = eventStartTime;
    _data['event_tickets'] = eventTickets.map((e) => e.toJson()).toList();
    _data['stadium'] = stadium.toJson();
    return _data;
  }
}

class EventDescription {
  late AwayTeam? awayTeam;
  late AwayTeam? homeTeam;
  late final String subType;
  late final String type;
  late final String eventDescriptionText;

  EventDescription({
    this.awayTeam,
    this.homeTeam,
    required this.subType,
    required this.type,
    required this.eventDescriptionText,
  });

  // EventDescription.fromJson(Map<String, dynamic> json) {
  //   awayTeam = json['away_team'] != null
  //       ? new AwayTeam.fromJson(json['away_team'])
  //       : null;
  //   homeTeam = json['home_team'] != null
  //       ? new AwayTeam.fromJson(json['home_team'])
  //       : null;
  //   subType = json['sub-type'];
  //   type = json['type'];
  //   eventDescriptionText = json['event_description_text'];
  // }
//! hear
  factory EventDescription.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = <String, dynamic>{};
    return EventDescription(
      eventDescriptionText: json['event_description_text'] ?? '',
      subType: json['sub-type'],
      type: json['type'],
      awayTeam: json['away_team'] != null
          ? AwayTeam.fromJson(json['away_team'])
          : null,
      homeTeam: json['home_team'] != null
          ? AwayTeam.fromJson(json['home_team'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['away_team'] = awayTeam!.toJson();
    data['home_team'] = homeTeam!.toJson();
    data['sub-type'] = subType;
    data['type'] = type;
    data['event_description_text'] = eventDescriptionText;
    return data;
  }
}

class EmptyTeam {
  late final String? countryId;
  late final String? name;
  late final dynamic teamId;
  EmptyTeam({
    this.countryId,
    this.name,
    this.teamId,
  });

  factory EmptyTeam.fromJson(Map<String, dynamic> json) {
    return (EmptyTeam(
      countryId: '',
      name: '',
      teamId: '' '',
    ));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['name'] = name;
    data['team_id'] = teamId;
    return data;
  }
}

class AwayTeam {
  late final String? countryId;
  late final String? name;
  late final dynamic teamId;

  AwayTeam({
    this.countryId,
    this.name,
    this.teamId,
  });

  factory AwayTeam.fromJson(Map<String, dynamic> json) {
    return (AwayTeam(
      countryId: json['country_id'] ?? '',
      name: json['name'],
      teamId: json['team_id'] ?? '',
    ));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['name'] = name;
    data['team_id'] = teamId;
    return data;
  }
}

class EventTickets {
  EventTickets({
    required this.availableTickets,
    required this.price,
    required this.type,
  });
  late final int availableTickets;
  late final double price;
  // make double
  late final String type;

  factory EventTickets.fromJson(Map<String, dynamic> json) {
    return EventTickets(
      availableTickets: json['available_tickets'],
      price: json['price'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['available_tickets'] = availableTickets;
    _data['price'] = price;
    _data['type'] = type;
    return _data;
  }
}

class Stadium {
  Stadium({
    required this.capacity,
    required this.city,
    required this.location,
    required this.name,
    required this.stadiumId,
  });
  late final int capacity;
  late final String city;
  late final String location;
  late final String name;
  late final int stadiumId;

  factory Stadium.fromJson(Map<String, dynamic> json) {
    return Stadium(
      capacity: json['capacity'],
      city: json['city'],
      location: json['location'],
      name: json['name'],
      stadiumId: json['stadium_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['capacity'] = capacity;
    _data['city'] = city;
    _data['location'] = location;
    _data['name'] = name;
    _data['stadium_id'] = stadiumId;
    return _data;
  }
}
