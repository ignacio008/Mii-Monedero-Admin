import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monedero_admin/Firebase/authentication.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Models/localitiesModel.dart';
import 'package:monedero_admin/Models/stateModel.dart';
import 'package:toast/toast.dart';
import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;

class AddCenserScreen extends StatefulWidget {

  Function function;
  AddCenserScreen({this.function});

  @override
  _AddCenserScreenState createState() => _AddCenserScreenState();
}

class _AddCenserScreenState extends State<AddCenserScreen> {

  TextEditingController _controllerNameCenser;
  TextEditingController _controllerNameOwner;
  TextEditingController _controllerNumberOwner;
  TextEditingController _controllerEmail;
  TextEditingController _controllerDescription;
  TextEditingController _controllerAddres;
  TextEditingController _controllerLatitiude;
  TextEditingController _controllerLongitude;
  TextEditingController _controllerHours;
  TextEditingController _controllerService1;
  TextEditingController _controllerService2;
  TextEditingController _controllerService3;
  TextEditingController _controllerService4;
  TextEditingController _controllerService5;
  bool _showSpinner = true;
  String _category = "";
  String _state = "Agregar estado";
  String _locality = "Agregar municipio";
  List<String> servicesList = [];
  List<String> photos = [];
  List<String> categories = [];
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

  }

  Future<String> _loadLocalitiesAsset() async {
    return await rootBundle.loadString('assets/result.json');
  }

  loadLocalities() async {
    String jsonString = await _loadLocalitiesAsset();
    var jsonResponse = json.decode(jsonString) as List;

    localityList = jsonResponse.map((i) => LocalityModel.fromJson(i)).toList();

    setState(() {
      _showSpinner = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadStates();
    loadLocalities();

    _controllerNameCenser = TextEditingController();
    _controllerNameOwner = TextEditingController();
    _controllerNumberOwner = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerDescription = TextEditingController();
    _controllerAddres = TextEditingController();
    _controllerLatitiude = TextEditingController();
    _controllerLongitude = TextEditingController();
    _controllerHours = TextEditingController();
    _controllerService1 = TextEditingController();
    _controllerService2 = TextEditingController();
    _controllerService3 = TextEditingController();
    _controllerService4 = TextEditingController();
    _controllerService5 = TextEditingController();

    categories.add("AUTOLAVADO");
    categories.add("BAÑOS PÚBLICOS");
    categories.add("CERRAJERÍAS");
    categories.add("CIBER");
    categories.add("DENTISTA");
    categories.add("ELÉCTRICO");
    categories.add("ELECTRICISTA");
    categories.add("ESCUELA DE BAILE");
    categories.add("ESCUELA DE BELLEZA");
    categories.add("ESCUELA DE DANZA");
    categories.add("ESCUELA DE IDIOMAS");
    categories.add("ESCUELA DE NATACIÓN");
    categories.add("ESTACIONAMIENTO");
    categories.add("ESTÉTICA");
    categories.add("GIMNASIO");
    categories.add("JARDINERO");
    categories.add("LABORATORIO CLÍNICO");
    categories.add("LAVANDERÍAS");
    categories.add("LUSTADOR DE ZAPATOS");
    categories.add("MECÁNICO AUTOMOTRIZ");
    categories.add("MÉDICO");
    categories.add("MODISTA");
    categories.add("ÓPTICAS");
    categories.add("PINTOR");
    categories.add("PLOMERO");
    categories.add("REPARACIÓN DE CALZADO");
    categories.add("SPA");
    categories.add("TALLER DE BICICLETAS");
    categories.add("TÉCNICO EN REPARACIÓN DE CELULARES");
    categories.add("TÉCNICO EN REPARACIÓN DE ELECTRODOMÉSTICOS");
    categories.add("VETERINARIO");
    categories.add("VULCANIZADORA");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controllerNameCenser.dispose();
    _controllerNameOwner.dispose();
    _controllerNumberOwner.dispose();
    _controllerEmail.dispose();
    _controllerDescription.dispose();
    _controllerAddres.dispose();
    _controllerLatitiude.dispose();
    _controllerLongitude.dispose();
    _controllerHours.dispose();
    _controllerService1.dispose();
    _controllerService2.dispose();
    _controllerService3.dispose();
    _controllerService4.dispose();
    _controllerService5.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Agregar CENSER"
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Categoría del centro de servicio"
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Center(
                          child: Text(
                              _category,
                            style: TextStyle(
                              color: MyColors.Colors.colorBackgroundDark
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        _showCategories();
                      },
                      child: Container(
                        height: 40.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[300]
                        ),
                        child: Center(
                          child: Text(
                              "Agregar"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Nombre del centro de servicio"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerNameCenser,
                      textCapitalization: TextCapitalization.words,
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Nombre del dueño o dueña del centro de servicio"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerNameOwner,
                      textCapitalization: TextCapitalization.words,
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Número de teléfono del dueño o dueña del centro de servicio"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerNumberOwner,
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Correo electrónico del dueño o dueña del centro de servicio"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Descripción del centro de servicio"
                ),
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerDescription,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 3,
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Estado y municipio del centro de servicio"
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          _showStatesDialog();
                        },
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[300]
                          ),
                          child: Center(
                            child: Text(
                                _state,
                              style: TextStyle(
                                  color: MyColors.Colors.colorBackgroundDark
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          if(_state == "Agregar estado"){
                            Toast.show("Debes seleccionar el estado primero", context, duration: Toast.LENGTH_LONG);
                          }
                          else{
                            _showLocalitiesDialog();
                          }
                        },
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[300]
                          ),
                          child: Center(
                            child: Text(
                                _locality,
                              style: TextStyle(
                                  color: MyColors.Colors.colorBackgroundDark
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Dirección del centro de servicio"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerAddres,
                      textCapitalization: TextCapitalization.sentences,
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Latitud del centro de servicio"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerLatitiude,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Longitud del centro de servicio"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerLongitude,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Horario en el que está abierto el centro de servicio"
                ),
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerHours,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 3,
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Servicio 1 que ofrece (obligatorio)"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerService1,
                      textCapitalization: TextCapitalization.sentences,
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Servicio 2 que ofrece (opcional)"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerService2,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Servicio 3 que ofrece (opcional)"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerService3,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Servicio 4 que ofrece (opcional)"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerService4,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Servicio 5 que ofrece (opcional)"
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerService5,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontFamily: 'Futura',
                          color: MyColors.Colors.colorBackgroundDark
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: (){
                    _processCenserRegister();
                  },
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Center(
                      child: Text(
                        "Crear Centro de Servicio",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    )
                  ),
                ),
                SizedBox(
                  height: 25.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _processCenserRegister() async {

    FocusScope.of(context).requestFocus(FocusNode());

    String _NameCenser = _controllerNameCenser.text;
    String _NameOwner = _controllerNameOwner.text;
    String _NumberOwner  = _controllerNumberOwner.text;
    String _Email = _controllerEmail.text.trim();
    String _Description = _controllerDescription.text;
    String _Addres = _controllerAddres.text;
    String _Latitiude = _controllerLatitiude.text;
    String _Longitude = _controllerLongitude.text;
    String _Hours = _controllerHours.text;
    String _Service1 = _controllerService1.text;
    String _Service2 = _controllerService2.text;
    String _Service3 = _controllerService3.text;
    String _Service4 = _controllerService4.text;
    String _Service5 = _controllerService5.text;

    if(_NameCenser.length < 3){
      Toast.show("Debes introducir un nombre del centro de servicio válido", context, duration: Toast.LENGTH_LONG);
      return;
    }
    if(_NameOwner.length < 3){
      Toast.show("Debes introducir un nombre del propietario del centro de servicio válido", context, duration: Toast.LENGTH_LONG);
      return;
    }
    if(_NumberOwner.length < 6){
      Toast.show("Debes introducir un número del propietario del centro de servicio válido", context, duration: Toast.LENGTH_LONG);
      return;
    }
    if(_Email.length < 3){
      Toast.show("Debes introducir un email del centro de servicio válido", context, duration: Toast.LENGTH_LONG);
      return;
    }
    if(!_Email.contains("@")){
      Toast.show("Debes introducir un email del centro de servicio válido", context, duration: Toast.LENGTH_LONG);
      return;
    }
    if(_Description.length < 10){
      Toast.show("Debes introducir una descripción del centro de servicio válida", context, duration: Toast.LENGTH_LONG);
      return;
    }
    if(_Addres.length < 10){
      Toast.show("Debes introducir una dirección del centro de servicio válida", context, duration: Toast.LENGTH_LONG);
      return;
    }
    if(_Latitiude.length < 5){
      Toast.show("Debes introducir la latitud centro de servicio correctamente", context, duration: Toast.LENGTH_LONG);
      return;
    }
    if(_Longitude.length < 3){
      Toast.show("Debes introducir la longitud del centro de servicio correctamente", context, duration: Toast.LENGTH_LONG);
      return;
    }
    if(_Hours.length < 3){
      Toast.show("Debes introducir el horario del centro de servicio correctamente", context, duration: Toast.LENGTH_LONG);
      return;
    }
    if(_Service1.length < 3){
      Toast.show("Debes introducir por lo menos un servicio del centro de servicio", context, duration: Toast.LENGTH_LONG);
      return;
    }

    servicesList.add(_Service1);
    if(_Service2.length > 3){
      servicesList.add(_Service2);
    }
    if(_Service3.length > 3){
      servicesList.add(_Service3);
    }
    if(_Service4.length > 3){
      servicesList.add(_Service4);
    }
    if(_Service5.length > 3){
      servicesList.add(_Service5);
    }

    // Agregamos las fotos por defecto
    photos.clear();
    photos.add("https://firebasestorage.googleapis.com/v0/b/mega-monedero.appspot.com/o/photo_default.jpg?alt=media&token=02df7823-7d9d-42d2-84c9-218eca5b9c74");
    photos.add("https://firebasestorage.googleapis.com/v0/b/mega-monedero.appspot.com/o/photo_default.jpg?alt=media&token=02df7823-7d9d-42d2-84c9-218eca5b9c74");
    photos.add("https://firebasestorage.googleapis.com/v0/b/mega-monedero.appspot.com/o/photo_default.jpg?alt=media&token=02df7823-7d9d-42d2-84c9-218eca5b9c74");

    setSpinnerStatus(true);
    var auth = await Authentication().createUser(email: _Email, password: "123456");

    if(auth.succes){

      var user = await Authentication().getCurrentUser();
      if (user != null) {

        var now = DateTime.now();
        
        QuerysService().SaveCenser(idCenser: user.uid, errorFunction: _cancelSpinnerError, function: _cancelSpinnerSuccesful, context: context, collectionValues: {
          'id' : user.uid,
          'name' : _NameCenser,
          'email' : _Email,
          'createdOn' : now,
          'description' : _Description,
          'category' : _category,
          'addres' : _Addres,
          'openHours' : _Hours,
          'latitude' : double.parse(_Latitiude),
          'longitude' : double.parse(_Longitude),
          'state' : _state,
          'locality' : _locality,
          'nameOwner' : _NameOwner,
          'numberOwner' : _NumberOwner,
          'suspended' : false,
          'photos' : photos,
          'services' : servicesList,
          'distanceTo' : '',
        });
      }
    }
    else{
      Toast.show("Ha ocurrido un problema", context, duration: Toast.LENGTH_LONG);
    }

  }

  _cancelSpinnerError(){
    setState(() {
      _showSpinner = false;
    });
  }

  _cancelSpinnerSuccesful(){
    setState(() {
      _showSpinner = false;
    });
    widget.function();
    Navigator.of(context).pop();
  }

  void setSpinnerStatus(bool status){
    setState(() {
      _showSpinner = status;
    });
  }

  void _showCategories(){
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "CATEGORÍAS",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Container(
         width:MediaQuery.of(context).size.width*0.9,
        height:MediaQuery.of(context).size.height*0.8,
        child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _category = categories[index];
                      Navigator.of(context).pop();
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        categories[index]
                      ),
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
            }
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
      ],
    );

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  void _showStatesDialog(){
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "ESTADOS",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Container(
         width:MediaQuery.of(context).size.width*0.9,
        height:MediaQuery.of(context).size.height*0.8,
        child: ListView.builder(
            itemCount: stateList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _state = stateList[index].nombre;
                      _locality = "Agregar municipio";

                      localityListFiltered.clear();
                      for(int i = 0; i < localityList.length; i++){
                        if(localityList[i].nombre_estado == _state){
                          localityListFiltered.add(localityList[i]);
                        }
                      }

                      Navigator.of(context).pop();
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                          stateList[index].nombre
                      ),
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
            }
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
      ],
    );

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  void _showLocalitiesDialog(){
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "MUNICIPIOS",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Container(
         width:MediaQuery.of(context).size.width*0.9,
        height:MediaQuery.of(context).size.height*0.8,
        child: ListView.builder(
            itemCount: localityListFiltered.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _locality = localityListFiltered[index].nombre_municipio;
                      Navigator.of(context).pop();
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                          localityListFiltered[index].nombre_municipio
                      ),
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
            }
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
      ],
    );

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }

}
