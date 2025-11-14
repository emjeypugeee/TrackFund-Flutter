import 'package:flutter/material.dart';
import 'package:track_fund/components/custom_card.dart';
import 'package:track_fund/components/transaction_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text(
          'My Wallet',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomCard(),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('See All', style: TextStyle(color: Colors.grey[400], fontSize: 15)),
                ],
              ),
              Column(
                children: [
                  TransactionCard(transacName: 'Money Transfer', amount: '500', time: '12:30AM'),
                  TransactionCard(transacName: 'Paypal', amount: '600', time: '1:00PM'),
                  TransactionCard(transacName: 'Paypal', amount: '600', time: '1:00PM'),
                  TransactionCard(transacName: 'Paypal', amount: '600', time: '1:00PM'),
                  TransactionCard(transacName: 'Paypal', amount: '600', time: '1:00PM'),
                  TransactionCard(transacName: 'Paypal', amount: '600', time: '1:00PM'),
                  TransactionCard(transacName: 'Paypal', amount: '600', time: '1:00PM'),
                  TransactionCard(transacName: 'Paypal', amount: '600', time: '1:00PM'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
