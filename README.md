# Desafio-iOS
**Buscador de Notas de Filmes no OMDB**

**Arquitetura:**
Dividi o aplicativo numa arquitetura conhecida como n-tier, nas seguintes camadas:

- Presentation: inclui tudo aquilo que é relacionado a interface.
  - Essa camada é dividida em sub-camadas: views, viewcontrollers, manager e viewmodels.
  - Utilizei aqui o Model View Presenter (MVP), retirando da View (views/viewcontrollers) toda a lógica, consistindo apenas de atualização de interface. A manager (também conhecida como presenter) recebe essa responsabilidade, sendo responsável pelo uso dos serviços e retornando as viewmodels para a view.
- Services: inclui todas as regras de negócios e serviços.
  - Essa camada é composta basicamente pelo QueueManager (gerenciador de threads) e pelas services.
  - Todo o gerenciamento de threads é realizada pela service, sendo que todas as chamadas são executadas em background, e as callbacks são sempre executadas na main thread. Dessa forma, não é necessário se preocupar com threads em mais nenhuma parte do app.
- Persistence: inclui tudo relacionado a persistência (como coredata, que não foi utilizado), e mecanismos de comunicação com a API.

Além disso, é necessário um módulo que contenha os elementos comuns. Chamo aqui de Infrastructure.
- Infrastructure: Contém os elementos compartilhados entre as diferentes camadas, como por exemplo os modelos (entities) e úteis (ex.: conversão de date para string).


Observações:
- Existe uma manager para uma view controller. Ela conhece os módulos Infrastructure e Services, mas não conhece a UIKit.
- Todas as funções, exceto aquelas desenvolvidas no pacote Services, são executadas de forma síncrona (executadas na mesma thread em que foi chamada).
- Num Services, como não guardo referência de closures, não corro o risco de criar retain cycles, não sendo necessário uso de weak/unowned self.
- Só há interação entre camadas adjacentes, de forma unidirecional. Exemplos: A Presentation não conhece o módulo Persistence, apenas o módulo Services. Services não conhece a Presentation, apenas a Persistence.

**Targets**
Existem três configurações: Debug, Release e Test. Debug e Release já vem configurados automaticamente, e criei a configuração Test para apontar para um ambiente mockado de API. Dessa forma, mantenho as urls e tokens como configuração de projeto, e acesso essas informações via código, sem a necessidade de if/else.


**Testes**
Utilizei diversas formas de testes, de acordo com a camada correspondente.

- View/ViewControllers: Testes de UI (XCUITest).
- Manager: Testes unitários, com injeção de dependência.
- Services/Persistence: Testes integrados, simulando ambiente de produção com a utilização do Wiremock.

Para executar os testes, acesse a pasta Wiremock e execute o .jar wiremock.


**Considerações Finais**
- Preferi não utilizar frameworks/libs externas.
- Queria desenvolver diversas outras coisas, como por exemplo uma interface mais interessante, mas não consegui arranjar tempo :/
- Se tiverem curiosidade de como desenvolvo componentes visuais, vejam meu bitbucket https://bitbucket.org/marcosmko, venho desenvolvendo o aplicativo Ponto.

Espero que gostem!
Valeu!
