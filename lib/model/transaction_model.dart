import 'package:flutter/material.dart';

class TransactionModel {
  final String transacName;
  final String time;
  final String amount;
  final Color color;

  TransactionModel({
    required this.transacName,
    required this.time,
    required this.amount,
    required this.color,
  });
}
