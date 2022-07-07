import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monedero_admin/Models/UserModel.dart';

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
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(widget.userModel.createdOn);

    DateTime now = DateTime.now();
    int isActive = now.compareTo(widget.userModel.activeUntil);

    if(isActive == 1){
      print("Usuario inactivo");
      active = false;
    }
    else{
      active = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: GestureDetector(
        onTap: (){
          /*Navigator.push(
              this.context,
              MaterialPageRoute(
              builder: (context) => DetallesUsuarioScreen (usuariosModel: widget.usuariosModel))
          );*/
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  child: Text(
                      widget.userModel.name[0]
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
                      widget.userModel.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                        widget.userModel.email
                    ),
                    Text(
                      active ? "Vigente hasta el " + DateFormat('yyyy-MM-dd').format(widget.userModel.activeUntil)  : "No vigente",
                      style: TextStyle(
                        color: active ? Color.fromARGB(255, 24, 148, 206) : Colors.red,

                      ),
                    ),
                    Text(
                        widget.userModel.locality + ", " + widget.userModel.state
                    ),
                    Text(
                      "Creado el " + formattedDate
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
}
