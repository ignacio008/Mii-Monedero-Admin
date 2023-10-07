import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Items/censerItem.dart';
import 'package:monedero_admin/Items/taquillaItema.dart';
import 'package:monedero_admin/Models/CenserModel.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Models/localitiesModel.dart';
import 'package:monedero_admin/Models/stateModel.dart';
import 'package:monedero_admin/Screens/register_taquilla.dart';
import 'package:toast/toast.dart';

import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;

class TaquillaAdmin extends StatefulWidget {
  AdminModel adminModel;
  TaquillaAdmin(this.adminModel);

  @override
  State<TaquillaAdmin> createState() => _TaquillaAdminState();
}

class _TaquillaAdminState extends State<TaquillaAdmin> {

 bool _showSpinner = true;
  List<CenserModel> censers = [];
  TextEditingController _controllerEmail;
  List<AdminModel> taquillas = [];


  Future<String> _loadASmaeAsset() async {
    return await rootBundle.loadString('assets/estados.json');
  }

 

  Future<String> _loadLocalitiesAsset() async {
    return await rootBundle.loadString('assets/result.json');
  }

  

  void _getCensersByEmail({String email}) async {

    setSpinnerStatus(true);

    final messages = await QuerysService().getCensersByEmailTaquilla(email: email);
    taquillas = _getCenserItem(messages.docs);

    if(taquillas.length > 0){

      setSpinnerStatus(false);

    }
    else{
      setSpinnerStatus(false);
      Toast.show("No se han encontrado Taquillas", context, duration: Toast.LENGTH_LONG);
    }
  }

  

  

  void _getCensers() async {

    final messages = await QuerysService().getAllCensersTAQUILLA();
    taquillas = _getCenserItem(messages.docs);

    if(taquillas.length > 0){

      setSpinnerStatus(false);

    }
    else{
      setSpinnerStatus(false);
      Toast.show("No se han encontrado Taquillas", context, duration: Toast.LENGTH_LONG);
    }
  }

  List<AdminModel> _getCenserItem(dynamic miInfo){

    List<AdminModel> miInfoList = [];

    for(var datos in miInfo) {
      final id_ = datos.data()['id'];
      final nameLocal_ = datos.data()['nombreLocal'] ?? '';
      final nameDueno_ = datos.data()['nombreDueño'] ?? '';
      final email_ = datos.data()['email'] ?? '';
      final createdOn_ = datos.data()['createdOn'];
      final locality_ = datos.data()['locality'] ?? '';
      final state_ = datos.data()['state'] ?? '';
      
      final typeAdmin_ = datos.data()['type'] ?? '';
      final saldoTaquilla_ = datos.data()['saldoTaquilla'] ?? '';
      final createBy_ = datos.data()['creadoPor'] ?? '';
      
      final isSupended_ = datos.data()['isSupended'] ?? '';
      
      final code_ = datos.data()['code'] ?? '';
      
      final numberOwner_ = datos.data()['numberOwner'] ?? '';

      AdminModel usuariosModel = AdminModel(
        id: id_,
        nameDueno: nameDueno_,
        email: email_,
        createdOn: createdOn_.toDate(),
        nameLocal: nameLocal_,
        locality: locality_,
        state: state_,
        
        typeAdmin: typeAdmin_,
        saldoTaquilla: saldoTaquilla_,
        createBy:createBy_,
        isSupended:isSupended_,
        code:code_,
        numberOwner:numberOwner_
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
        title: Text(
            "TAQUILLAS"
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
            
            SizedBox(
              height:15.0,
            ),
            Text(
              "Buscar por correo electrónico",
              style: TextStyle(
                  fontSize: 14.0,
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
                          hintText: "Ejemplo: dentista.pablo@gmail.com",
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
                      _getCensersByEmail(email: _controllerEmail.text.trim());
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
            _censersList()
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterTaquilla(widget.adminModel))); 
        },
        label: const Text('Crear Taquilla'),
        icon: const Icon(Icons.add_business_rounded),
        backgroundColor:  Colors.blue[600],
      ), 
    );
  }
  Widget _censersList(){

    if(taquillas.length > 0){
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Flexible(
          child: ListView.builder(
              itemCount: taquillas.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return TaquillItem(function: _reloadData,taquillassModel:taquillas[index], adminmodel: widget.adminModel);
              }
          ),
        ),
      );
    }
    else{
      return Container();
    }
  }
  
  _reloadData(){
    taquillas.clear();
    _getCensers();
  }


}