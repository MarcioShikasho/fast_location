import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; 

import '../../../routes/app_routes.dart';
import '../../home/components/address_item.dart';
import '../components/empty_address.dart';
import '../components/last_address.dart';
import '../controller/home_controller.dart';
import '../model/address_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final cepController = TextEditingController();
  final ufController = TextEditingController();
  final cidadeController = TextEditingController();
  final logradouroController = TextEditingController();


  List<ReactionDisposer>? _disposers;

  @override
  void initState() {
    super.initState();
    _disposers = [
      reaction(
        (_) => controller.errorMessage,
        (String? message) {
          if (message != null && message.isNotEmpty) {
             ScaffoldMessenger.of(context).hideCurrentSnackBar();
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      )
    ];
  }

  @override
  void dispose() {
    cepController.dispose();
    ufController.dispose();
    cidadeController.dispose();
    logradouroController.dispose();
    for (final disposer in _disposers!) {
      disposer();
    }
    super.dispose();
  }

  void _openMap(AddressModel address) async {
    try {
      final String? directionsUrl = await controller.getDirectionsUrlForAddress(address);

      if (directionsUrl != null) {
         if (await canLaunchUrl(Uri.parse(directionsUrl))) {
           await launchUrl(Uri.parse(directionsUrl));
         } else {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                 content: Text('Não foi possível abrir o aplicativo de mapas.'),
                 backgroundColor: Colors.red,
               ),
             );
         }
      } else {
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Não foi possível obter as direções para este endereço.'),
              backgroundColor: Colors.red,
            ),
          );
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao tentar abrir rotas no mapa: ${e.toString()}'),
           backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta CEP e Endereço'),
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
        child: SingleChildScrollView(
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Seção de Busca por CEP
              Text(
                 'Buscar por CEP:',
                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: cepController,
                decoration: InputDecoration(
                  labelText: 'Digite o CEP',
                  border: OutlineInputBorder(),
                  suffixIcon: Observer(
                     builder: (_) {
                        bool isSearching = controller.isLoading;
                        return IconButton(
                           icon: Icon(Icons.search),
                           onPressed: isSearching ? null : () {
                             if (cepController.text.isNotEmpty) {
                                controller.searchCep(cepController.text);
                                ufController.clear();
                                cidadeController.clear();
                                logradouroController.clear();
                             }
                           },
                        );
                     }
                  ),
                ),
                keyboardType: TextInputType.number,
                maxLength: 9,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.searchCep(value);
                     ufController.clear();
                     cidadeController.clear();
                     logradouroController.clear();
                  }
                },
              ),
              SizedBox(height: 24),

              // Seção de Busca por Endereço
              Text(
                'Buscar por Endereço:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: ufController,
                decoration: InputDecoration(
                  labelText: 'Estado (UF)',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.characters,
                maxLength: 2,
              ),
              SizedBox(height: 8),
              TextField(
                controller: cidadeController,
                decoration: InputDecoration(
                  labelText: 'Cidade',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
              ),
               SizedBox(height: 8),
              TextField(
                controller: logradouroController,
                decoration: InputDecoration(
                  labelText: 'Logradouro (Rua, Avenida, etc.)',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 16),
              Observer(
                 builder: (_) {
                    bool isSearching = controller.isLoading;
                    return ElevatedButton(
                      onPressed: isSearching ? null : () {
                        if (ufController.text.isNotEmpty &&
                            cidadeController.text.isNotEmpty &&
                            logradouroController.text.isNotEmpty) {
                          controller.searchCepByAddress(
                            ufController.text.trim(),
                            cidadeController.text.trim(),
                            logradouroController.text.trim(),
                          );
                           cepController.clear();
                        } else {
                           ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Por favor, preencha todos os campos de endereço.'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: controller.isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                   strokeWidth: 2,
                                ),
                              )
                            : Text('Buscar CEP por Endereço', style: TextStyle(fontSize: 16)),
                      ),
                    );
                 }
              ),

              SizedBox(height: 24),

              Observer(
                builder: (_) {
                  if (controller.isLoading) {
                    return Center(child: Container());
                  }

                  if (controller.addressList.isNotEmpty) {
                     return Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                            'Resultados encontrados:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                         ),
                         SizedBox(height: 8),
                         LimitedBox(
                            maxHeight: 400,
                            child: ListView.builder(
                               shrinkWrap: true,
                               physics: ClampingScrollPhysics(),
                               itemCount: controller.addressList.length,
                               itemBuilder: (context, index) {
                                 final address = controller.addressList[index];
                                 return AddressItem(
                                   title: address.cep ?? 'CEP não disponível',
                                   address: address.fullAddress,
                                   date: address.searchDate != null
                                       ? DateFormat('dd/MM/yyyy – HH:mm').format(address.searchDate!)
                                       : 'Data não disponível',
                                   onMapPressed: () {
                                     _openMap(address);
                                   },
                                    onTap: () {
                                       controller.selectAddressFromList(address);
                                    },
                                 );
                               },
                             ),
                         ),
                       ],
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
                           _openMap(controller.currentAddress!);
                        },
                      );
                  }

                  if (controller.lastAddress != null) {
                      return LastAddress(
                         address: controller.lastAddress!,
                          onMapPressed: () {
                           _openMap(controller.lastAddress!);
                          },
                      );
                  }

                  return EmptyAddress();
                },
              ),
             SizedBox(height: 16),
            ],
           ),
        ),
      ),
    );
  }
}