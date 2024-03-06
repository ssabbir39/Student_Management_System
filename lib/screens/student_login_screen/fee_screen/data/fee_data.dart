class FeeData{
  final String receiptNo;
  final String month;
  final String date;
  final String paymentStatus;
  final String totalAmount;
  final String btnStatus;

  FeeData({required this.receiptNo, required this.month, required this.date, required this.paymentStatus, required this.totalAmount, required this.btnStatus});
}

List<FeeData> fee = [
  FeeData(receiptNo: '90783', month: 'December', date: '8 Dec 2023', paymentStatus: 'Pending', totalAmount: '5150 Taka', btnStatus: 'PAY NOW'),
  FeeData(receiptNo: '90782', month: 'November', date: '8 Nov 2023', paymentStatus: 'DONE', totalAmount: '5150 Taka', btnStatus: 'DOWNLOAD'),
  FeeData(receiptNo: '90781', month: 'October', date: '8 oct 2023', paymentStatus: 'DONE', totalAmount: '5150 Taka', btnStatus: 'DOWNLOAD'),
];