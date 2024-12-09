class SavedWithdrawalAccountModel {
  final String accountName;
  final String bankName;
  final String accountNumber;
  final String src;

  SavedWithdrawalAccountModel({
    required this.accountName,
    required this.bankName,
    required this.accountNumber,
    required this.src,
  });

  factory SavedWithdrawalAccountModel.fromJson(Map<String, dynamic> json) {
    return SavedWithdrawalAccountModel(
      accountName: json['accountName'],
      bankName: json['bankName'],
      accountNumber: json['accountNumber'],
      src: json['src'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountName': accountName,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'src': src,
    };
  }
}
