import 'package:flutter/material.dart';
import 'package:monedero_admin/Firebase/authentication.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Screens/censersScreen.dart';
import 'package:monedero_admin/Screens/earningsScreen.dart';
import 'package:monedero_admin/Screens/loginScreen.dart';
import 'package:monedero_admin/Screens/screenCamiones.dart';
import 'package:monedero_admin/Screens/taquillaAdmin.dart';
import 'package:monedero_admin/Screens/usersScreen.dart';
import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;
import 'package:toast/toast.dart';

class MainScreen extends StatefulWidget {
  AdminModel adminModel;
  MainScreen({this.adminModel});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final double barHeight = 50.0;
  TextEditingController _controllerCode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _controllerCode = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerCode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: statusbarHeight),
              height: statusbarHeight + barHeight,
              child: Center(
                child: Text(
                  "Mii Monedero Cuentas",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      MyColors.Colors.colorRedBackgroundDark,
                      MyColors.Colors.colorRedBackgroundLight
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Bienvenido ${widget.adminModel.typeAdmin != "superAdmin" ? "Taquilla" : "admin"}",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.adminModel.nameLocal,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                _showAlertCerrarSesion();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.Colors.colorRedBackgroundDark,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Cerrar Sesión",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Seleccione una opción",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Expanded(
              flex: 1,
              child: Container(
               constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.72 ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Column(
                          children: [
                           
                            Center(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.99,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CensersScreen(widget
                                                              .adminModel)));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  left: 10.0,
                                                  right: 10.0,
                                                  bottom: 5.0),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.19,
                                                width:
                                                    widget.adminModel
                                                                .typeAdmin !=
                                                            "superAdmin"
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.75
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.41,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    color: Colors.red[300]),
                                                child: Icon(
                                                  Icons.account_balance,
                                                  size: 50.0,
                                                  color: MyColors.Colors
                                                      .colorRedBackgroundDark,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Administrar Choferes",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          widget.adminModel.typeAdmin !=
                                                  "superAdmin"
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UsersScreen()));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0,
                                                            left: 10.0,
                                                            right: 10.0,
                                                            bottom: 5.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.19,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.41,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          color:
                                                              Colors.red[300]),
                                                      child: Icon(
                                                        Icons
                                                            .supervisor_account,
                                                        size: 50.0,
                                                        color: MyColors.Colors
                                                            .colorRedBackgroundDark,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          widget.adminModel.typeAdmin !=
                                                  "superAdmin"
                                              ? Container()
                                              : Text(
                                                  "Ver Usuarios",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.99,
                                height:
                                   widget.adminModel.typeAdmin !=
                                                "superAdmin"
                                            ? MediaQuery.of(context).size.height * 0
                                            :  MediaQuery.of(context).size.height * 0.24,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        widget.adminModel.typeAdmin !=
                                                "superAdmin"
                                            ? Container()
                                            : GestureDetector(
                                                onTap: () {
                                                  if (widget.adminModel.code
                                                          .length >
                                                      0) {
                                                    _showAlertCodeSales();
                                                  } else {
                                                    Toast.show(
                                                        "No tienes acceso a esta sección",
                                                        context,
                                                        duration:
                                                            Toast.LENGTH_LONG);
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 10.0,
                                                          right: 10.0,
                                                          bottom: 5.0),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.19,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.41,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        color: Colors.red[300]),
                                                    child: Icon(
                                                      Icons.attach_money,
                                                      size: 50.0,
                                                      color: MyColors.Colors
                                                          .colorRedBackgroundDark,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        widget.adminModel.typeAdmin !=
                                                "superAdmin"
                                            ? Container()
                                            : Text(
                                                "Ver Ventas",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                      ],
                                    ),
                                    Column(children: [
                                      widget.adminModel.typeAdmin !=
                                              "superAdmin"
                                          ? Container()
                                          : GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TaquillaAdmin(widget
                                                                .adminModel)));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0,
                                                    left: 10.0,
                                                    right: 10.0,
                                                    bottom: 5.0),
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.19,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.41,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      color: Colors.red[300]),
                                                  child: Icon(
                                                    Icons.add_business_rounded,
                                                    size: 50.0,
                                                    color: MyColors.Colors
                                                        .colorRedBackgroundDark,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      widget.adminModel.typeAdmin !=
                                              "superAdmin"
                                          ? Container()
                                          : Text(
                                              "Ver Taquillas",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                   GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ScreenCamiones(
                                                        widget.adminModel)));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0,
                                            left: 10.0,
                                            right: 10.0,
                                            bottom: 5.0),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.17,
                                          width: widget.adminModel.typeAdmin !=
                                                  "superAdmin"
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.82,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Colors.red[300]),
                                          child: Icon(
                                            Icons.bus_alert,
                                            size: 50.0,
                                            color: MyColors
                                                .Colors.colorRedBackgroundDark,
                                          ),
                                        ),
                                      ),
                                    ),
                               Text(
                                      "Camiones",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: widget.adminModel.typeAdmin == "superAdmin"
            ? Container()
            : FloatingActionButton.extended(
                onPressed: () {
                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterTaquilla(widget.adminModel)));
                },
                label: Text('Saldo: ${widget.adminModel.saldoTaquilla}'),
                icon: const Icon(Icons.add_business_rounded),
                backgroundColor: widget.adminModel.saldoTaquilla <= 199
                    ? Colors.red[600]
                    : Colors.green[600],
              ));
  }

  void _showAlertCodeSales() {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "Autenticación",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Para acceder a esta sección debe ingresar su código de super administrador",
            style: TextStyle(
              fontFamily: 'Barlow',
              fontWeight: FontWeight.w500,
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: _controllerCode,
            obscureText: true,
          ),
        ],
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
            FocusScope.of(context).requestFocus(FocusNode());
            if (_controllerCode.text == widget.adminModel.code) {
              _controllerCode.text = "";
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EarningsScreen()));
            } else {
              Toast.show("Código inválido", context);
            }
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

  void _showAlertCerrarSesion() {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "Cerrar Sesión",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        "¿Está seguro de querer cerrar sesión?",
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
            Authentication().singOut();
            Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
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
}
