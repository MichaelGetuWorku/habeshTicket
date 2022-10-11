class GetLedger {
  GetLedger({
    required this.data,
    required this.error,
    required this.errorMsg,
  });
  late final Data data;
  late final bool error;
  late final String errorMsg;

  factory GetLedger.fromJson(Map<String, dynamic> json) {
    return GetLedger(
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
    required this.ledger,
  });
  late final Ledger ledger;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      ledger: Ledger.fromJson(json['ledger']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ledger'] = ledger.toJson();
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
