import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  final String title;
  final String address;
  final String date;
  final VoidCallback? onTap;
  final VoidCallback? onMapPressed;

  const AddressItem({
    Key? key,
    required this.title,
    required this.address,
    required this.date,
    this.onTap,
    this.onMapPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    address,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            if (onMapPressed != null)
              Align(
                 alignment: Alignment.centerRight,
                 child: IconButton(
                   icon: const Icon(Icons.map),
                   color: Theme.of(context).primaryColor,
                   tooltip: 'Ver no mapa',
                   onPressed: onMapPressed,
                 ),
              ),
          ],
        ),
      ),
    );
  }
}