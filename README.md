# Fast Location

Aplicativo Flutter para consulta de CEP e endereço, com histórico de buscas e visualização no mapa.

## Pré-requisitos

Antes de começar, certifique-se de ter instalado:

* **Flutter SDK:** Versão compatível com o projeto (verificar no `pubspec.yaml`, `sdk: '>=2.19.6 <3.0.0'`). Você pode seguir o guia oficial de instalação do Flutter: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
* **Android Studio** ou **VS Code:** Com os plugins do Flutter e Dart instalados.
* Um dispositivo Android ou iOS (físico ou emulador/simulador) configurado para desenvolvimento.
* **Git:** Para clonar o repositório.

## Configuração Inicial

1.  Obtenha as dependências do projeto. Certifique-se de estar na pasta raiz do projeto (`fast_location/`):

    ```bash
    flutter pub get
    ```

2.  Execute o `build_runner` para gerar os arquivos `.g.dart` necessários para MobX e Hive. Rode este comando na pasta raiz do projeto:

    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

    Se estiver em desenvolvimento, você pode usar o modo `watch` para que ele rode automaticamente a cada mudança nos arquivos:

    ```bash
    flutter pub run build_runner watch --delete-conflicting-outputs
    ```

    ## Como Executar o Aplicativo

1.  Certifique-se de que um dispositivo Android ou iOS (emulador/simulador ou físico) esteja conectado e configurado para desenvolvimento.
2.  Na pasta raiz do projeto (`fast_location/`), execute o seguinte comando para rodar o aplicativo no dispositivo conectado:

    ```bash
    flutter run
    ```

    O Flutter irá construir e instalar o aplicativo no dispositivo, e ele será iniciado automaticamente.

    ## Estrutura do Projeto

O projeto segue uma estrutura modular e em camadas:

* `lib/`: Código fonte do aplicativo.
    * `http/`: Cliente HTTP (`dio`).
    * `routes/`: Definição de rotas.
    * `shared/`: Itens compartilhados (storage, etc.).
    * `modules/`: Dividido por funcionalidades (ex: `home/`).
        * `home/`: Módulo da tela principal de busca.
            * `components/`: Widgets reutilizáveis da tela Home.
            * `controller/`: Lógica de estado (MobX).
            * `model/`: Modelos de dados.
            * `page/`: A tela/página principal.
            * `repositories/`: Camada de acesso a dados (API e Storage).
            * `service/`: Lógica de negócio que coordena repositories e models.

## Funcionalidades

* Buscar endereço por CEP.
* Buscar CEPs por endereço (Logradouro, Cidade, Estado).
* Exibir o endereço atual e o último endereço buscado.
* Visualizar o endereço no mapa (abre rotas do local atual para o endereço).
* Histórico de buscas de endereços.