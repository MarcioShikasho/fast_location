import '../../../shared/storage/app_storage.dart';
import '../model/address_model.dart';

class StorageRepository {
  Future<void> saveAddress(AddressModel address) async {
    final box = AppStorage.getAddressBox();
    await box.add(address);
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
}