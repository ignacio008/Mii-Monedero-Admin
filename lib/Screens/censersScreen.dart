import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monedero_admin/Firebase/fetch_data.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Items/censerItem.dart';
import 'package:monedero_admin/Models/CenserModel.dart';
import 'package:monedero_admin/Models/activaciones_model.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Models/localitiesModel.dart';
import 'package:monedero_admin/Models/stateCosto.dart';
import 'package:monedero_admin/Models/stateModel.dart';
import 'package:monedero_admin/Screens/addCenserScreen.dart';
import 'package:toast/toast.dart';
import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;

class CensersScreen extends StatefulWidget {
  AdminModel adminmodel;
  CensersScreen(
    this.adminmodel,
  );
  @override
  _CensersScreenState createState() => _CensersScreenState();
}

class _CensersScreenState extends State<CensersScreen> {
  bool _showSpinner = true;
  List<CenserModel> censers = [];
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

  void _getCensersByEmail({String email}) async {
    setSpinnerStatus(true);
    final messages = await QuerysService().getCensersByEmail(email: email);
    censers = _getCenserItem(messages.docs);
    if (censers.length > 0) {
      setSpinnerStatus(false);
    } else {
      setSpinnerStatus(false);
      Toast.show("No se han encontrado censers", context,
          duration: Toast.LENGTH_LONG);
    }
  }

  void _getCensersByState({String state}) async {
    setSpinnerStatus(true);
    final messages = await QuerysService().getCensersByState(state: state);
    censers = _getCenserItem(messages.docs);
    if (censers.length > 0) {
      setSpinnerStatus(false);
    } else {
      setSpinnerStatus(false);
      Toast.show("No se han encontrado censers", context,
          duration: Toast.LENGTH_LONG);
    }
  }

  void _getCensersByStateAndCity({String state, String city}) async {
    setSpinnerStatus(true);
    final messages = await QuerysService()
        .getCensersByStateAndCity(state: state, city: city);
    censers = _getCenserItem(messages.docs);
    if (censers.length > 0) {
      setSpinnerStatus(false);
    } else {
      setSpinnerStatus(false);
      Toast.show("No se han encontrado censers", context,
          duration: Toast.LENGTH_LONG);
    }
  }

  void _getCensers() async {
    final messages = await QuerysService().getAllCensers();
    censers = _getCenserItem(messages.docs);
    if (censers.length > 0) {
      setSpinnerStatus(false);
    } else {
      setSpinnerStatus(false);
      Toast.show("No se han encontrado censers", context,
          duration: Toast.LENGTH_LONG);
    }
  }

  List<CenserModel> _getCenserItem(dynamic miInfo) {
    List<CenserModel> miInfoList = [];
    for (var datos in miInfo) {
      final id_ = datos.data()['id'];
      final name_ = datos.data()['name'] ?? '';
      final email_ = datos.data()['email'] ?? '';
      final createdOn_ = datos.data()['createdOn'];
      final description_ = datos.data()['description'] ?? '';
      final category_ = datos.data()['category'] ?? '';
      final addres_ = datos.data()['addres'] ?? '';
      final openHours_ = datos.data()['openHours'] ?? '';
      final latitude_ = datos.data()['latitude'];
      final longitude_ = datos.data()['longitude'];
      final state_ = datos.data()['state'] ?? '';
      final locality_ = datos.data()['locality'] ?? '';
      final nameOwner_ = datos.data()['nameOwner'] ?? '';
      final numberOwner_ = datos.data()['numberOwner'] ?? '';
      final suspended_ = datos.data()['suspended'];
      final photos_ = datos.data()['photos'];
      final services_ = datos.data()['services'];
      final distanceTo_ = datos.data()['distanceTo'] ?? '';
      final numUnidad_ = datos.data()['numUnidad'] ?? '';
      final placa_ = datos.data()['placa'] ?? '';
      final photoPLaca_ = datos.data()['photoPLaca'] ?? '';
      final photoLicencia_ = datos.data()['photoLicencia'] ?? '';
      final nameRuta_ = datos.data()['nameRuta'] ?? '';
      final paraderoRuta_ = datos.data()['paraderoRuta'] ?? '';
      final photoCamion_ = datos.data()['camion'] ?? null;
      final activacionesRestantes_ =
          datos.data()['activacionesRestantes'] ?? '';

      CenserModel censerModel = CenserModel(
        id: id_,
        name: name_,
        email: email_,
        createdOn: createdOn_.toDate(),
        locality: locality_,
        state: state_,
        suspended: suspended_,
        description: description_,
        category: category_,
        addres: addres_,
        openHours: openHours_,
        latitude: latitude_,
        longitude: longitude_,
        nameOwner: nameOwner_,
        numberOwner: numberOwner_,
        photos: photos_,
        services: services_,
        distanceTo: distanceTo_,
        numUnidad: numUnidad_,
        placa: placa_,
        photoPLaca: photoPLaca_,
        photoLicencia: photoLicencia_,
        nameRuta: nameRuta_,
        paraderoRuta: paraderoRuta_,
        photoCamion: photoCamion_,
        activacionesRestantes: activacionesRestantes_,
      );
      miInfoList.add(censerModel);
    }
    return miInfoList;
  }

