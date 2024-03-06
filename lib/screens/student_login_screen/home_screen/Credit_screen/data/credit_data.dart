import 'package:flutter/material.dart';

class CreditData{
  final String semester;
  final String offerCredit;
  final String earnedCredit;
  final String retakeCredit;
  final String totalCredit;
  final String btnStatus;

  CreditData({required this.semester, required this.offerCredit, required this.earnedCredit, required this.retakeCredit, required this.totalCredit, required this.btnStatus});
}

List<CreditData> fee = [
  CreditData(semester: '1st', offerCredit: '13.5', earnedCredit: '13.5', retakeCredit: '0', totalCredit: '13.5', btnStatus: 'COMPLETED'),
  CreditData(semester: '2nd', offerCredit: '16', earnedCredit: '16', retakeCredit: '0', totalCredit: '16', btnStatus: 'COMPLETED'),
  CreditData(semester: '3rd', offerCredit: '15.5', earnedCredit: '15.5', retakeCredit: '0', totalCredit: '15.5', btnStatus: 'COMPLETED'),
  CreditData(semester: '4th', offerCredit: '7.5', earnedCredit: '7.5', retakeCredit: '0', totalCredit: '7.5', btnStatus: 'RUNNING'),
];