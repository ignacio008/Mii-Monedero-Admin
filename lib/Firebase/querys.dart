import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import 'firebase_referencias.dart';

class QuerysService{

  final _fireStore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getAllCategories() async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CATEGORIES).get();
  }

  Future<QuerySnapshot> getAllUsersByDateTime() async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_USERS).orderBy('createdOn', descending: true).limit(20).get();
  }
  Future<DocumentSnapshot> getAdimDocument(id) async{
   return await _fireStore.collection("Admin").doc(id).get();
   }

  Future<QuerySnapshot> getAllUsersByState({String state}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_USERS).where('state', isEqualTo: state).orderBy('createdOn', descending: true).limit(20).get();
  }
   Future<QuerySnapshot>getVentasTotalesQuery(String idCamion)async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_Activacions).where("idCamion",isEqualTo:idCamion).get();
  }
  Future<QuerySnapshot>getStateCosto(String state)async{
    return await _fireStore.collection("PrecioEstados").where("state",isEqualTo:state).get();
  }

  Future<QuerySnapshot> getAllUsersByStateAndCity({String state, String city}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_USERS).where('locality', isEqualTo: city).where('state', isEqualTo: state).orderBy('createdOn', descending: true).limit(20).get();
  }

  Future<QuerySnapshot> getAllUsersByEmail({String email}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_USERS).where('email', isEqualTo: email).get();
  }

  Future<QuerySnapshot> getAllCensersByCategory({String category}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CENSERS).where('category', isEqualTo: category).where("active", isEqualTo: true).where("completed", isEqualTo: true).get();
  }

  Future<QuerySnapshot> getAllCensers() async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CENSERS).orderBy("createdOn", descending: true).limit(20).get();
  }
  Future<QuerySnapshot> getAllCamiones() async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CAMIONES).orderBy("createdOn", descending: true).limit(20).get();
  }
  Future<QuerySnapshot> getAllCensersTAQUILLA() async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_ADMIN).where('type', isEqualTo: "taquilla").orderBy("createdOn", descending: true).limit(20).get();
  }

  Future<QuerySnapshot> getCensersByEmail({String email}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CENSERS).where('email', isEqualTo: email).get();
  }

   Future<QuerySnapshot> getCensersNameRuta({String nameRuta}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CAMIONES).where('nameRuta', isEqualTo: nameRuta).get();
  }


  Future<QuerySnapshot> getCensersByEmailTaquilla({String email}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_ADMIN).where('email', isEqualTo: email).get();
  }

  Future<QuerySnapshot> getCensersByState({String state}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CENSERS).where('state', isEqualTo: state).orderBy("createdOn", descending: true).limit(20).get();
  }

  Future<QuerySnapshot> getCensersByStateAndCity({String state, String city}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CENSERS).where('state', isEqualTo: state).where('locality', isEqualTo: city).orderBy("createdOn", descending: true).limit(20).get();
  }


  Future<QuerySnapshot> getAllSalesByDate({DateTime fechaInicial, DateTime fechaFinal}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_EARNINGS).where('dateTime', isGreaterThanOrEqualTo: fechaInicial).where('dateTime', isLessThanOrEqualTo: fechaFinal).get();
  }



  //ESCANEOS
  Future<QuerySnapshot> getAllScaneosByDate({DateTime fechaInicial, DateTime fechaFinal, String idCamion}) async{
    return await _fireStore.collection("Scaneos").where('idCamion', isEqualTo: idCamion).where('createOn', isGreaterThanOrEqualTo: fechaInicial).where('createOn', isLessThanOrEqualTo: fechaFinal).get();
  }
  Future<QuerySnapshot> getAllVentasActivandoUsuarioByDate({DateTime fechaInicial, DateTime fechaFinal, String idCamion}) async{
    return await _fireStore.collection("Earnings").where('storeId', isEqualTo: idCamion).where('dateTime', isGreaterThanOrEqualTo: fechaInicial).where('dateTime', isLessThanOrEqualTo: fechaFinal).get();
  }





  Future<QuerySnapshot> getAllPagosByDate({DateTime fechaInicial, DateTime fechaFinal}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_EstadoPagoCamionero).where('fechaPago', isGreaterThanOrEqualTo: fechaInicial).where('fechaPago', isLessThanOrEqualTo: fechaFinal).where('status', isEqualTo: "Aprobado").get();
  }





  Future<QuerySnapshot> getAllSalesByDateAndSateLocality({DateTime fechaInicial, DateTime fechaFinal, String state, String locality}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_EARNINGS).where('dateTime', isGreaterThanOrEqualTo: fechaInicial).where('dateTime', isLessThanOrEqualTo: fechaFinal).where("state", isEqualTo: state).where("locality", isEqualTo: locality).get();
  }

  Future<QuerySnapshot> getMiInfo({String miId}) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_ADMIN).where('id', isEqualTo: miId).get();
  }

  void SaveUsuario({String idUsuario,BuildContext context, Function function, Function errorFunction, Map<String, dynamic> collectionValues}) async {
    bool error = false;

    await _fireStore.collection(FirebaseReferencias.REFERENCE_USERS).doc(idUsuario).set(collectionValues).catchError((onError){
      Toast.show("Ha ocurrido un error, por favor, intente de nuevo", context, duration: Toast.LENGTH_LONG);
      error = true;
    }).then((onValue){
      if(!error){
        Toast.show("¡Información subida exitosamente!", context, duration: Toast.LENGTH_LONG);
        function();
      }
      else{
        errorFunction();
      }
    });
  }

  void SaveCenser({String idCenser,BuildContext context, Function function, Function errorFunction, Map<String, dynamic> collectionValues}) async {
    bool error = false;

    await _fireStore.collection(FirebaseReferencias.REFERENCE_CENSERS).doc(idCenser).set(collectionValues).catchError((onError){
      Toast.show("Ha ocurrido un error, por favor, intente de nuevo", context, duration: Toast.LENGTH_LONG);
      error = true;
    }).then((onValue){
      if(!error){
        Toast.show("¡Información subida exitosamente!", context, duration: Toast.LENGTH_LONG);
        function();
      }
      else{
        errorFunction();
      }
    });
  }
   void SaveCamiones({String idCenser,BuildContext context, Function function, Function errorFunction, Map<String, dynamic> collectionValues}) async {
    bool error = false;

    await _fireStore.collection(FirebaseReferencias.REFERENCE_CAMIONES).doc(idCenser).set(collectionValues).catchError((onError){
      Toast.show("Ha ocurrido un error, por favor, intente de nuevo", context, duration: Toast.LENGTH_LONG);
      error = true;
    }).then((onValue){
      if(!error){
        Toast.show("¡Información subida exitosamente!", context, duration: Toast.LENGTH_LONG);
        function();
      }
      else{
        errorFunction();
      }
    });
  }
    void SaveTaquilla({String idCenser,BuildContext context, Future function, Function errorFunction, Map<String, dynamic> collectionValues}) async {
    bool error = false;

     _fireStore.collection(FirebaseReferencias.REFERENCE_ADMIN).doc(idCenser).set(collectionValues).catchError((onError){
      Toast.show("Ha ocurrido un error, por favor, intente de nuevo", context, duration: Toast.LENGTH_LONG);
      error = true;
    }).then((onValue){
      if(!error){
        Toast.show("¡Información subida exitosamente!", context, duration: Toast.LENGTH_LONG);
        Future;
      }
      else{
        errorFunction();
      }
    });
  }

  UpdateUsuario({String collectionName, String idUsuario, Map<String, dynamic> collectionValues}) async {
    return await _fireStore.collection(collectionName).doc(idUsuario).set(collectionValues);
    //_fireStore.collection(collectionName).document("").add(collectionValues);
  }

  UpdateSuspendedTrueCenser({String idCenser, Function function}) async {
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CENSERS).doc(idCenser).update({"suspended": false});
  }
  UpdateSuspendedTrueCenserTaquilla({String idCenser, Function function}) async {
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_ADMIN).doc(idCenser).update({"isSupended": false});
  }
  UpdateSaldoTaquilla({String idCenser, Function function, int agregarsaldo}) async {
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_ADMIN).doc(idCenser).update({"saldoTaquilla": agregarsaldo});
  }

