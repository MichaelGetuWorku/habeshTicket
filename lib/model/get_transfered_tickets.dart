class GetTransferredTicket {
  GetTransferredTicket({
    required this.data,
    required this.error,
    required this.errorMsg,
  });
  late final Data data;
  late final bool error;
  late final String errorMsg;

  GetTransferredTicket.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    error = json['error'];
    errorMsg = json['error_msg'];
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
    required this.transactions,
  });
  late final List<Transactions> transactions;

  Data.fromJson(Map<String, dynamic> json) {
    transactions = List.from(json['transactions'])
        .map((e) => Transactions.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transactions'] = transactions.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Transactions {
  Transactions({
    required this.fromAccountNo,
    required this.ticketId,
    required this.ticketTransferId,
    required this.timestamp,
    required this.toAccountNo,
    required this.type,
  });
  late final String fromAccountNo;
  late final int ticketId;
  late final int ticketTransferId;
  late final int timestamp;
  late final String toAccountNo;
  late final String type;

  Transactions.fromJson(Map<String, dynamic> json) {
    fromAccountNo = json['from_account_no'];
    ticketId = json['ticket_id'];
    ticketTransferId = json['ticket_transfer_id'];
    timestamp = json['timestamp'];
    toAccountNo = json['to_account_no'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['from_account_no'] = fromAccountNo;
    _data['ticket_id'] = ticketId;
    _data['ticket_transfer_id'] = ticketTransferId;
    _data['timestamp'] = timestamp;
    _data['to_account_no'] = toAccountNo;
    _data['type'] = type;
    return _data;
  }
}
