---

# Gerenciador de Tarefas


Um aplicativo simples de gerenciamento de tarefas desenvolvido em Flutter. Este aplicativo permite que os usuários criem, editem, marquem como concluídas e excluam tarefas. As tarefas são armazenadas localmente no dispositivo usando o pacote `shared_preferences`.

Link do video: https://youtu.be/R26mbvjgxkc
---

## Funcionalidades

- **Adicionar Tarefas**: Crie novas tarefas com um título e uma descrição.
- **Editar Tarefas**: Edite o título e a descrição das tarefas existentes.
- **Excluir Tarefas**: Remova tarefas que não são mais necessárias.
- **Armazenamento Local**: As tarefas são salvas localmente no dispositivo, permitindo que o usuário acesse suas tarefas mesmo sem conexão com a internet.
- **Tela de Splash**: Uma tela de splash inicial é exibida ao abrir o aplicativo, utilizando o pacote `easy_splash_screen`.

---

## Pacotes Utilizados

- **shared_preferences: ^2.0.11**: Para armazenar as tarefas localmente no dispositivo.
- **easy_splash_screen: ^1.0.1**: Para criar uma tela de splash inicial personalizada.
- **cupertino_icons: ^1.0.8**: Para utilizar ícones no estilo Cupertino (iOS).

---

## Como Executar o Projeto


1. **Clone o repositório**:
   ```bash
   git clone https://github.com/Claudemiro-Nogueira/todas_as_atividades_de_Felipe/tree/main/gerenciador_de_tarefas
   ```

2. **Navegue até o diretório do projeto**:
   ```bash
   cd gerenciador_de_tarefas
   ```

3. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

4. **Execute o aplicativo**:
   ```bash
   flutter run -d chrome
   ```
---


## Contribuição

Contribuições são bem-vindas! Se você quiser contribuir para este projeto, siga os passos abaixo:

1. Faça um fork do projeto.
2. Crie uma nova branch (`git checkout -b feature/nova-feature`).
3. Commit suas mudanças (`git commit -m 'Adicionando nova feature'`).
4. Faça push para a branch (`git push origin feature/nova-feature`).
5. Abra um Pull Request.

---


