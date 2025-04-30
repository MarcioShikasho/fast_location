import 'package:mobx/mobx.dart';
import '../model/address_model.dart';
import '../service/address_service.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final AddressService _service = AddressService();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  AddressModel? currentAddress;

  @observable
  AddressModel? lastAddress;

  _HomeControllerBase() {
    _loadLastAddress();
  }

  @action
  Future<void> searchCep(String cep) async {
    try {
      isLoading = true;
      errorMessage = null;
      
      currentAddress = await _service.searchAddressByCep(cep);
      lastAddress = currentAddress;
    } catch (e) {
      errorMessage = e.toString();
      currentAddress = null;
    } finally {
      isLoading = false;
    }
  }

  @action
  void _loadLastAddress() {
    lastAddress = _service.getLastAddress();
  }
}