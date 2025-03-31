# Demo
![pokedex](https://github.com/user-attachments/assets/ae8a3d7f-a4a3-438a-a123-64491e3e38a1)

# Overview
Esse é um aplicativo iOS que utiliza a API pública [Pokeapi](https://pokeapi.co) para a exibição de uma lista de pokemons e suas respectivas telas de detalhes.

# Dependências
Todas as dependência foram utilizadas via **Swift Package Manager**.
- [Snapkit](https://github.com/SnapKit/SnapKit): Utilizado para construção do autolayout com viewcode
- [FLAnimatedImage](https://github.com/Flipboard/FLAnimatedImage): Lib da Flipboard para a utilização de GIFs, foi utilizada nesse projeto para a construção da tela de Loading 

# Arquitetura
A arquitetura utilizada foi a **VIP**, que conta com os seguintes elementos

- **View**: Responsável pela exibição de todo o conteúdo visual para o usuário
- **Interactor**: Responsável pela lógica de negócio e interação
- **Presenter**: Responsável pro manipular o estado enviado pelo interactor, transformando-o no que a View irá exibir

  ![viparch](https://github.com/user-attachments/assets/19014d6b-414d-4b28-9ae0-77a54e61b161)

  Essa arquitetura funciona de maneira unidirecional, onde um elemento apenas conhece a existência do próximo.
  <p>Sendo assim, a View tem uma referência do Interactor, o Interactor tem uma referência do presenter, e o Presente tem um referência fraca da ViewController (impedindo assim problemas de referências cíclicas).
  Essa arquitetura permite uma boa separação de responsabilidades, e permite facil testabilidade.

# Testes
Os testes foram feitos com a biblioteca **XCTest**.

# Pontos a Melhorar
Alguns pontos que poderiam ser desenvolvidos para tornar esse projeto mais completo:
- Modularização de funcionalidades (List e Details) e módulos core, como Network, Design System, etc
- Utilização de SwiftGen para lidar com cores, espaçamentos, e imagens
- Utilização de biblioteca para simplificar a injeção de dependência, como Swinject
- Aumento da cobertura de testes, com testes para o Coordinator e snapshots de views
- Em caso de trabalho com equipes maiores, a utilização de ferramentas como XCodeGen ou Tuist para lidar com arquivos do tipo .pbxproj

