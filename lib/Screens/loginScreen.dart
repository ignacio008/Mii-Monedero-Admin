import 'package:clippy_flutter/diagonal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monedero_admin/Dialog/dialogResetContrasena.dart';
import 'package:monedero_admin/Firebase/authentication.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Screens/mainScreen.dart';
import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  double height;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool _showSpinner = false;
  List<AdminModel> usuarios = [];

  void initState() {
    // TODO: implement initState
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [MyColors.Colors.colorRedBackgroundDarkF, Colors.red[800]],
                      end: FractionalOffset.topCenter,
                      begin: FractionalOffset.bottomCenter,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.repeated),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Diagonal(
                        clipShadows: [ClipShadow(color: Colors.black)],
                        position: DiagonalPosition.BOTTOM_LEFT,
                        clipHeight: height/15,
                        child: Container(
                          color: MyColors.Colors.colorRedBackgroundDark,
                          height: height/3.5,
                        ),
                      ),
                      Container(
                        height: height/3.5,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Mii Monedero Cuentas",
                                style: TextStyle(
                                    fontSize: 28.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Administrador",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "INICIAR SESIÓN",
                    style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25.0),
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
                                
                                    cursorColor:MyColors.Colors.colorBackgroundDark,
                                obscureText: true,
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
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => DialogResetContrasena(
                            function: _reestablecerContrasena,
                          )
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 40.0),
                      child: Text(
                        "¿Olvidaste tu contraseña?",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _loguearme();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0, left: 40.0, right: 40.0),
                      child: Container(
                        height: 45.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: MyColors.Colors.colorRedBackgroundDark,
                        ),
                        child: Center(
                          child: Text(
                            "ENTRAR",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setSpinnerStatus(bool status){
    setState(() {
      _showSpinner = status;
    });
  }

  _loguearme() async {
    FocusScope.of(context).requestFocus(FocusNode());

    String email = _emailController.text.trim();
    String contrasena = _passwordController.text.trim();

    if(!email.contains("@") || email.length < 3 ){
      Toast.show("Su correo no está escrito correctamente, por favor, verifíquelo", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      return;
    }
    if(contrasena.length < 6 ){
      Toast.show("Su contraseña debe ser minimo de 6 caracteres, por favor, verifíquela", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      return;
    }

    setSpinnerStatus(true);
    var auth = await Authentication().logingUser(email: _emailController.text.trim(), password: _passwordController.text.trim());

    if(auth.succes){

      User user = await Authentication().getCurrentUser();
      _getMiInfo(user.uid);
      /*
                            Navigator.pushReplacementNamed(
                                context,
                                MainScreen.routeName);*/

      //FocusScope.of(context).requestFocus(_focusNode);
      _emailController.text = "";
      _passwordController.text = "";
    }
    else{
      Toast.show(auth.errorMessage, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      setSpinnerStatus(false);
    }
  }

  void _getMiInfo(String idPropio) async {

    final messages = await QuerysService().getMiInfo(miId: idPropio);
    usuarios = _getUserItem(messages.docs);
    int isSaldoPago;
    int stateCosto;
    int costoiguales;
    if(usuarios.length > 0){

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen (adminModel: usuarios[0])
          )
      );
      setSpinnerStatus(false);

    }
    else{
      Authentication().singOut();
      setSpinnerStatus(false);
      Toast.show("Ha ocurrido un error, por favor reinicie la aplicación", context, duration: Toast.LENGTH_LONG);
    }
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
      
      final typeAdmin_ = datos.data()['type'] ?? '';
      final saldoTaquilla_ = datos.data()['saldoTaquilla'] ?? '';
      final createBy_ = datos.data()['creadoPor'] ?? '';
      
      final isSupended_ = datos.data()['isSupended'] ?? '';
      
      final code_ = datos.data()['code'] ?? '';
      

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
      );


      miInfoList.add(usuariosModel);
    }
    return miInfoList;
  }

  void _reestablecerContrasena(String correo) async {
    await Authentication().resetPassword(email: correo);
    Toast.show("Se ha enviado un correo electrónico al email que escribiste, ahí podrás reestablecer tu contraseña", context, duration: 8, gravity:  Toast.BOTTOM);
  }
}
