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

  Future<List<AddressModel>> getAddressByAddress(String uf, String localidade, String logradouro) async {
    try {
      // Codificar os parâmetros para a URL para evitar problemas com espaços e caracteres especiais
      final encodedLogradouro = Uri.encodeComponent(logradouro);
      final encodedLocalidade = Uri.encodeComponent(localidade);

      // Construir a URL para busca por endereço (Exemplo ViaCEP)
      // Utilizando a base URL configurada no HttpClient
      final url = '/$uf/$encodedLocalidade/$encodedLogradouro/json/';

      final response = await _client.client.get(url);

      if (response.statusCode == 200) {
        // A busca por endereço na ViaCEP retorna uma LISTA de objetos JSON
        if (response.data is List) {
          List<dynamic> data = response.data;
          if (data.isEmpty) {
             return []; // Retorna lista vazia se nenhum endereço for encontrado
           }
          // Mapear a lista de resultados JSON para uma lista de AddressModel
          return data.map((item) {
             // Você pode adicionar validações aqui se necessário para cada item
             return AddressModel.fromJson(item);
          }).toList();
        } else {
           // Tratar caso a API retorne um formato inesperado (não uma lista)
           // Isso pode ser um erro da API ou um retorno de erro formatado de outra forma
            if (response.data != null && response.data is Map<String, dynamic> && response.data.containsKey('erro')) {
                 throw Exception('Endereço não encontrado na API.'); // Ou uma mensagem mais específica
            }
           throw Exception('Formato de resposta inesperado da API de busca por endereço.');
        }
      } else {
         // Tratar outros códigos de status de resposta HTTP
        throw Exception('Erro na API ao buscar endereço: Status ${response.statusCode}');
      }
    } on DioError catch (e) {
       // Tratar erros de comunicação específicos do Dio
       throw Exception('Erro de comunicação ao buscar endereço: ${e.message}');
    } catch (e) {
       // Tratar outros erros inesperados
       throw Exception('Erro inesperado ao buscar endereço: $e');
    }
  }
}