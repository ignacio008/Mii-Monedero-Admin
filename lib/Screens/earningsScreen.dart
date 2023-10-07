import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monedero_admin/Firebase/fetch_data.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Items/salesItem.dart';
import 'package:monedero_admin/Models/pagoModelItem.dart';
import 'package:monedero_admin/Models/salesModel.dart';
import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;
import 'package:toast/toast.dart';

class EarningsScreen extends StatefulWidget {
  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {

  String _fechaInicialString = "Inicio";
  String _fechaFinalString = "Fin";
  List<SalesModel> earningsList = [];
  List<SalesModel> earningsListNoFiltered = [];
  
  
  List<PagoModelItem> earningsListPago = [];
  List<PagoModelItem> earningsListNoFiltered3 = [];
  bool _showSpinner = false;
  DateTime fechaInicial;
  DateTime fechaFinal;
  
   void _getSales() async {

     setSpinnerStatus(true);
     final messages = await QuerysService().getAllSalesByDate(fechaInicial: fechaInicial, fechaFinal: fechaFinal);
     earningsList = _getSalesItem(messages.docs);

     if(earningsList.length > 0){

       setSpinnerStatus(false);

     }
     else{
       setSpinnerStatus(false);
       Toast.show("No se han encontrado censers", context, duration: Toast.LENGTH_LONG);
     }
   }


void _getPagoItems() async {

     setSpinnerStatus(true);
     final messages = await QuerysService().getAllPagosByDate(fechaInicial: fechaInicial, fechaFinal: fechaFinal);
     earningsListPago = _getPagoItem(messages.docs);

     if(earningsListPago.length > 0){

       setSpinnerStatus(false);

     }
     else{
       setSpinnerStatus(false);
       Toast.show("No se han encontrado censers", context, duration: Toast.LENGTH_LONG);
     }
   }

  List<SalesModel> _getSalesItem(dynamic miInfo){

    List<SalesModel> miInfoList = [];

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

    for(var datos in miInfo) {
      final id_ = datos.data()['id'];
      final storeId = datos.data()['storeId'] ?? '';
      final nameStore = datos.data()['nameStore'] ?? '';
      final dateTime = datos.data()['dateTime'];
      final categoryStore = datos.data()['categoryStore'] ?? '';
      final userId = datos.data()['userId'] ?? '';
      final nameUser = datos.data()['nameUser'] ?? '';
      final numberOwner = datos.data()['numberOwner'] ?? '';
      final nameOwner = datos.data()['nameOwner'];
      final state = datos.data()['state'];
      final locality = datos.data()['locality'] ?? '';
      final placa_ = datos.data()['placa']??'';
      final nameRuta_ = datos.data()['nameRuta']??'';


      int numberSales = 1;

      bool isSaved = false;
      for(int i = 0; i < miInfoList.length; i++){
        if(storeId == miInfoList[i].storeId){
          numberSales = miInfoList[i].numberSales++;
          isSaved = true;
        }
      }

      SalesModel salesModel = SalesModel(
        id: id_,
        storeId: storeId,
        nameStore: nameStore,
        dateTime: dateTime.toDate(),
        categoryStore: categoryStore,
        userId: userId,
        nameUser: nameUser,
        numberOwner: numberOwner,
        nameOwner: nameOwner,
        state: state,
        locality: locality,
        numberSales: numberSales,
        placa:placa_,
        nameRuta:nameRuta_,
      );

      if(!isSaved){
        miInfoList.add(salesModel);
      }

      earningsListNoFiltered.add(salesModel);

    }
    return miInfoList;
  }


  List<PagoModelItem> _getPagoItem(dynamic miInfo){

    List<PagoModelItem> miInfoList = [];

    String idPago;
  String idCamion;
  int numeroPago;
  DateTime fechaPago;
  String nameCamionero;
  String email;
  String numeroCamionero;
  String placa;
  
    int numberSales;

     for(var datos in miInfo){
      final idPago_ = datos.data()['idPago']?? null;
      final idCamion_ = datos.data()['idCamion']?? null;
      final numeroPago_ = datos.data()['numeroPago']?? null;
      final fechaPago_ =datos.data()['fechaPago']?? null;
      final nameCamionero_ =datos.data()['nameCamionero']?? null;
      final email_ =datos.data()['email']?? null;
      final numeroCamionero_ =datos.data()['numeroCamionero']?? null;
      final placa_ =datos.data()['placa']?? null;


      int numberSales = 1;

      bool isSaved = false;
      for(int i = 0; i < miInfoList.length; i++){
        if(idCamion_ == miInfoList[i].idCamion){
          print("verdadero");
          numberSales = miInfoList[i].numberSales++;
          isSaved = true;

        }else{
          print("falso");
        }
      }

      PagoModelItem pagoModel = PagoModelItem(
        idPago: idPago_,
        idCamion: idCamion_,
        numeroPago: numeroPago_,
        fechaPago: fechaPago_== null ? null :fechaPago_.toDate(),
        nameCamionero:nameCamionero_,
        email:email_,
        numeroCamionero:numeroCamionero_,
        placa:placa_,
        numberSales:numberSales,
      );

      if(!isSaved){
        miInfoList.add(pagoModel);
      }

      earningsListNoFiltered3.add(pagoModel);

    }
    return miInfoList;
  }











  void setSpinnerStatus(bool status){
    setState(() {
      _showSpinner = status;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Ventas"
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Mii Monedero Cuentas",
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Filtrar por fecha",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        var dateC = new DateTime.now();
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');

                              int dia = date.day;
                              int mes = date.month;
                              int anio = date.year;

                              int hora = 23;
                              int minutos = date.minute;

                              String am_pm = "";
                              if(hora >= 12){
                                am_pm = "pm";
                                hora = hora - 12;
                              }
                              else{
                                am_pm = "am";
                              }
                              //getReservaciones(_fechaString);
                              setState(() {
                                _fechaInicialString = "$dia/$mes/$anio";
                                fechaInicial = DateFormat("dd/MM/yyyy").parse(_fechaInicialString);

                              });
                            }, currentTime: dateC, locale: LocaleType.es);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                _fechaInicialString,
                                style: TextStyle(
                                    fontFamily: 'Futura',
                                  color: MyColors.Colors.colorRedBackgroundDark,
                                ),
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: MyColors.Colors.colorRedBackgroundDark,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: GestureDetector(
                        onTap: (){
                          var dateC = new DateTime.now();
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');

                                int dia = date.day;
                                int mes = date.month;
                                int anio = date.year;

                                int hora = 23;
                                int minutos = date.minute;

                                String am_pm = "";
                                if(hora >= 12){
                                  am_pm = "pm";
                                  hora = hora - 12;
                                }
                                else{
                                  am_pm = "am";
                                }
                                setState(() {
                                  _fechaFinalString = "$dia/$mes/$anio";
                                  fechaFinal = DateFormat("dd/MM/yyyy").parse(_fechaFinalString);

                                });
                              }, currentTime: dateC, locale: LocaleType.es);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  _fechaFinalString,
                                  style: TextStyle(
                                    fontFamily: 'Futura',
                                    color: MyColors.Colors.colorRedBackgroundDark,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: MyColors.Colors.colorRedBackgroundDark,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: (){
                  if(_fechaInicialString != "Inicio" && _fechaFinalString != "Fin"){
                    _getPagoItems();
                  }
                  else{
                    Toast.show("Debe ingresar un rango de fechas para poder buscar", context, duration: Toast.LENGTH_LONG);
                  }
                },
                child: Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      "BUSCAR",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: MyColors.Colors.colorRedBackgroundDark
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              _earningsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _earningsList(){

    if(earningsListPago.length > 0){
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Flexible(
          child: ListView.builder(
              itemCount: earningsListPago.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return SalesItem(salesModel: earningsListPago[index], salesList: earningsListNoFiltered3);
              }
          ),
        ),
      );
    }
    else{
      return Container();
    }
  }
}
