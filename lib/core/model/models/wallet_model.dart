class WalletModel {
  final String firstName;
  final String lastName;
  final String title, dateTime;
  final double price;
  final String src;
  final bool debit;

  WalletModel({
    required this.firstName,
    required this.lastName,
    required this.src,
    required this.title,
    required this.dateTime,
    required this.price,
    required this.debit,
  });

  // Convert WalletModel object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'src': src,
      'title': title,
      'dateTime': dateTime,
      'price': price,
      'debit': debit,
    };
  }

  // Create WalletModel object from JSON format
  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      src: json['src'],
      title: json['title'],
      dateTime: json['dateTime'],
      price: json['price'],
      debit: json['debit'],
    );
  }
}
