class GetTransactions {
  GetTransactions({
    required this.data,
    required this.error,
    required this.errorMsg,
  });
  late final Data data;
  late final bool error;
  late final String errorMsg;

  GetTransactions.fromJson(Map<String, dynamic> json) {
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
    required this.amount,
    required this.fromAccountNumber,
    required this.timestamp,
    required this.toAccountNumber,
    required this.transactionId,
    required this.type,
  });
  late final double amount;
  late final String fromAccountNumber;
  late final int timestamp;
  late final String toAccountNumber;
  late final int transactionId;
  late final String type;

  Transactions.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    fromAccountNumber = json['from_account_number'];
    timestamp = json['timestamp'];
    toAccountNumber = json['to_account_number'];
    transactionId = json['transaction_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['amount'] = amount;
    _data['from_account_number'] = fromAccountNumber;
    _data['timestamp'] = timestamp;
    _data['to_account_number'] = toAccountNumber;
    _data['transaction_id'] = transactionId;
    _data['type'] = type;
    return _data;
  }
}
