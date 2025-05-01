import '../../../shared/storage/app_storage.dart';
import '../model/address_model.dart';

class StorageRepository {
  Future<void> saveAddress(AddressModel address) async {
    final box = AppStorage.getAddressBox();
    final addressToSave = AddressModel(
       cep: address.cep,
       logradouro: address.logradouro,
       complemento: address.complemento,
       bairro: address.bairro,
       localidade: address.localidade,
       uf: address.uf,
       ibge: address.ibge,
       gia: address.gia,
       ddd: address.ddd,
       siafi: address.siafi,
       searchDate: address.searchDate ?? DateTime.now(),
       latitude: address.latitude,
       longitude: address.longitude,
    );
       await box.add(addressToSave);
  }

  List<AddressModel> getAddressHistory() {
    final box = AppStorage.getAddressBox();
    return box.values.toList();
  }

  AddressModel? getLastAddress() {
    final addresses = getAddressHistory();
    if (addresses.isEmpty) return null;
    return addresses.last;
  }

  Future<void> clearAddressHistory() async {
      final box = AppStorage.getAddressBox();
      await box.clear();
  }
}
