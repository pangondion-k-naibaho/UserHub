class User{
  final int id;
  final String email;
  final String password;
  final String? username;

  User({required this.id, required this.email, required this.password, this.username});

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'email' : email,
      'password' : password,
      'username' : username
    };
  }

  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id: map['id'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
      username: map['username'] as String
    );
  }
}