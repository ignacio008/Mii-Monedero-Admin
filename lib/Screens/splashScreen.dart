import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monedero_admin/Firebase/authentication.dart';
import 'package:monedero_admin/Firebase/fetch_data.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Screens/loginScreen.dart';
import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;
import 'package:monedero_admin/Screens/mainScreen.dart';
import 'package:toast/toast.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  List<AdminModel> usuarios = [];

  // void _getMiInfo(String idPropio) async {

  //   final messages = await QuerysService().getMiInfo(miId: idPropio);
  //   usuarios = _getUserItem(messages.docs);

  //   if(usuarios.length > 0){

  //     Timer(
  //         Duration(
  //             milliseconds: 1000
  //         ), () {
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => MainScreen (adminModel: usuarios[0])
  //           )
  //       );
  //     });
  //   }
  //   else{
  //     Authentication().singOut();
  //     Timer(
  //         Duration(
  //             milliseconds: 1000
  //         ), () {
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => LoginScreen()
  //           )
  //       );
  //     });
  //   }
  // }
  int isSaldoPago;
  int stateCosto;
  int costoiguales;
  void getCurrentUserMio() async{
    int status=0;
    var user = await Authentication().getCurrentUser();
    if (user != null) {
     AdminModel adminmodel = await FetchData().getAdmin(user.uid);

    if(adminmodel!=null){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen (adminModel: adminmodel,)));
    }
    }
    else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
  }

  // List<AdminModel> _getUserItem(dynamic miInfo){

  //   List<AdminModel> miInfoList = [];

  //   for(var datos in miInfo) {
  //     final id_ = datos.data()['id'];
  //     final nameLocal_ = datos.data()['nombreLocal'] ?? '';
  //     final nameDueno_ = datos.data()['nombreDueño'] ?? '';
  //     final email_ = datos.data()['email'] ?? '';
  //     final createdOn_ = datos.data()['createdOn'];
  //     final locality_ = datos.data()['locality'] ?? '';
  //     final state_ = datos.data()['state'] ?? '';
  //     final typeAdmin_ = datos.data()['type'] ?? '';
  //     final saldoTaquilla_ = datos.data()['saldoTaquilla'] ?? '';
      
  //     final createBy_ = datos.data()['creadoPor'] ?? '';
      
  //     final isSupended_ = datos.data()['isSupended'] ?? '';
  //     final code_ = datos.data()['code'] ?? '';

  //     AdminModel usuariosModel = AdminModel(
  //       id: id_,
  //       nameDueno: nameDueno_,
  //       email: email_,
  //       createdOn: createdOn_.toDate(),
  //       nameLocal: nameLocal_,
  //       locality: locality_,
  //       state: state_,
  //       typeAdmin: typeAdmin_,
  //       saldoTaquilla: saldoTaquilla_,
  //       createBy:createBy_,
        
  //       isSupended:isSupended_,
  //       code:code_,
  //     );


  //     miInfoList.add(usuariosModel);
  //   }
  //   return miInfoList;
  // }

  // void getCurrentUser() async{
  //   var user = await Authentication().getCurrentUser();
  //   if (user != null) {
  //     _getMiInfo(user.uid);
  //   }
  //   else{
  //     Timer(
  //         Duration(
  //             milliseconds: 1000
  //         ), () {
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => LoginScreen()
  //           )
  //       );
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserMio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyColors.Colors.colorRedBackgroundDark, MyColors.Colors.colorRedBackgroundLight],
                  end: FractionalOffset.topCenter,
                  begin: FractionalOffset.bottomCenter,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.repeated
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "MII MONEDERO",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Administador",
                  
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
