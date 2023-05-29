import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monedero_admin/Firebase/fetch_data.dart';
import 'package:monedero_admin/Firebase/firebase_referencias.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Models/CenserModel.dart';
import 'package:monedero_admin/Models/activaciones_model.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Models/stateCosto.dart';
import 'package:monedero_admin/Models/ventas.dart';
import 'package:monedero_admin/Screens/detailSuperAdimn.dart';
import 'package:monedero_admin/Screens/editCenserScreen.dart';

import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;
import 'package:monedero_admin/Screens/mainScreen.dart';
import 'package:toast/toast.dart';

class CenserItem extends StatefulWidget {
  CenserModel censerModel;
  Function function;
  AdminModel adminmodel;
  CenserItem({this.censerModel, this.function, this.adminmodel});

  @override
  _CenserItemState createState() => _CenserItemState();
}

class _CenserItemState extends State<CenserItem> {
  bool _showSpinner = false;
  bool active = true;
  String dateUser = "";
  String formattedDate = "";
  int nuevoCosto;
  List<VentasModel> iconModelList = [];
  void getlista(String idusuario) async {
    iconModelList = await FetchData().getVentasCamionero(idusuario);
    setState(() {});
    print('Tengo ventas ${iconModelList.length} cards');
  }

  List<ActivacionesTotal> activacionTotal = [];

  void getlistaActivacion(String idusuarioMio, String namePrueba) async {
    print(idusuarioMio);
    activacionTotal = await FetchData().getActivaciones(idusuarioMio);
    print(
        'Tengo activaciones ${activacionTotal.length} ${idusuarioMio}cards${namePrueba}');
    print(idusuarioMio);
    setState(() {});
  }

  List<StateCosto> stateCosto = [];

  void getTopChanele(String state) async {
    stateCosto = await FetchData().getStateCostp(widget.censerModel.state);
    var tamano = stateCosto.length;
    print("Mi estaod es ${widget.censerModel.state}");
    print("EL TAMAÑO DE LA LISTA ES: ${tamano}");
  }

