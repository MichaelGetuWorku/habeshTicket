class GetTickets {
  GetTickets({
    required this.data,
    required this.error,
    required this.errorMsg,
  });
  late final List<Data> data;
  late final bool error;
  late final String errorMsg;

  GetTickets.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    error = json['error'];
    errorMsg = json['error_msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['error'] = error;
    _data['error_msg'] = errorMsg;
    return _data;
  }
}

class Data {
  Data({
    required this.tickets,
  });
  late final List<Tickets> tickets;

  Data.fromJson(Map<String, dynamic> json) {
    tickets =
        List.from(json['tickets']).map((e) => Tickets.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tickets'] = tickets.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Tickets {
  Tickets({
    required this.event,
    required this.lastScannedOn,
    required this.price,
    required this.stadium,
    required this.status,
    required this.ticketId,
    required this.ticketQr,
    required this.ticketType,
    required this.ticketUuid,
  });
  late final Event event;
  late final String lastScannedOn;
  late final double price;
  late final Stadium stadium;
  late final String status;
  late final int ticketId;
  late final String ticketQr;
  late final String ticketType;
  late final String ticketUuid;

  Tickets.fromJson(Map<String, dynamic> json) {
    event = Event.fromJson(json['event']);
    lastScannedOn = json['last_scanned_on'];
    price = json['price'];
    stadium = Stadium.fromJson(json['stadium']);
    status = json['status'];
    ticketId = json['ticket_id'];
    ticketQr = json['ticket_qr'];
    ticketType = json['ticket_type'];
    ticketUuid = json['ticket_uuid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['event'] = event.toJson();
    _data['last_scanned_on'] = lastScannedOn;
    _data['price'] = price;
    _data['stadium'] = stadium.toJson();
    _data['status'] = status;
    _data['ticket_id'] = ticketId;
    _data['ticket_qr'] = ticketQr;
    _data['ticket_type'] = ticketType;
    _data['ticket_uuid'] = ticketUuid;
    return _data;
  }
}

class Event {
  Event({
    required this.eventDescription,
    required this.eventId,
    required this.eventStartTime,
    required this.eventStatus,
  });
  late final String eventDescription;
  late final int eventId;
  late final String eventStartTime;
  late final String eventStatus;

  Event.fromJson(Map<String, dynamic> json) {
    eventDescription = json['event_description'];
    eventId = json['event_id'];
    eventStartTime = json['event_start_time'];
    eventStatus = json['event_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['event_description'] = eventDescription;
    _data['event_id'] = eventId;
    _data['event_start_time'] = eventStartTime;
    _data['event_status'] = eventStatus;
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

  Stadium.fromJson(Map<String, dynamic> json) {
    capacity = json['capacity'];
    city = json['city'];
    location = json['location'];
    name = json['name'];
    stadiumId = json['stadium_id'];
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
