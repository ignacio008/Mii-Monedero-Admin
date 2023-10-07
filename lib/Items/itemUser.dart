import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monedero_admin/Models/UserModel.dart';

import 'package:monedero_admin/MyColors/Colors.dart' as MyColors;

import '../Firebase/querys.dart';

class UserItem extends StatefulWidget {
  UserModel userModel;
  UserItem({this.userModel});

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  bool active = true;
  String dateUser = "";
  String formattedDate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(widget.userModel.createdOn);

    DateTime now = DateTime.now();
    int isActive = now.compareTo(widget.userModel.activeUntil);

    if (isActive == 1) {
      print("Usuario inactivo");
      active = false;
    } else {
      active = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          /*Navigator.push(
              this.context,
              MaterialPageRoute(
              builder: (context) => DetallesUsuarioScreen (usuariosModel: widget.usuariosModel))
          );*/
          _showAlertoption(context);
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  child: Text(widget.userModel.name[0]),
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
                      widget.userModel.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.userModel.email),
                    Text(
                      active
                          ? "Vigente hasta el " +
                              DateFormat('yyyy-MM-dd')
                                  .format(widget.userModel.activeUntil)
                          : "No vigente",
                      style: TextStyle(
                        color: active
                            ? Color.fromARGB(255, 24, 148, 206)
                            : Colors.red,
                      ),
                    ),
                    Text(widget.userModel.locality +
                        ", " +
                        widget.userModel.state),
                    Text("Creado el " + formattedDate),
                    Text(widget.userModel.suspended?"Usuario Suspendido":"Usuario Activo", style: 
                    TextStyle(
                      color: widget.userModel.suspended?Colors.red:Colors.green,
                    ),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertoption(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "Seleciona una opcion",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.2,
            minHeight: MediaQuery.of(context).size.height * 0.18),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "¿Está seguro de querer ${widget.userModel.suspended == false ? "Suspender a este Usuario?" : "Activar este Usuario? "}",
              style: TextStyle(
                fontFamily: 'Barlow',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              color: widget.userModel.suspended == true
                  ? Color.fromARGB(255, 74, 202, 78)
                  : Color.fromARGB(255, 203, 50, 39),
              textColor: Colors.white,
              onPressed: () {
                if (widget.userModel.suspended == true) {
                  QuerysService()
                      .UpdateSuspendedTrueUsers(idCenser: widget.userModel.id);
                  setState(() {
                    widget.userModel.suspended = false;
                  });
                } else {
                  QuerysService().UpdateSuspendedFalseUsers(
                      idCenser: widget.userModel.id);
                  setState(() {
                    widget.userModel.suspended = true;
                  });
                }
                Navigator.of(context).pop();
              },
              padding:
                  EdgeInsets.only(left: 70, top: 17, right: 70, bottom: 17),
              child: Text(
                "${widget.userModel.suspended == false ? "Suspender" : "Activar"}",
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                // side: BorderSide(color: Colors.blue, width: 2.0),
              ),
            ),
             SizedBox(
              height: 15,
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

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