  String id_variable = "";
  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    id_variable =
        List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    return id_variable;
  }

  String id_variable2 = "";
  String generateRandomString2(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    id_variable2 =
        List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    return id_variable2;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlista(widget.censerModel.id);
    generateRandomString(12);
    generateRandomString2(15);
    print("Prueba del IDDDD${widget.censerModel.id}");
    getlistaActivacion(widget.censerModel.id, widget.censerModel.name);
    formattedDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(widget.censerModel.createdOn);

    // getTopChanele(widget.censerModel.state);
    print("Mi estaod es ${widget.censerModel.state}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          getTopChanele(widget.censerModel.state);

          // Navigator.push(
          //     this.context,
          //     MaterialPageRoute(
          //     builder: (context) => EditCenserScreen (censerModel: widget.censerModel, function: widget.function))
          // );

          widget.adminmodel.typeAdmin != "superAdmin"
              ? _showAlertoption(context)
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailSuperAdmin(
                          adminModel: widget.adminmodel,
                          censerModel: widget.censerModel)));
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  child: Text(widget.censerModel.name[0]),
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
                      widget.censerModel.nameRuta,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Text(
                      "Camionero: " + widget.censerModel.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.censerModel.email),
                    Text(
                      widget.censerModel.suspended == false
                          ? "Activo"
                          : "Suspendido",
                      style: TextStyle(
                        color: widget.censerModel.suspended == false
                            ? Color.fromARGB(255, 24, 148, 206)
                            : Colors.red,
                      ),
                    ),
                    Text(widget.censerModel.locality +
                        ", " +
                        widget.censerModel.state),
                    Text("Creado el " + formattedDate),
                    Text("Placa: " + widget.censerModel.placa),
                    Text("Numero de unidad: " + widget.censerModel.numUnidad),
                    Text(
                        "Activaciones Restantes:  ${widget.censerModel.activacionesRestantes}"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertSuspender(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "${widget.censerModel.suspended == false ? "Suspender Camion" : "Activar Camion"}",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        "¿Está seguro de querer ${widget.censerModel.suspended == false ? "Suspender este Camion" : "Activar este camion"}",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "Cancelar",
            style: TextStyle(
              fontSize: 16.0,
              color: MyColors.Colors.colorBackgroundDark,
              fontFamily: 'Barlow',
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            "Aceptar",
            style: TextStyle(
              fontSize: 16.0,
              color: MyColors.Colors.colorBackgroundDark,
              fontFamily: 'Barlow',
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            if (widget.censerModel.suspended == true) {
              QuerysService()
                  .UpdateSuspendedTrueCenser(idCenser: widget.censerModel.id);
              setState(() {
                widget.censerModel.suspended = false;
              });
            } else {
              QuerysService()
                  .UpdateSuspendedFalseCamion(idCenser: widget.censerModel.id);
              setState(() {
                widget.censerModel.suspended = true;
              });
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void _showAlertoption(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "Seleciona una opcion",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                print("La lista antes de ${stateCosto.length}");
                if (stateCosto.isEmpty) {
                  StateCosto cuadro1 = StateCosto(
                      state: "E.U",
                      locality: "E.U",
                      costo: 1000,
                      costoPorPasaje: 55);
                  stateCosto.add(cuadro1);
                }
                print("La lista despues de ${stateCosto.length}");
                _activaciones(context, widget.censerModel.id, stateCosto[0]);
              },
              padding:
                  EdgeInsets.only(left: 40, top: 17, right: 40, bottom: 17),
              child: Text("Recargar +12 activaciones"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.blue, width: 2.0),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "¿Está seguro de querer ${widget.censerModel.suspended == false ? "Suspender este Camion?" : "Activar este camion? "}",
              style: TextStyle(
                fontFamily: 'Barlow',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                if (widget.censerModel.suspended == true) {
                  QuerysService().UpdateSuspendedTrueCenser(
                      idCenser: widget.censerModel.id);
                  setState(() {
                    widget.censerModel.suspended = false;
                  });
                } else {
                  QuerysService().UpdateSuspendedFalseCamion(
                      idCenser: widget.censerModel.id);
                  setState(() {
                    widget.censerModel.suspended = true;
                  });
                }
                Navigator.of(context).pop();
              },
              padding:
                  EdgeInsets.only(left: 75, top: 17, right: 75, bottom: 17),
              child: Text(
                "${widget.censerModel.suspended == false ? "Suspender" : "Activar"}",
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.blue, width: 2.0),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text(
            "Cancelar",
            style: TextStyle(
              fontSize: 16.0,
              color: MyColors.Colors.colorBackgroundDark,
              fontFamily: 'Barlow',
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  _cancelSpinnerError() {
    setState(() {
      _showSpinner = false;
    });
  }

  _cancelSpinnerSuccesful() async {
    setState(() {
      _showSpinner = false;
    });

    setSpinnerStatus(false);
  }

  void setSpinnerStatus(bool status) {
    setState(() {
      _showSpinner = status;
    });
  }

  void _activaciones(
      BuildContext context, iconmodelActiva, StateCosto statecosto) async {
    print("ESTE EL IDDDDD DEL CENSER QUE STOY SELECIONANDO ${iconmodelActiva}");
    //          setSpinnerStatus(true);
    print(iconmodelActiva);
    print("tengo saldo ${widget.adminmodel.saldoTaquilla} ");
    print(widget.censerModel.id);
    DateTime now = DateTime.now();
    if (widget.adminmodel.saldoTaquilla <= 199) {
      Toast.show("Saldo insuficiente", context, duration: Toast.LENGTH_LONG);
    } else {
      bool erroguardar = await QuerysService().SaveGeneralInfoEstadoPago(
          reference: FirebaseReferencias.REFERENCE_EstadoPagoCamionero,
          id: id_variable,
          collectionValues: {
            'activaciones': false,
            'email': widget.censerModel.email,
            'fechaPago': now,
            'idCamion': widget.censerModel.id,
            'idPago': id_variable,
            'message':
                "Tu recarga se activara en 24 hrs despues de acreditar tu pago",
            'nameCamionero': widget.censerModel.name,
            'numeroCamionero': widget.censerModel.numberOwner,
            'placa': widget.censerModel.placa,
            'preferenceId': id_variable2,
            'status': "Aprobado",
          });
      if (erroguardar) {
        Toast.show(
            "Ha ocurrido un error, por favor, intente de nuevo activaciones",
            context,
            duration: Toast.LENGTH_LONG);
      } else {
          bool erroguardarActivacionesCenser = await QuerysService()
              .UpdateInfoActivacionesCenser(
                  reference: FirebaseReferencias.REFERENCE_CENSERS,
                  id: widget.censerModel.id,
                  collectionValues: {
                'activacionesRestantes':
                    widget.censerModel.activacionesRestantes + 12,
              });
          if (erroguardarActivacionesCenser) {
            Toast.show(
                "Ha ocurrido un error, por favor, intente de nuevo", context,
                duration: Toast.LENGTH_LONG);
          } else {
            bool erroguardarSadoActivaciones = await QuerysService()
                .UpdateInfoSaldoTaquilla(
                    reference: FirebaseReferencias.REFERENCE_ADMIN,
                    id: widget.adminmodel.id,
                    collectionValues: {
                  'saldoTaquilla':
                      widget.adminmodel.saldoTaquilla - statecosto.costo,
                });
            if (erroguardarSadoActivaciones) {
              Toast.show(
                  "Ha ocurrido un error, por favor, intente de nuevo", context,
                  duration: Toast.LENGTH_LONG);
            } else {
              setState(() {
                widget.adminmodel;
              });
              Toast.show(
                  "¡Se ha efectuado el pago con exito! Por favor de Reiniciar la aplicacion",
                  context,
                  duration: Toast.LENGTH_LONG);
              AdminModel adminmodel =
                  await FetchData().getAdmin(widget.adminmodel.id);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(
                            adminModel: adminmodel,
                          )));
            }
          }
        }
      }
      //     QuerysService().saveEstadoPagoCamionero(idCenser: id_variable, errorFunction: _cancelSpinnerError, function: _cancelSpinnerSuccesful(), context: context, collectionValues: {
      //   'activaciones':false,
      //   'email': widget.censerModel.email,
      //   'fechaPago': now,
      //   'idCamion': widget.censerModel.id,
      //   'idPago': id_variable,
      //   'message':"Tu recarga se activara en 24 hrs despues de acreditar tu pago" ,
      //   'nameCamionero': widget.censerModel.name,
      //   'numeroCamionero': widget.censerModel.numberOwner,
      //   'placa':widget.censerModel.placa,
      //   'preferenceId':id_variable2,
      //   'status':"Aprobado",
      // });
      //  QuerysService().saveActivacionesPagoCamionero(idCenser: widget.censerModel.id, errorFunction: _cancelSpinnerError, function: _cancelSpinnerSuccesful(), context: context, collectionValues: {

      //    'fechaNuevaVenta': now,
      //    'numeroActivacion':iconmodelActiva.numeroActivacion+12,
      //  });
      //    QuerysService().UpdateSaldoTaquillas(idCenser: widget.adminmodel.id, errorFunction: _cancelSpinnerError, function: _cancelSpinnerSuccesful(), context: context, collectionValues: {
      //    'saldoTaquilla':widget.adminmodel.saldoTaquilla-200,
      //  });
      //        Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => MainScreen (adminModel: widget.adminmodel)
      //     )
      // );

    }
  }

