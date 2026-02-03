import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  //Obtenemos la instancia
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ////////////////////////////////////////////
  ///Obtener todas las lateas del usuario ///
  //////////////////////////////////////////
  
  /*
  Stream<List<Map<String, dynamic>>> obtenerTareas(){
    try {
      return _firestore
        .collection('tareas')
        .snapshots()
    } catch (e) {
      
    }
  }*/

}