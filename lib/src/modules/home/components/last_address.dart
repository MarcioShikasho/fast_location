import 'package:flutter/material.dart';
import '../model/address_model.dart';

class LastAddress extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onMapPressed;
  
  const LastAddress({
    Key? key,
    required this.address,
    required this.onMapPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Último endereço:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('CEP: ${address.cep}'),
            Text('Logradouro: ${address.logradouro}'),
            Text('Bairro: ${address.bairro}'),
            Text('Cidade: ${address.localidade} - ${address.uf}'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.map),
                  label: Text('Ver no mapa'),
                  onPressed: onMapPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}