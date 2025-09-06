import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';
import 'item.dart';
import 'equip_receipt.dart';
import 'equip_colors.dart';

class EquipCart extends StatefulWidget {

  // EquipCart Constructor
  const EquipCart({super.key});

  @override
  State<EquipCart> createState() => _EquipCart();
}

class _EquipCart extends State<EquipCart> {
  List<Item> submittedItems = [];

  // Handles Submit Button Functionality
  void onSubmitPressed(cart) async {
    final receiptItems = List<Item>.from(cart.items);
    cart.clearCart();

    // Navigate to Receipt Page
    Navigator.push(context,
      MaterialPageRoute(
        builder: (_) => EquipReceipt(receipt: receiptItems),
      ),
    );

  }

@override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;
    final cart = Provider.of<Cart>(context);
    final items = cart.items;
    final bool cartEmpty = cart.isEmpty();

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Cart', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
        ),
        backgroundColor: EquipColors.base,
        body: Column(
          children: [
            // List of Items in Cart
            Expanded(
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                                        Image.asset(items[index].url, fit: BoxFit.cover),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(items[index].name, style: TextStyle(fontSize: 20, color: EquipColors.base), overflow: TextOverflow.ellipsis, maxLines: 3)
                                        )
                                      ],
                                    )
                                  )
                                ),
                                SizedBox(width: isWeb ? 100 : 20), // Used for Formatting
                                // Remove Item from Cart Button
                                Flexible(
                                    flex: 2,
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 12),
                                        child: TextButton(
                                            onPressed: () => cart.removeItem(items[index]),
                                            child: Icon(Icons.delete, color: EquipColors.base, size: 30)
                                        )
                                    )
                                )
                              ]
                          )
                      );
                    }
                )
            ),
            // Submit Button at Bottom of Screen Only Appears if Cart is not Empty
            cartEmpty ? Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Your Cart is Empty', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: EquipColors.neutral)),
            ) : Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                  onPressed: () => onSubmitPressed(cart),
                  style: ButtonStyle(
                    backgroundColor:  WidgetStateProperty.all<Color>(EquipColors.teal)
                  ),
                  child: Text('Submit Order', style: TextStyle(fontSize: 16, color: EquipColors.neutral))
              ),
            )
          ],
        )
    );
  }
}