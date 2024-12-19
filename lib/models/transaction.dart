class Transaction {
  final String date;
  final String userEmail;
  final String productName;
  final int quantity;

  Transaction({
    required this.userEmail,
    required this.productName,
    required this.quantity,
    required this.date,
  });
}
