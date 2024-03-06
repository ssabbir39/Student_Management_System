import 'package:flutter/material.dart';
import 'package:student_management_system/screens/student_login_screen/home_screen/home_screen.dart';
import '../../../../constants.dart';
import 'data/credit_data.dart';
import 'widget/credit_widgets.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({super.key});

  static String routeName = 'CreditScreen';

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
        title: Text('Credit Completed',style: TextStyle(color: kTextWhiteColor),),
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
                                title: 'Semester',
                                statusValue: fee[index].semester,
                              ),
                              SizedBox(
                                height: kDefaultPadding,
                                child: Divider(
                                  thickness: 1.0,
                                ),
                              ),
                              CreditDetailRow(
                                title: 'Offer Credit',
                                statusValue: fee[index].offerCredit,
                              ),
                              sizeBox,
                              CreditDetailRow(
                                title: 'Earned Credit',
                                statusValue: fee[index].earnedCredit,
                              ),
                              sizeBox,
                              CreditDetailRow(
                                title: 'Retake Credit',
                                statusValue: fee[index].retakeCredit,
                              ),
                              sizeBox,
                              SizedBox(
                                height: kDefaultPadding,
                                child: Divider(
                                  thickness: 1.0,
                                ),
                              ),
                              CreditDetailRow(
                                title: 'Total Credit',
                                statusValue: fee[index].totalCredit,
                              ),
                            ],
                          ),
                        ),
                        CreditButton(
                          title: fee[index].btnStatus,
                          iconData: fee[index].btnStatus == 'COMPLETED'
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
