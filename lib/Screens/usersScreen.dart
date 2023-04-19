import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Items/itemUser.dart';
import 'package:monedero_admin/Models/UserModel.dart';
import 'package:monedero_admin/Models/localitiesModel.dart';
import 'package:monedero_admin/Models/stateModel.dart';
import 'package:toast/toast.dart';
import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  bool _showSpinner = true;
  List<UserModel> usuarios = [];
  List<StateModel> stateList = [];
  List<LocalityModel> localityList = [];
  List<LocalityModel> localityListFiltered = [];
  TextEditingController _controllerEmail;
  String _state = "Agregar estado";
  String _locality = "Agregar municipio";

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


  void _getUsersByEmail({String email}) async {

    setSpinnerStatus(true);

    final messages = await QuerysService().getAllUsersByEmail(email: email);
    usuarios = _getUserItem(messages.docs);

    if(usuarios.length > 0){

      setSpinnerStatus(false);

    }
    else{
      setSpinnerStatus(false);
      Toast.show("No se han encontrado censers", context, duration: Toast.LENGTH_LONG);
    }
  }

  void _getCensersByState({String state}) async {

    setSpinnerStatus(true);

    final messages = await QuerysService().getAllUsersByState(state: state);
    usuarios = _getUserItem(messages.docs);

    if(usuarios.length > 0){

      setSpinnerStatus(false);

    }
    else{
      setSpinnerStatus(false);
      Toast.show("No se han encontrado censers", context, duration: Toast.LENGTH_LONG);
    }
  }

  void _getCensersByStateAndCity({String state, String city}) async {

    setSpinnerStatus(true);

    final messages = await QuerysService().getAllUsersByStateAndCity(state: state, city: city);
    usuarios = _getUserItem(messages.docs);

    if(usuarios.length > 0){

      setSpinnerStatus(false);

    }
    else{
      setSpinnerStatus(false);
      Toast.show("No se han encontrado censers", context, duration: Toast.LENGTH_LONG);
    }
  }


  void _getUsers() async {

    final messages = await QuerysService().getAllUsersByDateTime();
    usuarios = _getUserItem(messages.docs);

    if(usuarios.length > 0){


      setSpinnerStatus(false);

    }
    else{
      setSpinnerStatus(false);
      Toast.show("No se han encontrado usuarios", context, duration: Toast.LENGTH_LONG);
    }
  }

  List<UserModel> _getUserItem(dynamic miInfo){

    List<UserModel> miInfoList = [];

    for(var datos in miInfo) {
      final id_ = datos.data()['id'];
      final name_ = datos.data()['name'] ?? '';
      final email_ = datos.data()['email'] ?? '';
      final activeProductosUntil_ = datos.data()['activeProductosUntil'];
      final createdOn_ = datos.data()['createdOn'];
      final activeUntil_ = datos.data()['activeUntil'];
      final locality_ = datos.data()['locality'] ?? '';
      final state_ = datos.data()['state'] ?? '';
      final renovations_ = datos.data()['renovations'];
      final suspended_ = datos.data()['suspended'];
      final urlProfile_ = datos.data()['urlProfile'] ?? '';


      UserModel usuariosModel = UserModel(
        id: id_,
        name: name_,
        email: email_,
        createdOn: createdOn_.toDate(),
        activeUntil: activeUntil_.toDate(),
        activeProductosUntil: activeProductosUntil_.toDate(),
        locality: locality_,
        state: state_,
        renovations: renovations_,
        suspended: suspended_,
        urlProfile: urlProfile_,
      );


      miInfoList.add(usuariosModel);
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
    _getUsers();
    loadStates();
    loadLocalities();
    _controllerEmail = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerEmail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Usuarios"
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Mii Monedero Admin",
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
              "Filtrar por ubicación",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
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
                          textAlign: TextAlign.center,
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
                          textAlign: TextAlign.center,
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
                    if(_locality == "Agregar municipio"){
                      if(_state == "Agregar estado"){
                        Toast.show("Debes seleccionar por lo menos el estado para poder buscar", context, duration: Toast.LENGTH_LONG);
                      }
                      else{
                        _getCensersByState(state: _state);
                      }
                    }
                    else{
                      _getCensersByStateAndCity(state: _state, city: _locality);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                          Icons.search
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
              height:15.0,
            ),
            Text(
              "Buscar por correo electrónico",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 10.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _controllerEmail,
                      //obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Futura',
                        //color: ColoresApp.Colores.colorGrisClaro
                      ),
                      decoration: InputDecoration(
                          hintText: "Ejemplo: juan@gmail.com",
                          //border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                            //color: ColoresApp.Colores.colorGrisClaro
                          )
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    FocusScope.of(context).requestFocus(FocusNode());
                    if(_controllerEmail.text.contains("@")){
                      _getUsersByEmail(email: _controllerEmail.text.trim());
                    }
                    else{
                      Toast.show("Introduce un correo válido", context, duration: Toast.LENGTH_LONG);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.search
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            _usersList()

          ],
        ),
      ),
    );
  }

  Widget _usersList(){

    if(usuarios.length > 0){
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Flexible(
          child: ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return UserItem(userModel: usuarios[index]);
              }
          ),
        ),
      );
    }
    else{
      return Container();
    }
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
