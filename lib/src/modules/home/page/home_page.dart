import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_routes.dart';
import '../../home/components/address_item.dart';
import '../components/empty_address.dart';
import '../components/last_address.dart';
import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final cepController = TextEditingController();
  List<ReactionDisposer>? _disposers;

  @override
  void initState() {
    super.initState();
    _disposers = [
      reaction(
        (_) => controller.errorMessage, 
        (String? message) {
          if (message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      )
    ];
  }

  @override
  void dispose() {
    cepController.dispose();
    for (final disposer in _disposers!) {
      disposer();
    }
    super.dispose();
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
          content: Text('Erro ao abrir mapa: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta CEP'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.history);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cepController,
              decoration: InputDecoration(
                labelText: 'Digite o CEP',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (cepController.text.isNotEmpty) {
                      controller.searchCep(cepController.text);
                    }
                  },
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 9,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.searchCep(value);
                }
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (controller.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  
                if (controller.currentAddress != null) {
                    return AddressItem(
                      title: 'Endereço atual',
                      address: controller.currentAddress!.fullAddress,
                      date: DateFormat('dd/MM/yyyy – HH:mm').format(
                        controller.currentAddress!.searchDate ?? DateTime.now(),
                      ),
                      onMapPressed: () {
                        _openMap(controller.currentAddress!.fullAddress);
                      },
                    );
                  }
                  
                  if (controller.lastAddress != null) {
                    return LastAddress(
                      address: controller.lastAddress!,
                      onMapPressed: () {
                        _openMap(controller.lastAddress!.fullAddress);
                      },
                    );
                  }
                  
                  return EmptyAddress();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}