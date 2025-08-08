Projeto de Portfólio: Aplicação Barbearia Rei Du Corte
Visão Geral do Projeto
Esta aplicação foi desenvolvida como um projeto de freelancer para um cliente real, a barbearia "Rei Du Corte". O objetivo foi migrar a presença online do cliente de um website para uma aplicação móvel nativa, oferecendo uma experiência de utilizador mais rica e funcionalidades de agendamento direto.

Este repositório serve como uma demonstração das minhas competências em desenvolvimento de aplicações móveis com Flutter e na integração com serviços de backend como o Firebase.

Aviso Importante: A marca "Rei Du Corte", o seu logótipo e outros ativos visuais são propriedade do meu cliente. Este projeto está aqui exposto apenas para fins de portfólio. O código não se destina a ser replicado ou distribuído, e as chaves de API foram devidamente protegidas e removidas do repositório.

![Demonstração do App](app.gif)

✨ Funcionalidades Desenvolvidas
Sistema de Autenticação Completo: Implementação de um fluxo seguro de cadastro e login de utilizadores utilizando o Firebase Authentication.

Catálogo de Serviços Dinâmico: Visualização de serviços com imagens e preços, carregados em tempo real a partir do Cloud Firestore, permitindo ao cliente atualizar as ofertas sem precisar de modificar a aplicação.

Agendamento Interativo: Sistema de agendamento robusto com um calendário para seleção de datas e uma lista de horários disponíveis.

Gestão de Agendamentos Pessoais: Uma área dedicada onde cada utilizador pode visualizar os seus próximos agendamentos e cancelá-los, com as alterações a serem refletidas instantaneamente na base de dados.

Perfil de Utilizador Editável: Funcionalidade para os utilizadores verem e editarem as suas informações de perfil.

🛠️ Tecnologias e Arquitetura
Framework: Flutter

Linguagem: Dart

Base de Dados: Cloud Firestore (NoSQL em tempo real)

Autenticação: Firebase Authentication

Gestão de Chaves de API: Proteção de chaves sensíveis utilizando .env para segurança.

Arquitetura: Foco na separação de responsabilidades, com a lógica de interface (UI), serviços de backend e modelos de dados organizados em diferentes camadas.

🚀 Destaques Técnicos
Sincronização em Tempo Real: Utilização de Streams do Firestore para garantir que a interface da aplicação (como a lista de agendamentos) reage instantaneamente a qualquer alteração na base de dados, sem a necessidade de atualizações manuais.

Segurança: Implementação de regras de segurança no Firestore para garantir que um utilizador só possa aceder e modificar os seus próprios dados. As chaves de API foram removidas do controlo de versão e geridas através de variáveis de ambiente.

Componentização: Criação de widgets reutilizáveis, como o menu de navegação (AppDrawer), para manter um código limpo, organizado e de fácil manutenção.

Licença
O código-fonte deste projeto está sob a licença MIT.

**Licença**

Este projeto está sob a licença MIT. Veja o ficheiro [LICENSE](LICENSE) para mais detalhes.