  void setSpinnerStatus(bool status) {
    setState(() {
      _showSpinner = status;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCensers();
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
        title: Text("CHOFERES "),
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
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15.0,
            ),
            // Text(
            //   "Filtrar por ubicación",
            //   style: TextStyle(
            //       fontSize: 14.0,
            //       fontWeight: FontWeight.bold
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // SizedBox(
            //   height: 5.0,
            // ),
            // Row(
            //   children: <Widget>[
            //     SizedBox(
            //       width: 10.0,
            //     ),
            //     Expanded(
            //       child: GestureDetector(
            //         onTap: (){
            //           _showStatesDialog();
            //         },
            //         child: Container(
            //           height: 40.0,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10.0),
            //               color: Colors.grey[300]
            //           ),
            //           child: Center(
            //             child: Text(
            //               _state,
            //               style: TextStyle(
            //                   color: MyColors.Colors.colorBackgroundDark
            //               ),
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10.0,
            //     ),
            //     Expanded(
            //       child: GestureDetector(
            //         onTap: (){
            //           if(_state == "Agregar estado"){
            //             Toast.show("Debes seleccionar el estado primero", context, duration: Toast.LENGTH_LONG);
            //           }
            //           else{
            //             _showLocalitiesDialog();
            //           }
            //         },
            //         child: Container(
            //           height: 40.0,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10.0),
            //               color: Colors.grey[300]
            //           ),
            //           child: Center(
            //             child: Text(
            //               _locality,
            //               style: TextStyle(
            //                   color: MyColors.Colors.colorBackgroundDark
            //               ),
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10.0,
            //     ),
            //     GestureDetector(
            //       onTap: (){
            //         if(_locality == "Agregar municipio"){
            //           if(_state == "Agregar estado"){
            //             Toast.show("Debes seleccionar por lo menos el estado para poder buscar", context, duration: Toast.LENGTH_LONG);
            //           }
            //           else{
            //             _getCensersByState(state: _state);
            //           }
            //         }
            //         else{
            //           _getCensersByStateAndCity(state: _state, city: _locality);
            //         }
            //       },
            //       child: Container(
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10.0),
            //           color: Colors.grey[300],
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(5.0),
            //           child: Icon(
            //               Icons.search
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10.0,
            //     )
            //   ],
            // ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Buscar por correo electrónico",
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
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
                          hintText: "Ejemplo: dentista.pablo@gmail.com",
                          //border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Futura',
                            //color: ColoresApp.Colores.colorGrisClaro
                          )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_controllerEmail.text.contains("@")) {
                      _getCensersByEmail(email: _controllerEmail.text.trim());
                    } else {
                      Toast.show("Introduce un correo válido", context,
                          duration: Toast.LENGTH_LONG);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
              ],
            ),
            _censersList()
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => AddCenserScreen(
      //               function: _reloadData,
      //             )
      //         )
      //     );
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: MyColors.Colors.colorRedBackgroundDark,
      // ),
    );
  }

  Widget _censersList() {
    if (censers.length > 0) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Flexible(
          child: ListView.builder(
              itemCount: censers.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return CenserItem(
                  censerModel: censers[index],
                  function: _reloadData,
                  adminmodel: widget.adminmodel,
                );
              }),
        ),
      );
    } else {
      return Container();
    }
  }

  _reloadData() {
    censers.clear();
    _getCensers();
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
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
            itemCount: stateList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _state = stateList[index].nombre;
                      _locality = "Agregar municipio";

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
}
