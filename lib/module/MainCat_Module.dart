// import 'dart:convert';
//
// List<MainCatModel> newsModelFromJson(String str) => List<MainCatModel>.from(json.decode(str).map((x) => MainCatModel.fromJson(x)));
//
// String newsModelToJson(List<MainCatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class MainCatModel {
//   MainCatModel({
//     this.status,
//     this.data,
//   });
//
//   bool status;
//   List<Datum> data;
//
//   factory MainCatModel.fromJson(Map<String, dynamic> json) => MainCatModel(
//     status: json["status"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     this.TitleEn,
//     this.TitleAr,
//     this.DescriptionAr,
//     this.DescriptionEn,
//     this.Images,
//
//   });
//   String TitleEn;
//   String TitleAr;
//   String DescriptionAr;
//   String DescriptionEn;
//   String Images;
//
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     TitleEn: json["TitleEn"],
//     TitleAr: json["TitleAr"],
//     DescriptionAr: json["DescriptionAr"],
//     DescriptionEn: json["DescriptionEn"],
//     Images: json["Images"],
//
//   );
//
//   Map<String, dynamic> toJson() => {
//     "TitleEn": TitleEn,
//     "TitleAr": TitleAr,
//     "DescriptionAr": DescriptionAr,
//     "DescriptionEn": DescriptionEn,
//     "Images": Images,
//
//
//   };
// }
