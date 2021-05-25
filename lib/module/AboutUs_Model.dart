class aboutus{
  String about;
  String img;
  String termsandcond;


  aboutus({this.about, this.termsandcond,this.img});

  factory aboutus.fromJson(Map<String, dynamic> json) {
    return aboutus(
      about: json['TitleEn'] as String,
      termsandcond: json['TermsAndCond'] as String,
    );
  }
}