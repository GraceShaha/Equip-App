import 'package:flutter/material.dart';
import 'item.dart';
import 'equip_colors.dart';

class EquipReceipt extends StatelessWidget {
  final List<Item> receipt;

  const EquipReceipt({super.key, required this.receipt});

  // Directs User Back to Home Page
  void onHome(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false, // Disable back button
            centerTitle: true,
            title: Text('Order Receipt', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: EquipColors.base))
        ),
        backgroundColor: EquipColors.base,
        body: Column(
          children: [
            // Order Submission Message
            Container(
              margin: EdgeInsets.all(20),
              child: Text('Your products are on their way!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: EquipColors.neutral))
            ),
            // List of Items in Receipt
            Expanded(
                child:ListView.builder(
                    itemCount: receipt.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: MediaQuery.of(context).size.height * (isWeb ? 0.30 : 0.14),
                          color: EquipColors.neutral,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Item Image and Name
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                                    child: Row(
                                      children: [
                                        Image.asset(receipt[index].url, fit: BoxFit.cover),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(receipt[index].name, style: TextStyle(fontSize: 20, color: EquipColors.base), overflow: TextOverflow.ellipsis, maxLines: 3)
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]
                          )
                      );
                    }
                )
            ),
            // Button to go Back Home
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                  onPressed: () => onHome(context),
                  style: ButtonStyle(
                    backgroundColor:  WidgetStateProperty.all<Color>(EquipColors.teal),
                  ),
                  child: Text('Back to Home', style: TextStyle(fontSize: 16, color: EquipColors.neutral))
              ),
            )
          ],
        )
    );
  }
}