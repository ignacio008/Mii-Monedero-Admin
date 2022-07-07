

import 'package:monedero_admin/Firebase/querys.dart';
import 'package:monedero_admin/Models/activaciones_model.dart';
import 'package:monedero_admin/Models/adminModel.dart';
import 'package:monedero_admin/Models/stateCosto.dart';
import 'package:monedero_admin/Models/ventas.dart';

class FetchData{

    
   


   Future<List>getVentasCamionero(id)async{
     List<VentasModel>iconlistVentas=[];
     final messages= await QuerysService().getMyVentas(id);
     dynamic  miinfo=messages.docs;
     iconlistVentas=VentasModel().getVentas(miinfo);
     return iconlistVentas;
   }
  Future<List>getActivaciones(id)async{
     List<ActivacionesTotal>iconlistVentas=[];
     final messages= await QuerysService().getVentasTotalesQuery(id);
     dynamic  miinfo=messages.docs;
     iconlistVentas=ActivacionesTotal().getActivacionesTotal(miinfo);
     return iconlistVentas;
    
   }
   Future<List>getStateCostp(state)async{
     List<StateCosto>iconlistVentas=[];
     final messages= await QuerysService().getStateCosto(state);
     dynamic  miinfo=messages.docs;
     iconlistVentas=StateCosto().getStateCosto(miinfo);
     return iconlistVentas;
    
   }
   Future <AdminModel> getAdmin(id)async{  
      final messages= await QuerysService().getAdimDocument(id);
      dynamic  miinfo=messages;
      print(miinfo.data().toString());
      AdminModel adminmodel = AdminModel().getUsuario(miinfo);
      return adminmodel;
     }

   
  //  Future<List>getPago({fechaIni,fechaFini})async{
  //    List<PagoModel>iconlistVentas=[];
  //    final messages= await QuerysService().getAllPagosByDate(fechaInicial: fechaIni, fechaFinal: fechaFini);
  //    dynamic  miinfo=messages.docs;
  //    iconlistVentas=PagoModel().getPago(miinfo);
  //    return iconlistVentas;
  //  }
  
  // }
  // Future<List>getTopTienda()async{
  //   List<TiendaModel>iconlistTopChanel=[];
  //   final messages= await QuerysService().getTopTienda();
  //   dynamic  miinfo=messages.docs;
  //   iconlistTopChanel=TiendaModel().getTienda(miinfo);
  //   return iconlistTopChanel;
    
  // }
  
    
  
}