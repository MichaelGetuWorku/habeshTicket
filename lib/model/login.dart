class Login {
  Login({
    required this.data,
    required this.error,
    required this.errorMsg,
  });
  late final Data data;
  late final bool error;
  late final String errorMsg;

  Login.fromJson(Map<String, dynamic> json) {
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
    required this.jwt,
    required this.ledgerData,
    required this.user,
  });
  late final String jwt;
  late final LedgerData ledgerData;
  late final Users user;

  Data.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    ledgerData = LedgerData.fromJson(json['ledger_data']);
    user = Users.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['jwt'] = jwt;
    _data['ledger_data'] = ledgerData.toJson();
    _data['user'] = user.toJson();
    return _data;
  }
}

class LedgerData {
  LedgerData({
    required this.accountNo,
    required this.balance,
    required this.ledgerId,
  });
  late final String accountNo;
  late final double balance;
  late final int ledgerId;

  LedgerData.fromJson(Map<String, dynamic> json) {
    accountNo = json['account_no'];
    balance = json['balance'];
    ledgerId = json['ledger_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['account_no'] = accountNo;
    _data['balance'] = balance;
    _data['ledger_id '] = ledgerId;
    return _data;
  }
}

class Users {
  Users({
    required this.clientId,
    required this.firebaseUid,
    required this.generatedOn,
    required this.sessionToken,
  });
  late final int clientId;
  late final String firebaseUid;
  late final int generatedOn;
  late final String sessionToken;

  Users.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    firebaseUid = json['firebase_uid'];
    generatedOn = json['generated_on'];
    sessionToken = json['session_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['client_id'] = clientId;
    _data['firebase_uid'] = firebaseUid;
    _data['generated_on'] = generatedOn;
    _data['session_token'] = sessionToken;
    return _data;
  }
}
