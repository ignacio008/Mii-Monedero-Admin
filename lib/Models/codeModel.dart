class CodeModel{

  String id;
  String locality;
  String state;
  String idCamionero;
  // String dateTime;

  CodeModel({this.id,this.locality,this.state });

  Map<String, dynamic> toMap() => {
    'id': id,
    'locality':locality,
    'state':state
  };
}