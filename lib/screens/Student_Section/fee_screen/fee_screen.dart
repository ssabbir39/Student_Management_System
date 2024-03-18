import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../home_screen/Credit_screen/widget/credit_widgets.dart';
import '../home_screen/home_screen.dart';
import 'data/fee_data.dart';

class FeeScreen extends StatelessWidget {
  const FeeScreen({super.key});

  static String routeName = 'FeeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  const StudentHomeScreen(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text('Fee',style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kDefaultPadding),
                  topRight: Radius.circular(kDefaultPadding),
                ),
                color: kOtherColor,
              ),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(kDefaultPadding),
                itemCount: fee.length,
                itemBuilder: (context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: kDefaultPadding),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(kDefaultPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(kDefaultPadding),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: kTextLightColor,
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              CreditDetailRow(
                                title: 'Receip No',
                                statusValue: fee[index].receiptNo,
                              ),
                              SizedBox(
                                height: kDefaultPadding,
                                child: Divider(
                                  thickness: 1.0,
                                ),
                              ),
                              CreditDetailRow(
                                title: 'Month',
                                statusValue: fee[index].month,
                              ),
                              sizeBox,
                              CreditDetailRow(
                                title: 'Payment Data',
                                statusValue: fee[index].date,
                              ),
                              sizeBox,
                              CreditDetailRow(
                                title: 'Status',
                                statusValue: fee[index].paymentStatus,
                              ),
                              sizeBox,
                              SizedBox(
                                height: kDefaultPadding,
                                child: Divider(
                                  thickness: 1.0,
                                ),
                              ),
                              CreditDetailRow(
                                title: 'Total Amount',
                                statusValue: fee[index].totalAmount,
                              ),
                            ],
                          ),
                        ),
                        CreditButton(
                          title: fee[index].btnStatus,
                          iconData: fee[index].btnStatus == 'Paid'
                              ? Icons.download_outlined
                              : Icons.arrow_forward_outlined,
                          onPress: () {},
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}