# Avaliação-08

Problema de Programação Flutter: Consumo de API e ListView Dinâmica

### Contexto

Considere um cenário em que uma aplicação Flutter precisa buscar dados de uma API REST (por exemplo, uma lista de usuários, produtos ou notícias) e exibir o resultado em uma tela, usando um componente ListView que é alimentado dinamicamente pela resposta da requisição.

### Descrição do Problema

O aplicativo deve consumir uma API externa usando HTTP GET. Após obter a resposta (geralmente no formato JSON), deve converter os dados recebidos em uma lista de objetos do modelo definido no app e exibir essas informações em tempo real em uma tela por meio de um ListView estilizado.

### Exemplos de situações onde o problema ocorre:

Exibir uma lista de postagens de um blog.
Mostrar os resultados de uma busca por produtos em tempo real.
Carregar e listar usuários cadastrados e um sistema.

### Etapas do Problema

Fazer Requisição à API
Utilizar pacotes como http ou dio para enviar uma requisição HTTP GET.
Tratar respostas e possíveis erros (timeout, falta de internet, resposta inválida, etc.).
Decodificar o JSON retornado pela API.
Converter os dados do JSON em objetos do modelo definido (por exemplo, classe Usuario).
Ao receber e processar a resposta, atualizar o estado da tela para que o ListView apresente os dados.
Usar mecanismos de gerenciamento de estado (setState, Provider, Bloc, etc.) para garantir que a interface reaja à chegada dos dados.
Criar um widget ListView.builder no corpo da telaAlimentar o ListView com a lista de objetos obtida na resposta, exibindo widgets personalizados para cada item (por exemplo, cards com nome, descrição, imagem, etc.).

### Principais Desafios

Exibir um indicador de progresso enquanto aguarda a resposta.
Apresentar mensagens amigáveis em caso de falha na requisição.
Lidar com grandes volumes de dados sem travar a interface.
Recarregar a lista, se necessário (pull-to-refresh).

### Conclusão

Esse tipo de problema é recorrente em aplicações Flutter modernas, exigindo atenção ao ciclo de vida dos widgets, à gestão do estado e ao tratamento de diferentes cenários de rede e resposta. O domínio dessa integração permite criar aplicativos dinâmicos e reativos que realmente utilizam o potencial de APIs REST no ecossistema Flutter.

### Evidências

GitHub com fonte e print das Telas no decorrer da execução.
