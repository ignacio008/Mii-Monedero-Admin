import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Models/camionesModel.dart';
import 'package:monedero_admin/Models/codeModel.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatefulWidget {
  CamionesModel camionesModel;
  AdminModel adminmodel;
  QrScreen({this.camionesModel, this.adminmodel});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  String myCode;
  CodeModel codeModel;
  @override
  void initState() {
    // TODO: implement initState
    codeModel = CodeModel(
        id: widget.camionesModel.idCamion,
        locality: widget.camionesModel.locality,
        state: widget.camionesModel.state);
    myCode = json.encode(codeModel.toMap());
    print(myCode);
    print("vista");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR"),
      ),
      body: Container(
        child: Center(
          child: QrImage(
            data: myCode,
            version: QrVersions.auto,
            size: 250,
            gapless: false,
            foregroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
