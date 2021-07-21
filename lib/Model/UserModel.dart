class User {
  int userId;
  String name;
  String email;
  String Long;
  String Lat;
  bool islogin;

  User({this.userId, this.name, this.email, this.Long, this.Lat,this.islogin });

  factory User.fromJson(Map<dynamic, dynamic> responseData) {
    return User(
      userId: responseData['ID'],
      name: responseData['Name'],
      email: responseData['Email'],
      Long: responseData['Long'],
      Lat: responseData['Lat'],

    );
  }
}