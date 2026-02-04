import 'package:firebase_flutter_dam/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({super.key});

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  final Stream<QuerySnapshot> _tareasScreen = FirebaseFirestore.instance
      .collection('tareas')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currenUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista tareas'),
        actions: [
          IconButton(
            onPressed: () async {
              //Mostrar un dialogo de confirmacion
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: Text('Cerrar Sesion'),
                  content: Text('¿Estás seguro que quieres cerrar la sesión?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        'Aceptar',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              );
              if (shouldLogout == true) {
                await authService.cerrarSesion();
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _tareasScreen,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error al descargar los datos');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              String docId = document.id;
              return ListTile(
                title: Text(data['titulo']),
                subtitle: Text(data['descripcion']),
                trailing: Row(
                  mainAxisSize: .min,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pushNamed(
                          context,
                          '/add_tarea',
                          arguments: {
                            'id': docId,
                            'titulo': data['titulo'],
                            'descripcion': data['descripcion']
                          }
                        );
                      }, 
                      icon: Icon(
                        Icons.edit, 
                        color: Colors.blue,
                      )
                    ),
                    IconButton(
                      onPressed: () async{
                        final showlDelete = await showDialog<bool>(
                          context: context, 
                          builder: (context) => AlertDialog.adaptive(
                            title: Text('¿Estas seguro de querer eliminar esta tarea?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false), 
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true), 
                                child: Text('Eliminar'),
                              ),
                            ],
                          ),
                        );
                        if (showlDelete == true) {
                          //Eliminamos la tarea de Firebase
                          await FirebaseFirestore.instance
                            .collection('tareas')
                            .doc(docId)
                            .delete();
                        }
                      }, 
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_tarea');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
