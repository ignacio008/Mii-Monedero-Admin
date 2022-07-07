import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monedero_admin/Firebase/fetch_data.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Models/CenserModel.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Models/salesModel.dart';
import 'package:monedero_admin/Models/scaneosModel.dart';
import 'package:monedero_admin/Models/stateCosto.dart';

import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;
import 'package:toast/toast.dart';

class DetailSuperAdmin extends StatefulWidget {
  AdminModel adminModel;
  CenserModel censerModel;
  DetailSuperAdmin({this.adminModel,this.censerModel});

  @override
  State<DetailSuperAdmin> createState() => _DetailSuperAdminState();
}

class _DetailSuperAdminState extends State<DetailSuperAdmin> {
  bool _showSpinner = false;
  String _fechaInicialString = "Inicio";
  String _fechaFinalString = "Fin";
  DateTime fechaInicial;
  DateTime fechaFinal;

List<ScaneosModel> scaneoList = [];

List<SalesModel> ventasScaneadas = [];
bool mensaje=false;

 void setSpinnerStatus(bool status){
    setState(() {
      _showSpinner = status;
    });
  }

  void _getPagoItems() async {

     setSpinnerStatus(true);
    final messages = await QuerysService().getAllScaneosByDate(fechaInicial: fechaInicial, fechaFinal: fechaFinal, idCamion:widget.censerModel.id);
     scaneoList = ScaneosModel().getScaner(messages.docs);

     if(scaneoList.length > 0){

       setSpinnerStatus(false);
    print("El scaneo es ${scaneoList.length}");
    
     }
     else{
       setSpinnerStatus(false);
       Toast.show("No se han encontrado Scaneos", context, duration: Toast.LENGTH_LONG);
       
       mensaje=true;
     }
   }
   void _geVentasActivaciones() async {

     setSpinnerStatus(true);
    final messages = await QuerysService().getAllVentasActivandoUsuarioByDate(fechaInicial: fechaInicial, fechaFinal: fechaFinal, idCamion:widget.censerModel.id);
     ventasScaneadas = SalesModel().getVentasActiv(messages.docs);

     if(ventasScaneadas.length > 0){

       setSpinnerStatus(false);
    print("El ventas es ${ventasScaneadas.length}");
     }
     else{
       setSpinnerStatus(false);
       Toast.show("No se han encontrado ventas", context, duration: Toast.LENGTH_LONG);
     }
   }
   List<StateCosto>stateCosto=[];

   void getTopChanele(String state)async{
    stateCosto = await FetchData().getStateCostp(widget.censerModel.state);
    var tamano= stateCosto.length;
    print("Mi estaod es ${widget.censerModel.state}");
    print("EL TAMAÑO DE LA LISTA ES de costo: ${tamano}");
    if(stateCosto.length > 0){

       setSpinnerStatus(false);
    print("El costo es ${stateCosto.length}");
     }
     else{
       setSpinnerStatus(false);
       //Toast.show("", context, duration: Toast.LENGTH_LONG);
     }
  }
  // void getCostos(){
  //    if(stateCosto.isEmpty){
      
  //                 StateCosto cuadro1= StateCosto(state:"E.U",locality:"E.U",costo:1000,costoPorPasaje:55 );
  //                 stateCosto.add(cuadro1);
  //                 print(stateCosto[0]);
  //                 }
  // }
  List<StateCosto>stateCostoVacion=[];
  void getCostosMios(){
     
      
                  StateCosto cuadro1= StateCosto(state:"E.U",locality:"E.U",costo:1000,costoPorPasaje:55 );
                  stateCostoVacion.add(cuadro1);
                  print(stateCostoVacion[0]);
                  
  }
  @override
  void initState() {
    
     getTopChanele(widget.censerModel.state);
     getCostosMios();
    // getCostos();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Detalle Chofer"
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Text(
                "${widget.censerModel.name}",
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              Text(
              "Datos Generales",
              style: TextStyle(
                  fontSize: 14.0,
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
              SizedBox(height:5.0),
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
                  _geVentasActivaciones();
                  // _buscarBalance(stateCosto[0]);
                    
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
    stateCosto.isEmpty? _balanceWidget(stateCostoVacion[0]):     _balanceWidget(stateCosto[0]),
            ],
          ),
        ),

        ),
        );
  }

  

   Widget _balanceWidget(StateCosto statecosto){
    var ingreso=ventasScaneadas.length*statecosto.costoPorPasaje;
    var scaneadaDeber=scaneoList.length*statecosto.costoPorPasaje;
    var resultado=ingreso-scaneadaDeber;
    if(scaneoList.length > 0){
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Flexible(
          child: GestureDetector(
      onTap: (){
        // sales.clear();
        // for(int i = 0; i < widget.salesList.length; i++){
        //   if(widget.salesList[i].idCamion == widget.salesModel.idCamion){
        //     sales.add(widget.salesList[i]);
        //   }
        // }
        // _showDetailsDialog();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(
                height: 20.0,
              ),
                    CircleAvatar(
                      child: Text(
                          widget.censerModel.name[0]
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "${widget.censerModel.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                    Text(
                      "Cuntos Scaneos realizo: ${scaneoList.length} ",
                      style: TextStyle(
                         fontWeight: FontWeight.w600,
                          fontSize: 14.0
                      ),
                    ),
                    Text(
                      "Cuanto le debo Scaneos: \$${scaneoList.length*statecosto.costoPorPasaje} MXN",
                      style: TextStyle(
                         fontWeight: FontWeight.w600,
                          fontSize: 14.0
                      ),
                    ),
                    Text(
                      "Cuantas ventas hizo :  ${ventasScaneadas.length}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Cuanto ingreso: \$${ventasScaneadas.length*statecosto.costoPorPasaje} MXN",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0
                      ),
                    ),
                    Text(
                        "Balance: "
                    ),
                    Text(
                      "Su saldo es de \$${resultado} MXN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color:resultado<=0?Colors.red:Colors.green,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
        ),
      );
    }
    else{
      return mensaje==false?Container():Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                        Icon(Icons.warning_amber_rounded, size:180, color:Colors.orange[600]),
                        Text(
              "Aun no cuentas con un Scaneo para hacer tu balance",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
                      ]),


                    );
    }
  }
}