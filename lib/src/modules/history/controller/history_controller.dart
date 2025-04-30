import 'package:mobx/mobx.dart';
import '../../home/model/address_model.dart';
import '../../home/service/address_service.dart';

part 'history_controller.g.dart';

class HistoryController = _HistoryControllerBase with _$HistoryController;

abstract class _HistoryControllerBase with Store {
  final AddressService _service = AddressService();

  @observable
  ObservableList<AddressModel> addresses = ObservableList<AddressModel>();

  @action
  void loadAddresses() {
    addresses.clear();
    addresses.addAll(_service.getAddressHistory());
  }
}