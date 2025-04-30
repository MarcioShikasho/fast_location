import 'package:dio/dio.dart';
import '../../../http/http_client.dart';
import '../model/address_model.dart';

class AddressRepository {
  final HttpClient _client = HttpClient();
  
  Future<AddressModel> getAddressByCep(String cep) async {
    try {
      final response = await _client.client.get('/$cep/json/');
      return AddressModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception('Erro ao buscar endereço: ${e.message}');
    }
  }
}