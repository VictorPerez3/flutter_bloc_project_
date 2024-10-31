class AppStrings {

  static const String apiUrl = 'https://empiricus-app.empiricus.com.br/mock/list.json';

  // Login Mockado
  static const String mockUsername = 'teste';
  static const String mockPassword = 'senha';

  // Validações de Login
  static const String fieldsEmpty = 'Os campos estão vazios';
  static const String usernameEmpty = 'O campo de usuário está vazio';
  static const String passwordEmpty = 'O campo de senha está vazio';
  static const String usernameTooShort = 'O usuário deve ter pelo menos 5 caracteres';
  static const String passwordTooShort = 'A senha deve ter pelo menos 5 caracteres';
  static const String invalidCredentials = 'Credenciais inválidas';

  // Labels de Login
  static const String usernameLabel = 'Usuário';
  static const String passwordLabel = 'Senha';
  static const String loginButton = 'Entrar';

  // Exceptions
  static const String networkExceptionMessage = 'Sem conexão com a internet.';
  static const String serverExceptionMessage = 'Falha na captação de dados pelo servidor.';
  static const String idNotFoundExceptionMessage = 'Item da lista não encontrado.';
}
