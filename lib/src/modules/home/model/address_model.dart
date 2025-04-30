import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 0)
class AddressModel extends HiveObject {
  
  @HiveField(0)
  String? cep;
  
  @HiveField(1)
  String? logradouro;
  
  @HiveField(2)
  String? complemento;
  
  @HiveField(3)
  String? bairro;
  
  @HiveField(4)
  String? localidade;
  
  @HiveField(5)
  String? uf;
  
  @HiveField(6)
  String? ibge;
  
  @HiveField(7)
  String? gia;
  
  @HiveField(8)
  String? ddd;
  
  @HiveField(9)
  String? siafi;
  
  @HiveField(10)
  DateTime? searchDate;
  
  AddressModel({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
    this.searchDate,
  });
  
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: json['cep'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      ibge: json['ibge'],
      gia: json['gia'],
      ddd: json['ddd'],
      siafi: json['siafi'],
      searchDate: DateTime.now(),
    );
  }
  
  String get fullAddress {
    return '$logradouro, $bairro, $localidade - $uf, $cep';
  }
}