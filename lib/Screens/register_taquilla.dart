import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monedero_admin/Firebase/authentication.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Models/localitiesModel.dart';
import 'package:monedero_admin/Models/stateModel.dart';

import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;
import 'package:monedero_admin/Screens/loginScreen.dart';
import 'package:monedero_admin/Screens/mainScreen.dart';
import 'package:toast/toast.dart';

class RegisterTaquilla extends StatefulWidget {
  AdminModel adminModel;
  RegisterTaquilla(this.adminModel);

  @override
  State<RegisterTaquilla> createState() => _RegisterTaquillaState();
}

class _RegisterTaquillaState extends State<RegisterTaquilla> {
  bool mostrarContrasena=false;
  bool ConfirmarMostrarContrasena=false;
  double screenHeight;
  TextEditingController _phoneController;
  TextEditingController _emailController;
  TextEditingController _nameLocalController;
  TextEditingController _passwordController;
  TextEditingController _passwordConfirmController;
  
  
  TextEditingController _nombreDuenoController;
  

  String _state = "Estado";
  String _locality = "Municipio";
  bool _showSpinner = false;
  
  String myId;
  DateTime _now;
  DateTime _yesterday;
  String myUrl;
  String _statenombreRta="Nombre de la ruta";
  List _stateListRutasList=["Ruta numero 1", "Ruta numero 2"];
  File _image;

List<AdminModel> censerList = [];
   List<StateModel> stateList = [];
   List<LocalityModel> localityList = [];
   List<LocalityModel> localityListFiltered = [];
   String id_variable="";
String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  id_variable= List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  return id_variable;
}

 

  




  

  




  

  

   

  


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

  void initState() {
    // TODO: implement initState
    super.initState();
    loadStates();

    _nameLocalController = TextEditingController();
    _phoneController= TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    
  _nombreDuenoController= TextEditingController() ;
  generateRandomString(5);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _nameLocalController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _phoneController.dispose();
    _nombreDuenoController.dispose();
  }

  void setSpinnerStatus(bool status){
    setState(() {
      _showSpinner = status;
    });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyColors.Colors.colorRedBackgroundDarkF, Colors.red[800]],
                    end: FractionalOffset.topCenter,
                    begin: FractionalOffset.bottomCenter,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.repeated),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 85.0),
                      Text(
                        "REGÍSTRAR TAQUILLA",
                        style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                       
                             SizedBox(height:15),
                               Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                              child:  Icon(
                                  Icons.add_business,
                                  color: Colors.white,
                                  size: 80.0,
                                ),
                               ),
                               SizedBox(height:25),
                                 
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
                                    controller: _nameLocalController,
                                    textCapitalization: TextCapitalization.words,
                                    cursorColor:MyColors.Colors.colorBackgroundDark,
                                    //obscureText: true,
                                    style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Nombre del establecimiento",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Futura',
                                          color: Colors.white54,
                                        )
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: (){
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
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: (){
                                  if(_state != "Estado"){
                                    _showLocalitiesDialog();
                                  }
                                  else{
                                    Toast.show("Debes seleccionar primero el estado", context, duration: Toast.LENGTH_LONG);
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
                                  child:  Center(
                                    child: Text(
                                      _locality,
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:15),
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
                                    controller: _nombreDuenoController,
                                    textCapitalization: TextCapitalization.words,
                                    cursorColor:MyColors.Colors.colorBackgroundDark,
                                    //obscureText: true,
                                    style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Nombre del dueño",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Futura',
                                          color: Colors.white54,
                                        )
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                      SizedBox(height: 15.0),
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
                                    keyboardType: TextInputType.phone,
                                    cursorColor:MyColors.Colors.colorBackgroundDark,
                                    controller: _phoneController,
                                    style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Telefono",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Futura',
                                          color: Colors.white54,
                                        )
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                      SizedBox(height: 15.0),
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
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _emailController,
                                    cursorColor:MyColors.Colors.colorBackgroundDark,
                                    //obscureText: true,
                                    style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Correo electrónico",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Futura',
                                          color: Colors.white54,
                                        )
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                      SizedBox(height: 15.0),
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
                                    controller: _passwordController,
                                    obscureText: !mostrarContrasena,
                                    cursorColor:MyColors.Colors.colorBackgroundDark,
                                    style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Contraseña",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Futura',
                                          color: Colors.white54,
                                        ),
                                         suffixIcon: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: IconButton(
                                      icon: Icon(mostrarContrasena?Icons.visibility:Icons.visibility_off,
                                      color:Colors.white54),
                                      onPressed: (){
                                        setState(() {
                                          mostrarContrasena= !mostrarContrasena;
                                        });
                                    }
                                  ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                      SizedBox(height: 15.0),
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
                                    controller: _passwordConfirmController,
                                    obscureText: !ConfirmarMostrarContrasena,
                                    cursorColor:MyColors.Colors.colorBackgroundDark,
                                    style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                       suffixIcon: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: IconButton(
                                      icon: Icon(ConfirmarMostrarContrasena?Icons.visibility:Icons.visibility_off,
                                      color:Colors.white54),
                                      onPressed: (){
                                        setState(() {
                                          ConfirmarMostrarContrasena= !ConfirmarMostrarContrasena;
                                        });
                                    }
                                  ),
                                      ),
                                        hintText: "Confirmar contraseña",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Futura',
                                          color: Colors.white54,
                                        )
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),

                 



                      GestureDetector(
                        onTap: (){
                      _processCenserRegister();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:20.0, left: 40.0, right: 40.0),
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
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:75),
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
  
  void _showStatesDialogRutas(){
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "Ruta",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Container(
        width:MediaQuery.of(context).size.width*0.95,
        height: MediaQuery.of(context).size.height*0.20,
        child: ListView.builder(
            itemCount: _stateListRutasList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _statenombreRta = _stateListRutasList[index];
                     
                      Navigator.of(context).pop();
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                          _stateListRutasList[index]
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
        FlatButton(
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
        width:MediaQuery.of(context).size.width*0.95,
        height: MediaQuery.of(context).size.height*0.80,
        child: ListView.builder(
            itemCount: stateList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _state = stateList[index].nombre;
                      _locality = "Municipio";
      
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
        FlatButton(
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
        width:MediaQuery.of(context).size.width*0.95,
        height: MediaQuery.of(context).size.height*0.80,
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
        FlatButton(
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
  
   _processCenserRegister() async {

    FocusScope.of(context).requestFocus(FocusNode());

    String _NameLocal = _nameLocalController.text;
    String _estado = _state;
    String _municipio  = _locality;
    String _Telefono = _phoneController.text.trim();
    String _Email = _emailController.text.trim();
    String _Contrasena = _passwordController.text.trim();
    String _ConfirmarContrasena = _passwordConfirmController.text.trim();
    String _Nombredueno = _nombreDuenoController.text;

    String _nameRuta=_statenombreRta;

    bool telefonoValido = RegExp(r'^\d{10}$').hasMatch(_Telefono);



     FocusScope.of(context).requestFocus(FocusNode());
      if(_NameLocal.length < 3){
      Toast.show("Debes introducir un nombre válido, con un minimo de 3 caracteres", context, duration: Toast.LENGTH_LONG);
      return;
    }
    

     
    
     if(_state == "Estado"){
       Toast.show("Por favor, seleccione su estado", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
       return;
     }
     if(_locality == "Municipio"){
       Toast.show("Por favor, seleccione su municipio", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
       return;
     }
     if(_Nombredueno.length < 3){
      Toast.show("Debes introducir un nombre válido, con un minimo de 3 caracteres", context, duration: Toast.LENGTH_LONG);
      return;
    }
     if(_Telefono != null && telefonoValido==false){
      Toast.show("El telefono debe tener 10 digitos y solo puede contener numeros", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
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
      if(_Contrasena.length < 6 ){
       Toast.show("Su contraseña debe ser minimo de 6 caracteres, por favor, verifíquela", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
       return;
     }
     else{
       if(_Contrasena != _ConfirmarContrasena){
         Toast.show("Sus contraseñas no coinciden", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
         return;
       }
     }

    setSpinnerStatus(true);
     var auth = await Authentication().createUser(email: _Email, password: _Contrasena);

     if(auth.succes){
       var user = await Authentication().getCurrentUser();
       if (user != null) {
         var now = DateTime.now();
     
         QuerysService().SaveTaquilla(idCenser: user.uid, errorFunction: _cancelSpinnerError, function: _cancelSpinnerSuccesful(user.uid), context: context, collectionValues: {
           'id' : user.uid,
           'nombreLocal' : _NameLocal,
           'email' : _Email,
           'createdOn' : now,
           'nombreDueño' : _Nombredueno,
           'state' : _state,
           'locality' : _locality,
           'numberOwner' : _Telefono,
           'isSupended' : false,
           'creadoPor':widget.adminModel.email,
           'type':"taquilla",
           'saldoTaquilla':1000,
           

         });
       
        
       }
     }
     else{
       Toast.show("Ha ocurrido un problema, Verifique su correo electronico", context, duration: Toast.LENGTH_LONG);
       _cancelSpinnerError();
     }

  
   }
   _cancelSpinnerError(){
    setState(() {
      _showSpinner = false;
    });
  }
  _cancelSpinnerSuccesful(idPropio)async{
    setState(() {
      _showSpinner = false;
      
    });
   final messages = await QuerysService().getMiInfo(miId: idPropio);
    censerList = _getUserItem(messages.docs);

    

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen (adminModel: widget.adminModel)
          )
      );
      setSpinnerStatus(false);

    
  }
  List<AdminModel> _getUserItem(dynamic miInfo){

    List<AdminModel> miInfoList = [];

    for(var datos in miInfo) {
      final id_ = datos.data()['id'];
      final nameLocal_ = datos.data()['nombreLocal'] ?? '';
      final nameDueno_ = datos.data()['nombreDueño'] ?? '';
      final email_ = datos.data()['email'] ?? '';
      final createdOn_ = datos.data()['createdOn'];
      final locality_ = datos.data()['locality'] ?? '';
      final state_ = datos.data()['state'] ?? '';
      final code_ = datos.data()['code'] ?? '';
      
      final typeAdmin_ = datos.data()['type'] ?? '';
      final saldoTaquilla_ = datos.data()['saldoTaquilla'] ?? '';
      final createBy_ = datos.data()['creadoPor'] ?? '';
      
      final isSupended_ = datos.data()['isSupended'] ?? '';

      AdminModel usuariosModel = AdminModel(
        id: id_,
        nameDueno: nameDueno_,
        email: email_,
        createdOn: createdOn_.toDate(),
        code: code_,
        nameLocal: nameLocal_,
        locality: locality_,
        state: state_,
        
        typeAdmin: typeAdmin_,
        saldoTaquilla: saldoTaquilla_,
        createBy:createBy_,
        isSupended:isSupended_,
      );


      miInfoList.add(usuariosModel);
    }
    return miInfoList;
  }
}