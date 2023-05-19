class DatabaseInterface{
  Future<String> register(String email, String pw) async{}
  Future<String> login(String email, String pw) async{}
  Future<String> reAuthenticateUser(String email, String pw) async{}
  Future<String> verifyEmail() async{}
  Future<String> changeEmail(String email) async{}
  Future<String> changePassword(String pw) async{}
  Future<String> sendResetPasswordEmail(String email) async{}
  String getUID() {}
  Future<void> signOut() async{}
}