import '../model/address_model.dart';
import '../repositories/address_repository.dart';
import '../repositories/storage_repository.dart';

class AddressService {
  final AddressRepository _addressRepository = AddressRepository();
  final StorageRepository _storageRepository = StorageRepository();
  
  Future<AddressModel> searchAddressByCep(String cep) async {
    // Remove caracteres não numéricos
    final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanCep.length != 8) {
      throw Exception('CEP inválido. Digite 8 números.');
    }
    
    final address = await _addressRepository.getAddressByCep(cleanCep);
    
    if (address.cep == null) {
      throw Exception('CEP não encontrado.');
    }
    
    await _storageRepository.saveAddress(address);
    return address;
  }
  
  List<AddressModel> getAddressHistory() {
    return _storageRepository.getAddressHistory().reversed.toList();
  }
  
  AddressModel? getLastAddress() {
    return _storageRepository.getLastAddress();
  }
}