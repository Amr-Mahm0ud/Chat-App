class User {
  String name;
  String email;
  String password;
  String image;
  User({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
  });
}

Map<String, String> userData = {'name': '', 'email': '', 'password': ''};

User user = User(
    email: 'amr@gmail.com',
    name: 'Amr Mahmoud',
    password: '123456',
    image: 'assets/images/user_2.png');
