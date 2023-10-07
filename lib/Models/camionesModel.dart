class CamionesModel {
  String idCamion;
  String nameRuta;
  DateTime createdOn;
  String state;
  String locality;
  String createBy;
  DateTime updateOn;
  String numEconomico;

  CamionesModel(
      {this.idCamion,
      this.nameRuta,
      this.createdOn,
      this.state,
      this.locality,
      this.createBy,
      this.updateOn,
      this.numEconomico,
      });
}
