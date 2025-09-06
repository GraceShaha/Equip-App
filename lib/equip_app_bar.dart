import 'package:flutter/material.dart';
import 'equip_colors.dart';

class EquipAppBar extends StatelessWidget implements PreferredSizeWidget{
  final VoidCallback onCartPressed;
  const EquipAppBar({super.key, required this.onCartPressed});

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/equip_logo.png', height: 50),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Equip',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                  child: TextButton(
                      onPressed: onCartPressed,
                      child: Icon(
                          Icons.shopping_cart, color: EquipColors.base,
                          size: 30)
                  )
              ),
            ],
          )
    );
  }
}