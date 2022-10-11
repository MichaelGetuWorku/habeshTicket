class Transfer {
  Transfer({
    required this.data,
    required this.error,
    required this.errorMsg,
  });
  late final List<Data> data;
  late final bool error;
  late final String errorMsg;

  Transfer.fromJson(Map<String, dynamic> json) {
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
    required this.ledger,
    required this.transaction,
    required this.transfered,
  });
  late final Ledger ledger;
  late final Transaction transaction;
  late final bool transfered;

  Data.fromJson(Map<String, dynamic> json) {
    ledger = Ledger.fromJson(json['ledger']);
    transaction = Transaction.fromJson(json['transaction']);
    transfered = json['transfered'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ledger'] = ledger.toJson();
    _data['transaction'] = transaction.toJson();
    _data['transfered'] = transfered;
    return _data;
  }
}

class Ledger {
  Ledger({
    required this.accountNo,
    required this.balance,
  });
  late final String accountNo;
  late final double balance;

  Ledger.fromJson(Map<String, dynamic> json) {
    accountNo = json['account_no'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['account_no'] = accountNo;
    _data['balance'] = balance;
    return _data;
  }
}

class Transaction {
  Transaction({
    required this.amount,
    required this.fromAccountNumber,
    required this.timestamp,
    required this.toAccountNumber,
    required this.transactionId,
  });
  late final double amount;
  late final String fromAccountNumber;
  late final int timestamp;
  late final String toAccountNumber;
  late final int transactionId;

  Transaction.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    fromAccountNumber = json['from_account_number'];
    timestamp = json['timestamp'];
    toAccountNumber = json['to_account_number'];
    transactionId = json['transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['amount'] = amount;
    _data['from_account_number'] = fromAccountNumber;
    _data['timestamp'] = timestamp;
    _data['to_account_number'] = toAccountNumber;
    _data['transaction_id'] = transactionId;
    return _data;
  }
}
