// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_HomeControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_HomeControllerBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$currentAddressAtom =
      Atom(name: '_HomeControllerBase.currentAddress', context: context);

  @override
  AddressModel? get currentAddress {
    _$currentAddressAtom.reportRead();
    return super.currentAddress;
  }

  @override
  set currentAddress(AddressModel? value) {
    _$currentAddressAtom.reportWrite(value, super.currentAddress, () {
      super.currentAddress = value;
    });
  }

  late final _$lastAddressAtom =
      Atom(name: '_HomeControllerBase.lastAddress', context: context);

  @override
  AddressModel? get lastAddress {
    _$lastAddressAtom.reportRead();
    return super.lastAddress;
  }

  @override
  set lastAddress(AddressModel? value) {
    _$lastAddressAtom.reportWrite(value, super.lastAddress, () {
      super.lastAddress = value;
    });
  }

  late final _$addressListAtom =
      Atom(name: '_HomeControllerBase.addressList', context: context);

  @override
  ObservableList<AddressModel> get addressList {
    _$addressListAtom.reportRead();
    return super.addressList;
  }

  @override
  set addressList(ObservableList<AddressModel> value) {
    _$addressListAtom.reportWrite(value, super.addressList, () {
      super.addressList = value;
    });
  }

  late final _$searchCepAsyncAction =
      AsyncAction('_HomeControllerBase.searchCep', context: context);

  @override
  Future<void> searchCep(String cep) {
    return _$searchCepAsyncAction.run(() => super.searchCep(cep));
  }

  late final _$searchCepByAddressAsyncAction =
      AsyncAction('_HomeControllerBase.searchCepByAddress', context: context);

  @override
  Future<void> searchCepByAddress(
      String uf, String localidade, String logradouro) {
    return _$searchCepByAddressAsyncAction
        .run(() => super.searchCepByAddress(uf, localidade, logradouro));
  }

  late final _$selectAddressFromListAsyncAction = AsyncAction(
      '_HomeControllerBase.selectAddressFromList',
      context: context);

  @override
  Future<void> selectAddressFromList(AddressModel address) {
    return _$selectAddressFromListAsyncAction
        .run(() => super.selectAddressFromList(address));
  }

  late final _$getDirectionsUrlForAddressAsyncAction = AsyncAction(
      '_HomeControllerBase.getDirectionsUrlForAddress',
      context: context);

  @override
  Future<String?> getDirectionsUrlForAddress(AddressModel address) {
    return _$getDirectionsUrlForAddressAsyncAction
        .run(() => super.getDirectionsUrlForAddress(address));
  }

  late final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase', context: context);

  @override
  void _loadLastAddress() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase._loadLastAddress');
    try {
      return super._loadLastAddress();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
currentAddress: ${currentAddress},
lastAddress: ${lastAddress},
addressList: ${addressList}
    ''';
  }
}
