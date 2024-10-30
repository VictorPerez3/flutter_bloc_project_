# 📋 Project Bloc Empiricus

- 👨‍💻 Desenvolvedor : Victor Vagner Perez
- Data de Desenvolvimento/Ultima modificação : 30/10/2024

# 1 - Sobre o aplicativo
- Aplicativo criado em flutter para dispositivos Android e IOS.
- Arquitetura BLOC
- Camada de Testes Unitários
- FVM - Gerenciamento de versões Flutter
- Autenticação mockada.
- Listagem de cards e detalhes.

# 2 - Telas

### 1) Splash Screen 🖼️

<img src="https://github.com/VictorPerez3/flutter_bloc_project_/blob/main/prints-doc/splash_screen.jpg" alt="Splash Screen" width="200"/>

### 2) Login Screen 🔒
Pagina de autenticação mock, onde inclui:
1. Usuário: teste.
2. Senha: senha
2. Validação e tratamento de erros.

<div style="display: flex; gap: 10px;">
  <img src="https://github.com/VictorPerez3/flutter_bloc_project_/blob/main/prints-doc/login_screen.jpg" alt="Login Screen" width="200"/>
  <img src="https://github.com/VictorPerez3/flutter_bloc_project_/blob/main/prints-doc/login_validator.jpg" alt="Login Validator" width="200"/>
</div>

### 2) Home Screen 📋
A tela apresenta uma lista CRUD de cards com nome, imagem e descrição.

<img src="https://github.com/VictorPerez3/flutter_bloc_project_/blob/main/prints-doc/home_screen.jpg" alt="Home Screen" width="200"/>

### 3) Details Screen 🗒️
A tela apresenta os detalhes do card selecionado. Apresenta nome, imagem e descrição.

<img src="https://github.com/VictorPerez3/flutter_bloc_project_/blob/main/prints-doc/details_screen.jpg" alt="Details Screen" width="200"/>

# 3 - Passos para clonar, configurar e executar o App 📜
### 1) Clonando o repositório através do terminal

```
git clone -b main https://github.com/VictorPerez3/xxxx.git
```

### 2) Configure a versão do flutter via fvm

```
fvm use 3.22.0
```

### 3) Baixe as dependências necessárias

```
fvm flutter pub get 
```

### 3) Execute o projeto

```
fvm flutter run
```

# 4 - Testes Unitários ⛓️‍💥

```
fvm flutter test
```