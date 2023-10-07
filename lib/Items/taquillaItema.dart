import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monedero_admin/Firebase/fetch_data.dart';
import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Models/CenserModel.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Models/ventas.dart';

import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;
import 'package:monedero_admin/Screens/mainScreen.dart';
import 'package:toast/toast.dart';

class TaquillItem extends StatefulWidget {
  
  Function function;
  AdminModel taquillassModel;
  AdminModel adminmodel;
  TaquillItem({this.function,this.taquillassModel,this.adminmodel});

  @override
  State<TaquillItem> createState() => _TaquillItemState();
}

class _TaquillItemState extends State<TaquillItem> {
  bool active = true;
  String dateUser = "";
  String formattedDate = "";
  bool _showSpinner = false;
  bool sumarSaldo=false;
  TextEditingController _saldoController;
  int resultado;
   List<VentasModel> iconModelList=[];
   void getlista(String idusuario)async{
    iconModelList=await FetchData().getVentasCamionero(idusuario);
    print('Tengo ${iconModelList.length} cards');
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _saldoController= TextEditingController();
    // getlista(widget.censerModel.id);
   formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(widget.taquillassModel.createdOn);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    
    _saldoController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
   return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: GestureDetector(
        onTap: (){
          // Navigator.push(
          //     this.context,
          //     MaterialPageRoute(
          //     builder: (context) => EditCenserScreen (censerModel: widget.censerModel, function: widget.function))
          // );
          _showAlertoption(context);
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  child: Text(
                      widget.taquillassModel.nameLocal[0]
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      widget.taquillassModel.nameLocal,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      ),
                    ),
                    Text(
                      "Nombre del dueño: " + widget.taquillassModel.nameDueno,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                        widget.taquillassModel.email
                    ),
                    Text(
                      widget.taquillassModel.isSupended==false ? "Activo" : "Suspendido",
                      style: TextStyle(
                        color:  widget.taquillassModel.isSupended==false ? Color.fromARGB(255, 24, 148, 206) : Colors.red,

                      ),
                    ),
                    Text(
                        "Telefono:  ${widget.taquillassModel.numberOwner}"
                    ),
                    Text(
                        "Creado el " + formattedDate
                    ),
                    
                    Text(
                        "Saldo:  \$${sumarSaldo==false?widget.taquillassModel.saldoTaquilla:resultado} MXN"
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    
  }
  

  void _showAlertoption(BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "Agregar Saldo",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Container(
        height:MediaQuery.of(context).size.height*0.32,
        width:MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox(height: 1.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                        child: Container(
                            height: 52.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.phone,
                                    cursorColor:MyColors.Colors.colorBackgroundDark,
                                    controller: _saldoController,
                                    style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.green,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Ejemplo: 800 MXN",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Futura',
                                          color: Colors.black,
                                        )
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                   SizedBox(height: 15.0),
             MaterialButton(
              color: Color.fromARGB(255, 74, 202, 78),
              textColor:Colors.white,
              onPressed: (){
              String _Saldo = _saldoController.text.trim();
              bool SaldoValido = RegExp(r'^\d{2,10}$').hasMatch(_Saldo);

               if(_Saldo != null && SaldoValido==false){
      Toast.show("El saldo debe ser mayor a 10 pesos y solo puede contener numeros", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
      return;
    }
    int saldoAgregado =int.parse(_Saldo);
    
     if(resultado==null){
      resultado=widget.taquillassModel.saldoTaquilla+saldoAgregado;
    }else{
     resultado=resultado+saldoAgregado;
    }
           setState(() {
          
           resultado;
         });

                 setSpinnerStatus(true);
             QuerysService().UpdateSaldoTaquillas(idCenser: widget.taquillassModel.id, errorFunction: _cancelSpinnerError, function: _cancelSpinnerSuccesful(), context: context, collectionValues: {
           'saldoTaquilla':resultado,
         });
       
            
          },
             padding: EdgeInsets.only(left:60,top:17, right:60, bottom:17),
              child: Text("Agregar Saldo"),  
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                // side: BorderSide(color:Colors.blue, width:2.0),
              ),
              ),
              SizedBox(
                height:15,
              ),
             Text(
               "¿Está seguro de querer ${widget.taquillassModel.isSupended==false?"Suspender esta Taquilla?":"Activar esta Taquilla? "}",
               style: TextStyle(
                 fontFamily: 'Barlow',
                 fontWeight: FontWeight.w500,
               ),
             ),
             SizedBox(
                 height:15,
               ),
             MaterialButton(
              color: widget.taquillassModel.isSupended==false
              ?Color.fromARGB(255, 203, 50, 39)
              :Color.fromARGB(255, 74, 202, 78),
              textColor: Colors.white,
              onPressed: (){
             if( widget.taquillassModel.isSupended==true){
             QuerysService().UpdateSuspendedTrueCenserTaquilla(idCenser: widget.taquillassModel.id);
             setState(() {
               widget.taquillassModel.isSupended = false;
             });
             }else{
                 QuerysService().UpdateSuspendedFalseCamionTaquilla(idCenser: widget.taquillassModel.id);
             setState(() {
               widget.taquillassModel.isSupended = true;
             });
             }
             Navigator.of(context).pop();
           },
              padding: EdgeInsets.only(left:75,top:17, right:75, bottom:17),
               child: Text("${widget.taquillassModel.isSupended==false?"Suspender":"Activar"}",),
              
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(15),
                //  side: BorderSide(color:Colors.blue, width:2.0),
               ),
               ),
          ],
        ),
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

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }
  _cancelSpinnerError(){
    setState(() {
      _showSpinner = false;
    });
  } 
   _cancelSpinnerSuccesful()async{
    setState(() {
      _showSpinner = false;
    }); 
     AdminModel adminmodel = await FetchData().getAdmin(widget.adminmodel.id);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => MainScreen (adminModel: adminmodel)
      //     )
      // );
      setState(() {
        sumarSaldo=true;
      });
       Navigator.of(context).pop();
      setSpinnerStatus(false);
  }

  void setSpinnerStatus(bool status){
    setState(() {
      _showSpinner = status;
    });
  }
}