import 'package:flutter/foundation.dart';

class Transaction {
  // Blueprint or model of a transaction
  final String? id;
  final String? title;
  final double? amount;
  final DateTime? date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