void UpdateSaldoTaquillas({String idCenser,BuildContext context, Future function, Function errorFunction, Map<String, dynamic> collectionValues}) async {
    bool error = false;

     _fireStore.collection(FirebaseReferencias.REFERENCE_ADMIN).doc(idCenser).update(collectionValues).catchError((onError){
      Toast.show("Ha ocurrido un error, por favor, intente de nuevo", context, duration: Toast.LENGTH_LONG);
      error = true;
    }).then((onValue){
      if(!error){
        Toast.show("¡Se ha efectuado el pago con exito!", context, duration: Toast.LENGTH_LONG);
        Future;
      }
      else{
        errorFunction();
      }
    });
  }

  void saveEstadoPagoCamionero({String idCenser,BuildContext context, Future function, Function errorFunction, Map<String, dynamic> collectionValues}) async {
    bool error = false;

     _fireStore.collection(FirebaseReferencias.REFERENCE_EstadoPagoCamionero).doc(idCenser).set(collectionValues).catchError((onError){
      Toast.show("Ha ocurrido un error, por favor, intente de nuevo", context, duration: Toast.LENGTH_LONG);
      error = true;
    }).then((onValue){
      if(!error){
        Toast.show("¡Se ha efectuado el pago con exito!", context, duration: Toast.LENGTH_LONG);
        Future;
      }
      else{
        errorFunction();
      }
    });
  }
  void saveActivacionesPagoCamionero({String idCenser,BuildContext context, Future function, Function errorFunction, Map<String, dynamic> collectionValues}) async {
    bool error = false;

     _fireStore.collection(FirebaseReferencias.REFERENCE_Activacions).doc(idCenser).update(collectionValues).catchError((onError){
      Toast.show("Ha ocurrido un error, por favor, intente de nuevo", context, duration: Toast.LENGTH_LONG);
      error = true;
    }).then((onValue){
      if(!error){
        Toast.show("¡Se ha efectuado el pago con exito!", context, duration: Toast.LENGTH_LONG);
        Future;
      }
      else{
        errorFunction();
      }
    });
  }

   Future<bool> SaveGeneralInfoEstadoPago({String reference, String id, Map<String, dynamic> collectionValues}) async {
    bool error = false;
    SetOptions setOptions = SetOptions(merge: true);
    return await _fireStore.collection(reference).doc(id).set(collectionValues, setOptions).catchError((onError){
      error = true;
      return true;
    }).then((onValue){
      if(!error){
        error = false;
        return error;
      }
      else{
        error = true;
        return error;
      }
    });
  }
  Future<bool> UpdateInfoActivaciones({String reference, String id, Map<String, dynamic> collectionValues}) async {
    bool error = false;
    SetOptions setOptions = SetOptions(merge: true);
    return await _fireStore.collection(reference).doc(id).update(collectionValues).catchError((onError){
      error = true;
      return true;
    }).then((onValue){
      if(!error){
        error = false;
        return error;
      }
      else{
        error = true;
        return error;
      }
    });
  }
  Future<bool> UpdateInfoActivacionesCenser({String reference, String id, Map<String, dynamic> collectionValues}) async {
    bool error = false;
    SetOptions setOptions = SetOptions(merge: true);
    return await _fireStore.collection(reference).doc(id).update(collectionValues).catchError((onError){
      error = true;
      return true;
    }).then((onValue){
      if(!error){
        error = false;
        return error;
      }
      else{
        error = true;
        return error;
      }
    });
  }
  Future<bool> UpdateInfoSaldoTaquilla({String reference, String id, Map<String, dynamic> collectionValues}) async {
    bool error = false;
    SetOptions setOptions = SetOptions(merge: true);
    return await _fireStore.collection(reference).doc(id).update(collectionValues).catchError((onError){
      error = true;
      return true;
    }).then((onValue){
      if(!error){
        error = false;
        return error;
      }
      else{
        error = true;
        return error;
      }
    });
  }




  UpdateSuspendedFalseCamion({String idCenser, Function function}) async {
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CENSERS).doc(idCenser).update({"suspended": true});
  }
  UpdateSuspendedFalseCamionTaquilla({String idCenser, Function function}) async {
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_ADMIN).doc(idCenser).update({"isSupended": true});
  }

  UpdateSuspendedFalseCenser({String idCenser, Function function}) async {
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_CENSERS).doc(idCenser).update({"suspended": false});
  }
    Future<QuerySnapshot> getMyVentas(String miId) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_EARNINGS).where('storeId', isEqualTo: miId).orderBy('dateTime', descending: true).get();
  }

