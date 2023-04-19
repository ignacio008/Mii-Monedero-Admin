import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:monedero_admin/Models/camionesModel.dart';
import 'package:monedero_admin/Models/codeModel.dart';
import 'package:monedero_admin/Screens/qrScreen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Firebase/fetch_data.dart';
import '../Models/CenserModel.dart';
import '../Models/adminModel.dart';
import '../Models/ventas.dart';


class InputScreenCamion extends StatefulWidget {
  CamionesModel camionesModel;
  Function function;
  AdminModel adminmodel;
  InputScreenCamion({this.camionesModel, this.function, this.adminmodel});

  @override
  State<InputScreenCamion> createState() => _InputScreenCamionState();
}

class _InputScreenCamionState extends State<InputScreenCamion> {
  bool _showSpinner = false;
  bool active = true;
  String dateUser = "";
  String formattedDate = "";
  int nuevoCosto;
  List<VentasModel> iconModelList = [];
  String myCode;
  CodeModel codeModel;

  void getlista(String idusuario) async {
    iconModelList = await FetchData().getVentasCamionero(idusuario);
    setState(() {});
    print('Tengo ventas ${iconModelList.length} cards');
  }

  @override
  void initState() {
    // TODO: implement initState

    getlista(widget.camionesModel.idCamion);
    codeModel = CodeModel(id: widget.camionesModel.idCamion,
    locality: widget.camionesModel.locality,
    state: widget.camionesModel.state);
    myCode = json.encode(codeModel.toMap());
    print(myCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
        },
        child: GestureDetector(
          onTap: () {
          Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => QrScreen(camionesModel: widget.camionesModel,
                                   adminmodel: widget.adminmodel,)
                               )
                           );
          },
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    child: Text("C"),
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
                        "${widget.camionesModel.nameRuta[0].toUpperCase()}${widget.camionesModel.nameRuta.substring(1, widget.camionesModel.nameRuta.length)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      Text(
                        "${widget.camionesModel.state[0].toUpperCase()}${widget.camionesModel.state.substring(1, widget.camionesModel.state.length)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "${widget.camionesModel.locality[0].toUpperCase()}${widget.camionesModel.locality.substring(1, widget.camionesModel.locality.length)}"),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: QrImage(
                    data: myCode,
                    version: QrVersions.auto,
                    size: 50,
                    gapless: false,
                    foregroundColor: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
