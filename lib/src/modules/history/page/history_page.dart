import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:map_launcher/map_launcher.dart';

import 'package:intl/intl.dart';
import '../../home/components/address_item.dart';
import '../controller/history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final controller = HistoryController();

  @override
  void initState() {
    super.initState();
    controller.loadAddresses();
  }

  void _openMap(String address) async {
    try {
      final maps = await MapLauncher.installedMaps;
      
      if (maps.isNotEmpty) {
        await maps.first.showMarker(
          coords: Coords(0, 0),
          title: address,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao abrir mapa'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico'),
      ),
      body: Observer(
        builder: (_) {
          if (controller.addresses.isEmpty) {
            return Center(
              child: Text('Nenhum endereço no histórico'),
            );
          }
          
          return ListView.builder(
            itemCount: controller.addresses.length,
            itemBuilder: (context, index) {
              final address = controller.addresses[index];
              return AddressItem(
                title: 'Busca #${index + 1}', // ou algo mais descritivo
                address: address.fullAddress,
                date: DateFormat('dd/MM/yyyy – HH:mm').format(
                  address.searchDate ?? DateTime.now(),
                ),
                onMapPressed: () {
                  _openMap(address.fullAddress);
                },
              );
            },
          );
        },
      ),
    );
  }
}