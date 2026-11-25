import 'package:flutter/material.dart';

import '../models/item_homepage.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(this.item, {super.key, required this.onPressed});

  final ItemHomepage item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text('Kamu telah menekan tombol ${item.name}!'),
            ));
          onPressed();
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: Colors.white, size: 30),
              const SizedBox(height: 8),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
