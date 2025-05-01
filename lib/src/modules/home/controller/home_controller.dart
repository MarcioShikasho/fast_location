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

  @observable
  ObservableList<AddressModel> addressList = ObservableList<AddressModel>();

  _HomeControllerBase() {
    _loadLastAddress();
  }

  @action
  Future<void> searchCep(String cep) async {
    try {
      isLoading = true;
      errorMessage = null;
      addressList.clear();

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
  Future<void> searchCepByAddress(String uf, String localidade, String logradouro) async {
    try {
      isLoading = true;
      errorMessage = null;
      currentAddress = null;
      addressList.clear();

      final results = await _service.searchAddressByAddress(uf, localidade, logradouro);

      if (results.isNotEmpty) {
        addressList.addAll(results);
         errorMessage = null;
      } else {
        errorMessage = 'Nenhum CEP encontrado para o endereço informado.';
         addressList.clear();
      }

    } catch (e) {
       errorMessage = e.toString().replaceFirst('Exception: ', ''); 
       addressList.clear(); 
    } finally {
      isLoading = false;
    }
  }


  @action
  void _loadLastAddress() {
    lastAddress = _service.getLastAddress();
  }
  @action
  Future<void> selectAddressFromList(AddressModel address) async {
      currentAddress = address;
      addressList.clear();
      lastAddress = address; 
      await _service.saveAddressToHistory(address); 
  }

  @action
   Future<String?> getDirectionsUrlForAddress(AddressModel address) async {
       isLoading = true; 
       try {
           final url = await _service.findDirectionsToAddressUrl(address);
           return url;
       } catch (e) {
           print('Erro no Controller ao obter URL das direções: $e');
           return null;
       } finally {
           isLoading = false;
       }
   }
}