class CenserModel{

  String id;
  String name;
  String email;
  DateTime createdOn;
  String description;
  String services;
  String category;
  String addres;
  String openHours;
  String distanceTo;
  double latitude;
  double longitude;
  String state;
  String locality;
  String nameOwner;
  String numberOwner;
  bool suspended;
  String photos;

  String numUnidad;
  String placa;
  String photoPLaca;
  String photoLicencia;
  String nameRuta;
  String paraderoRuta;

  String photoCamion;
  int activacionesRestantes;

  CenserModel({this.id, this.name, this.nameOwner, this.suspended, this.numberOwner, this.email, this.createdOn, this.description, this.state, this.locality, this.services, this.category, this.addres, this.openHours, this.distanceTo, this.photos, this.latitude, this.longitude, this.numUnidad, this.placa, this.photoPLaca,this.photoLicencia,this.nameRuta,this.paraderoRuta,this.photoCamion,this.activacionesRestantes});
}

