import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monedero_admin/Firebase/authentication.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Models/localitiesModel.dart';

import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;
import 'package:toast/toast.dart';

import '../Models/stateModel.dart';

class AddCamiones extends StatefulWidget {
  AdminModel adminModel;
  Function function;
  AddCamiones(this.adminModel,this.function);

  @override
  State<AddCamiones> createState() => _AddCamionesState();
}

class _AddCamionesState extends State<AddCamiones> {
  double screenHeight;
  TextEditingController _nameController;
  String _state = "Estado";
  String _locality = "Municipio";
  bool _showSpinner = false;
  String myId;
  DateTime _now;
  DateTime _yesterday;
  String myUrl;
  
String id_variable="";


  List<StateModel> stateList = [];
  List<LocalityModel> localityList = [];
  List<LocalityModel> localityListFiltered = [];

  Future<String> _loadASmaeAsset() async {
    return await rootBundle.loadString('assets/estados.json');
  }

  loadStates() async {
    String jsonString = await _loadASmaeAsset();
    var jsonResponse = json.decode(jsonString) as List;

    stateList = jsonResponse.map((i) => StateModel.fromJson(i)).toList();

    loadLocalities();
  }

  Future<String> _loadLocalitiesAsset() async {
    return await rootBundle.loadString('assets/result.json');
  }

  loadLocalities() async {
    String jsonString = await _loadLocalitiesAsset();
    var jsonResponse = json.decode(jsonString) as List;

    localityList = jsonResponse.map((i) => LocalityModel.fromJson(i)).toList();
  }
  String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  id_variable= List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  return id_variable;
}

  @override
  void initState() {
    // TODO: implement initState
    loadStates();

    generateRandomString(10);
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _nameController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      MyColors.Colors.colorRedBackgroundDarkF,
                      Colors.red[800]
                    ],
                    end: FractionalOffset.topCenter,
                    begin: FractionalOffset.bottomCenter,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.repeated),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: screenHeight,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Text(
                        "REGÍSTRAR CAMIÓN",
                        style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25.0),
                      Icon(
                        Icons.bus_alert,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(height: 35.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Container(
                            height: 42.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 30.0,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    textInputAction: TextInputAction.done,
                                    controller: _nameController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    cursorColor:
                                        MyColors.Colors.colorBackgroundDark,
                                    //obscureText: true,
                                    style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Nombre de la Ruta",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Futura',
                                          color: Colors.white54,
                                        )),
                                  ),
                                )
                              ],
                            )),
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  _showStatesDialog();
                                },
                                child: Container(
                                    height: 42.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _state,
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  if (_state != "Estado") {
                                    _showLocalitiesDialog();
                                  } else {
                                    Toast.show(
                                        "Debes seleccionar primero el estado",
                                        context,
                                        duration: Toast.LENGTH_LONG);
                                  }
                                },
                                child: Container(
                                    height: 42.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _locality,
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                           _procesoRegistro();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 40.0, right: 40.0),
                          child: Container(
                            height: 45.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "FINALIZAR REGISTRO",
                                style: TextStyle(
                                    color: MyColors.Colors.colorBackgroundDark,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showStatesDialog() {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "ESTADOS",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.80,
        child: ListView.builder(
            itemCount: stateList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _state = stateList[index].nombre;
                      _locality = "Municipio";

                      localityListFiltered.clear();
                      for (int i = 0; i < localityList.length; i++) {
                        if (localityList[i].nombre_estado == _state) {
                          localityListFiltered.add(localityList[i]);
                        }
                      }
                      Navigator.of(context).pop();
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(stateList[index].nombre),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
              );
            }),
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

  void _showLocalitiesDialog() {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "MUNICIPIOS",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
            itemCount: localityListFiltered.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _locality = localityListFiltered[index].nombre_municipio;
                      Navigator.of(context).pop();
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(localityListFiltered[index].nombre_municipio),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
              );
            }),
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
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  _procesoRegistro() async {
    String _name = _nameController.text;
    //String _lastName = _lastNameController.text;

    FocusScope.of(context).requestFocus(FocusNode());

    if (_name.length < 5) {
      Toast.show("Por favor, escriba su nombre correctamente", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (_state == "Estado") {
      Toast.show("Por favor, seleccione su estado", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (_locality == "Municipio") {
      Toast.show("Por favor, seleccione su municipio", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    var now = DateTime.now();

      QuerysService().SaveCamiones(
        idCenser: id_variable,
        errorFunction: _cancelSpinnerError,
        function: _cancelSpinnerSuccesful,
        context: context,
        collectionValues: {
          'idCamion': id_variable,
          'nameRuta': _name,
          'createdOn': now,
          'state': _state,
          'locality': _locality,
          'createBy':widget.adminModel.nameDueno,
        });
  }

  _cancelSpinnerError() {
    setState(() {
      _showSpinner = false;
    });
  }

  _cancelSpinnerSuccesful() {
    setState(() {
      _showSpinner = false;
    });
    widget.function();
    Navigator.of(context).pop();
  }

  void setSpinnerStatus(bool status) {
    setState(() {
      _showSpinner = status;
    });
  }
}
