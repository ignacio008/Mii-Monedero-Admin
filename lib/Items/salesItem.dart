import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monedero_admin/Models/pagoModelItem.dart';
import 'package:monedero_admin/Models/salesModel.dart';

class SalesItem extends StatefulWidget {

  PagoModelItem salesModel;
  List<PagoModelItem> salesList;
  SalesItem({this.salesModel, this.salesList});

  @override
  _SalesItemState createState() => _SalesItemState();
}

class _SalesItemState extends State<SalesItem> {

  List<PagoModelItem> sales = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        sales.clear();
        for(int i = 0; i < widget.salesList.length; i++){
          if(widget.salesList[i].idCamion == widget.salesModel.idCamion){
            sales.add(widget.salesList[i]);
          }
        }
        _showDetailsDialog();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  child: Text(
                      widget.salesModel.nameCamionero[0]
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
                      widget.salesModel.nameCamionero,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                    Text(
                      "Folio: ${widget.salesModel.idPago}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                      ),
                    ),
                    Text(
                      "Email:  ${widget.salesModel.email}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                        "Número de telefono: ${widget.salesModel.numeroCamionero}"
                    ),
                    Text(
                        "Placa: ${widget.salesModel.placa.toUpperCase()}"
                    ),
                    Text(
                        "Número de Pagos realizados: ${widget.salesModel.numberSales.toString()}"
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

  void _showDetailsDialog(){
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "DETALLE DE VENTAS",
        style: TextStyle(
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
            itemCount: sales.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                        "Monto de pago: \$355 MXN" ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                        "Fecha pago: " + DateFormat('yyyy-MM-dd – kk:mm').format(sales[index].fechaPago)
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
              );
            }
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text(
            "Cancelar",
            style: TextStyle(
              fontSize: 16.0,
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

}
