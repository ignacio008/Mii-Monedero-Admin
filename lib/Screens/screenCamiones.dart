import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monedero_admin/Models/camionesModel.dart';
import 'package:monedero_admin/Items/inputScreenCamion.dart';
import 'package:monedero_admin/Screens/addCamiones.dart';
import 'package:toast/toast.dart';

import '../Firebase/querys.dart';
import '../Models/CenserModel.dart';
import '../Models/adminModel.dart';
import '../Models/localitiesModel.dart';
import '../Models/stateModel.dart';

class ScreenCamiones extends StatefulWidget {
  AdminModel adminmodel;
  ScreenCamiones(this.adminmodel);

  @override
  State<ScreenCamiones> createState() => _ScreenCamionesState();
}

class _ScreenCamionesState extends State<ScreenCamiones> {
  bool _showSpinner = true;
  List<CamionesModel> camiones = [];
  List<StateModel> stateList = [];
  List<LocalityModel> localityList = [];
  List<LocalityModel> localityListFiltered = [];
  TextEditingController _controllerEmail;
  String _state = "Agregar estado";
  String _locality = "Agregar municipio";

  void _getCensersByEmail({String nameRuta}) async {
    setSpinnerStatus(true);
    final messages =
        await QuerysService().getCensersNameRuta(nameRuta: nameRuta);
    camiones = _getCamionesItem(messages.docs);
    if (camiones.length > 0) {
      setSpinnerStatus(false);
    } else {
      setSpinnerStatus(false);
      Toast.show("No se ha encontrado ruta disponible", context,
          duration: Toast.LENGTH_LONG);
    }
  }

  void setSpinnerStatus(bool status) {
    setState(() {
      _showSpinner = status;
    });
  }

  void _getCensers() async {
    final messages = await QuerysService().getAllCamiones();
    camiones = _getCamionesItem(messages.docs);
    if (camiones.length > 0) {
      setSpinnerStatus(false);
    } else {
      setSpinnerStatus(false);
      Toast.show("No se han encontrado ningun camion", context,
          duration: Toast.LENGTH_LONG);
    }
  }

  _reloadData() {
    camiones.clear();
    _getCensers();
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
      appBar: AppBar(title: Text("Camiones")),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Mii Monedero Cuentas",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Buscar por nombre de la ruta",
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
                          hintText: "Ejemplo: Ruta 1",
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
                    _getCensersByEmail(nameRuta: _controllerEmail.text.trim());
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
      
  floatingActionButton:FloatingActionButton.extended(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCamiones(widget.adminmodel, _reloadData))); 
        },
        label:  Text('Registrar Camion'),
        icon: const Icon(Icons.airport_shuttle_rounded),
        backgroundColor:  Colors.red[600],
      )
    );
  }

  Widget _censersList() {
    if (camiones.length > 0) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Flexible(
          child: ListView.builder(
              itemCount: camiones.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return InputScreenCamion(
                  camionesModel: camiones[index],
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
}

List<CamionesModel> _getCamionesItem(dynamic miInfo) {
  List<CamionesModel> miInfoList = [];
  for (var datos in miInfo) {
    final idCamion_ = datos.data()['idCamion'];
    final nameRuta_ = datos.data()['nameRuta'] ?? '';
    final createBy_ = datos.data()['createBy'] ?? '';
    final createdOn_ = datos.data()['createdOn'];
    final updateOn_ = datos.data()['updateOn'] ?? null;
    final state_ = datos.data()['state'] ?? '';
    final locality_ = datos.data()['locality'] ?? '';
    final numEconomico_ = datos.data()['numEconomico'] ?? '';

    CamionesModel camionesModel = CamionesModel(
      idCamion: idCamion_,
      nameRuta: nameRuta_,
      createdOn: createdOn_.toDate(),
      locality: locality_,
      state: state_,
      createBy: createBy_,
      numEconomico:numEconomico_,
    );
    miInfoList.add(camionesModel);
  }
  return miInfoList;
}
