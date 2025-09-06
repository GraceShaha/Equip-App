import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item.dart';
import 'cart.dart';
import 'equip_cart.dart';
import 'equip_colors.dart';

// All Available Items
final List<Item> equipItems = [
  Item(name: 'Non-Padded Gloves', url: 'assets/images/gloves_no_padding.png'),
  Item(name: 'Semi-Padded Gloves', url: 'assets/images/gloves_semi_padding.jpg'),
  Item(name: 'Heavy-Padded Gloves', url: 'assets/images/gloves_heavy_padding.png'),
  Item(name: 'Long-Sleeved Compression Shirt', url: 'assets/images/compression_shirt_long_sleeved.png'),
  Item(name: 'Short-Sleeved Compression Shirt', url: 'assets/images/compression_shirt_short_sleeved.png'),
  Item(name: 'Skull Cap', url: 'assets/images/skull_cap.png'),
  Item(name: 'Skull Wrap', url: 'assets/images/skull_wrap.png'),
  Item(name: 'Compression Underwear', url: 'assets/images/compression_underwear.png'),
  Item(name: 'Socks', url: 'assets/images/socks.png'),
  Item(name: 'Shorts', url: 'assets/images/shorts.png'),
  Item(name: 'Tights', url: 'assets/images/tights_3:4.png'),
  Item(name: 'QB Towel', url: 'assets/images/qb_towel.png'),
  Item(name: 'Padded Arm Sleeve', url: 'assets/images/padded_arm_sleeve.png'),
  Item(name: 'Non-Padded Arm Sleeve', url: 'assets/images/non_padded_arm_sleeve.png'),
  Item(name: 'Wrist Band', url: 'assets/images/wrist_band.png'),
  Item(name: 'Bicep Band', url: 'assets/images/bicep_band.png'),
  Item(name: 'Laundry Loop', url: 'assets/images/laundry_loop.png'),
  Item(name: 'Shower Towel', url: 'assets/images/shower_towel.png'),
];

// Stateful
class EquipHome extends StatefulWidget {
  final List<Item> items = equipItems;

  // EquipHome Constructor
  EquipHome({super.key});

  @override
  State<EquipHome> createState() => _EquipHome();
}

class _EquipHome extends State<EquipHome> {
  List<Item> addedItems = [];

  // Handles Cart Icon Functionality
  void onCartPressed() async {
    final updatedCart = await Navigator.push(context,
      MaterialPageRoute(
        builder: (_) => EquipCart(), // Navigate to Cart
      ),
    );

    if (updatedCart != null && updatedCart is List<Item>) {
      setState(() {
        addedItems = List<Item>.from(updatedCart); // Updates addedItems to communicate with Cart
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600; // Used to format web vs mobile
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Spacer(), // Used to help align Logo and Cart
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/equip_logo.png', height: 50),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text( 'Equip', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                    )
                  ],
                )
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: onCartPressed,
                      child: Icon(Icons.shopping_cart, color: EquipColors.base, size: 30)
                  ),
                )
              )
            ],
          ),
      ),
      backgroundColor: EquipColors.base,
      body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final cart = Provider.of<Cart>(context);
            final bool isAdded = cart.contains(widget.items[index]);
            return Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              height: MediaQuery.of(context).size.height * (isWeb ? 0.30 : 0.14),
              color: EquipColors.neutral,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      child: Row(
                        children: [
                          Image.asset(widget.items[index].url, fit: BoxFit.cover),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(widget.items[index].name, style: TextStyle(fontSize: 16, color: EquipColors.base), overflow: TextOverflow.ellipsis, maxLines: 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: isWeb ? 100 : 20),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(isAdded ? Colors.grey : EquipColors.teal),
                        ),
                        onPressed: () {
                          setState(() {
                            if (!cart.contains(widget.items[index])) {
                              cart.addItem(widget.items[index]);
                            }
                            else{
                              cart.removeItem(widget.items[index]);
                            }
                          });
                        },
                        child: Text(isAdded ? 'Added' : 'Add', style: TextStyle(fontSize: 16, color: EquipColors.neutral)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      )
    );
  }
}