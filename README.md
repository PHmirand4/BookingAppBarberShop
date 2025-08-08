# Barbearia Rei Du Corte - App

Aplicação móvel desenvolvida em Flutter para a Barbearia Rei Du Corte, permitindo que os clientes visualizem os serviços, agendem horários e administrem os seus agendamentos.

### ✨ Funcionalidades

* ✅ Autenticação de utilizadores (Cadastro e Login) com Firebase Authentication.
* ✅ Visualização de serviços com imagens e preços, lidos em tempo real do Cloud Firestore.
* ✅ Sistema de agendamento com seleção de data e horário.
* ✅ Visualização e cancelamento de agendamentos pessoais.
* ✅ Edição do perfil do utilizador.
* ✅ Navegação intuitiva com menu lateral e barra de navegação inferior.

### 🛠️ Tecnologias Utilizadas

* **Flutter:** Framework para desenvolvimento de aplicações multiplataforma.
* **Firebase:**
    * **Authentication:** Para gestão de utilizadores.
    * **Cloud Firestore:** Como banco de dados NoSQL em tempo real.
* **Dart:** Linguagem de programação principal.

### 🚀 Como Executar o Projeto

Para executar este projeto localmente, siga estes passos:

1.  Clone o repositório: `git clone https://github.com/seu-usuario/barbearia-rei-du-corte-app.git`
2.  Entre na pasta do projeto: `cd barbearia-rei-du-corte-app`
3.  Instale as dependências: `flutter pub get`
4.  **Importante:** Este projeto utiliza Firebase. Para o conectar ao seu próprio projeto Firebase, você precisa de:
    * Criar um projeto no [console do Firebase](https://console.firebase.google.com/).
    * Adicionar o seu ficheiro `google-services.json` na pasta `android/app/`.
5.  Execute a aplicação: `flutter run`

---

**Licença**

Este projeto está sob a licença MIT. Veja o ficheiro [LICENSE](LICENSE) para mais detalhes.
