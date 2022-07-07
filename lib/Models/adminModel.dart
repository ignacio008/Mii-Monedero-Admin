class AdminModel{

  String id;
  String email;
  String nameLocal;
  String nameDueno;
  DateTime createdOn;
  String state;
  String locality;
  String code;
  String typeAdmin;
  int saldoTaquilla;
  String createBy;
  bool isSupended;
  String numberOwner;

  AdminModel({this.id, this.email, this.nameLocal, this.nameDueno, this.createdOn, this.state, this.locality, this.code, this.typeAdmin,this.saldoTaquilla,this.createBy,this.isSupended,this.numberOwner});


  AdminModel getUsuario(dynamic datos){

      final id_ = datos.data()['id'];
      final nameLocal_ = datos.data()['nombreLocal'] ?? '';
      final nameDueno_ = datos.data()['nombreDueño'] ?? '';
      final email_ = datos.data()['email'] ?? '';
      final createdOn_ = datos.data()['createdOn'];
      final locality_ = datos.data()['locality'] ?? '';
      final state_ = datos.data()['state'] ?? '';
      final typeAdmin_ = datos.data()['type'] ?? '';
      final saldoTaquilla_ = datos.data()['saldoTaquilla'] ?? '';
      
      final createBy_ = datos.data()['creadoPor'] ?? '';
      
      final isSupended_ = datos.data()['isSupended'] ?? '';
      final code_ = datos.data()['code'] ?? '';

      AdminModel usuariosModel = AdminModel(
        id: id_,
        nameDueno: nameDueno_,
        email: email_,
        createdOn: createdOn_.toDate(),
        nameLocal: nameLocal_,
        locality: locality_,
        state: state_,
        typeAdmin: typeAdmin_,
        saldoTaquilla: saldoTaquilla_,
        createBy:createBy_,
        
        isSupended:isSupended_,
        code:code_,
      );


    return usuariosModel;
  }
}