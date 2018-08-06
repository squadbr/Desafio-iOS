# Desafio-iOS
**Buscador de Notas de Filmes no OMDB**

**Arquitetura:**
Dividi o aplicativo numa arquitetura conhecida como n-tier, nas seguintes camadas:

- Presentation: inclui tudo aquilo que é relacionado a interface.
  - Essa camada é dividida em sub-camadas: views, viewcontrollers, manager e viewmodels.
  - Utilizei aqui o Model View Presenter (MVP), retirando da View (views/viewcontrollers) toda a lógica, consistindo apenas de atualização de interface. A manager (também conhecida como presenter) recebe essa responsabilidade, sendo responsável pelo uso dos serviços e retornando as viewmodels para a view.
- Services: inclui todas as regras de negócios e serviços.
  - Essa camada é composta basicamente pelo QueueManager (gerenciador de threads) e pelas services.
  - Todo o gerenciamento de threads é realizada pela service, sendo que todas as chamadas são executadas em background, e as callbacks são sempre executadas na main thread. Dessa forma, não é necessário se preocupar com threads em mais nenhuma parte do app. Vale lembrar que, desta forma, todas as chamadas de funções de outras camadas é executada de forma síncrona.
- Persistence: inclui tudo relacionado a persistência (como coredata, que não foi utilizado), e mecanismos de comunicação com a API.


**Targets**

**Testes**
