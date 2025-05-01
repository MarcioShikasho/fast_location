import '../model/address_model.dart';
import '../repositories/address_repository.dart';
import '../repositories/storage_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressService {
  final AddressRepository _addressRepository = AddressRepository();
  final StorageRepository _storageRepository = StorageRepository();
  
  Future<void> _geocodeAddress(AddressModel address) async {
    if (address.fullAddress.isNotEmpty) {
      try {
        List<Location> locations = await locationFromAddress(address.fullAddress);

        if (locations.isNotEmpty) {
          Location location = locations.first;
          address.latitude = location.latitude;
          address.longitude = location.longitude;
           print('Geocoding bem-sucedido: ${address.latitude}, ${address.longitude}'); 
        } else {
           print('Geocoding não encontrou resultados para: ${address.fullAddress}');
        }
      } catch (e) {
        print('Erro durante o geocoding de ${address.fullAddress}: $e'); 
      }
    }
  }

  Future<AddressModel> searchAddressByCep(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanCep.length != 8) {
      throw Exception('CEP inválido. Digite 8 números.');
    }
    
    final address = await _addressRepository.getAddressByCep(cleanCep);

    await _geocodeAddress(address);
    await _storageRepository.saveAddress(address);

    if (address.cep == null) {
      throw Exception('CEP não encontrado.');
    }   
    await _storageRepository.saveAddress(address);
    return address;
  }

  Future<List<AddressModel>> searchAddressByAddress(String uf, String localidade, String logradouro) async {
    
     if (uf.isEmpty || localidade.isEmpty || logradouro.isEmpty) {
       throw Exception('Por favor, preencha todos os campos de endereço.');
     }
      if (uf.length != 2) {
        throw Exception('UF inválida. Digite a sigla do estado (ex: SP).');
      }
       final List<AddressModel> addresses = await _addressRepository.getAddressByAddress(uf, localidade, logradouro);
       await Future.wait(addresses.map((address) => _geocodeAddress(address)));
       return addresses;
  }

   List<AddressModel> getAddressHistory() {
    return _storageRepository.getAddressHistory().reversed.toList();
  }

  AddressModel? getLastAddress() {
    return _storageRepository.getLastAddress();
  }

   Future<void> saveAddressToHistory(AddressModel address) async {
       if (address.latitude == null || address.longitude == null || (address.latitude == 0.0 && address.longitude == 0.0)) {
            await _geocodeAddress(address);
       }
       await _storageRepository.saveAddress(address);
   }
   Future<String?> findDirectionsToAddressUrl(AddressModel address) async {
      String origin = 'My Location';
      String destination;

      if (address.latitude != null && address.longitude != null && (address.latitude != 0.0 || address.longitude != 0.0)) {
         destination = '${address.latitude},${address.longitude}';
      } else {
         destination = address.fullAddress;
         print('Usando string de endereço para destino, coordenadas não disponíveis.');
      }
      final String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&origin=${Uri.encodeComponent(origin)}&destination=${Uri.encodeComponent(destination)}&travelmode=driving';
      if (await canLaunch(googleMapsUrl)) {
         return googleMapsUrl;
      } else {
         print('Não foi possível construir um URL de mapa lançável.'); // Para depuração
         return null;
      }
   }
}