Future<QuerySnapshot> getMyActivaciones(String miId) async{
    return await _fireStore.collection(FirebaseReferencias.REFERENCE_Activacions).where('idCamion', isEqualTo: miId).orderBy('dateTime', descending: true).get();
  }

  Future<String> uploadProfilePhoto({File file, String id}) async {

    final Reference storageReference = FirebaseStorage.instance.ref().child("Users").child(id + "-profile.png");
    final UploadTask uploadTask = storageReference.putFile(file);
    var dowurl = await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
    String url = dowurl.toString();
    return url;
  }

  void updateFotosEstablecimientoData({String idEstablecimiento, BuildContext context, List<String> collectionValues}) async{
    bool error = false;
    await _fireStore.collection(FirebaseReferencias.REFERENCE_CENSERS).doc(idEstablecimiento).update({"photos": collectionValues}).catchError((onError){
      Toast.show("Ha ocurrido un error, por favor, intente de nuevo", context, duration: Toast.LENGTH_LONG);
      error = true;
    }).then((onValue){
      if(!error){
        Toast.show("¡Información actualizada exitosamente!", context, duration: Toast.LENGTH_LONG);
      }
    });
  }
 Future<bool> SaveGeneralInfo({String reference, String id, Map<String, dynamic> collectionValues}) async {
    bool error = false;
    SetOptions setOptions = SetOptions(merge: true);
    return await _fireStore.collection(reference).doc(id).set(collectionValues, setOptions).catchError((onError){
      error = true;
      return true;
    }).then((onValue){
      if(!error){
        error = false;
        return error;
      }
      else{
        error = true;
        return error;
      }
    });
  }
  Future<bool> UpdateGeneralInfo({String reference, String id, Map<String, dynamic> collectionValues}) async {
    bool error = false;
    SetOptions setOptions = SetOptions(merge: true);
    return await _fireStore.collection(reference).doc(id).update(collectionValues).catchError((onError){
      error = true;
      return true;
    }).then((onValue){
      if(!error){
        error = false;
        return error;
      }
      else{
        error = true;
        return error;
      }
    });
  }

}