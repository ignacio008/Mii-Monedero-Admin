class SalesModel{

  String id;
  String storeId;
  String nameStore;
  String categoryStore;
  DateTime dateTime;
  String userId;
  String nameUser;
  String numberOwner;
  String nameOwner;
  String state;
  String locality;
  int numberSales;
  
  String placa;
  String nameRuta;



  SalesModel({this.id, this.storeId, this.nameOwner, this.numberOwner, this.nameStore, this.categoryStore, this.dateTime, this.userId, this.nameUser, this.state, this.locality, this.numberSales,  this.placa,this.nameRuta,});


  
    List  <SalesModel> getVentasActiv(dynamic miInfo){
      List<SalesModel>iconmodelLits=[];

    
        for(var datos in miInfo){
      final id_ = datos.data()['id']?? null;
      final storeId_ = datos.data()['storeId']?? null;
      final nameOwner_ = datos.data()['nameOwner']?? null;
      final numberOwner_ =datos.data()['numberOwner']?? null;
      final nameStore_ =datos.data()['nameStore']?? null;
      final categoryStore_ =datos.data()['categoryStore']?? null;
      final dateTime_ =datos.data()['dateTime']?? null;
      final userId_ =datos.data()['userId']?? null;
      final nameUser_ =datos.data()['nameUser']?? null;
      final state_ =datos.data()['state']?? null;
      final locality_ =datos.data()['locality']?? null;
      final numberSales_ =datos.data()['numberSales']?? null;
      final placa_ =datos.data()['placa']?? null;
      final nameRuta_ =datos.data()['nameRuta']?? null;


      SalesModel scanerModel = SalesModel(
        id: id_,
        storeId: storeId_,
        nameOwner: nameOwner_,
        numberOwner:numberOwner_,
        nameStore:nameStore_,
        categoryStore:categoryStore_,
        dateTime: dateTime_== null ? null :dateTime_.toDate(),
        userId:userId_,
        nameUser:nameUser_,
        state:state_,
        locality:locality_,
        numberSales:numberSales_,
        placa:placa_,
        nameRuta:nameRuta_,
      );

       iconmodelLits.add(scanerModel);
}
      return iconmodelLits;
     }
}