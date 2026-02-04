import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class StorageScreen extends StatefulWidget {
   
  const StorageScreen({Key? key}) : super(key: key);

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}


//HAY QUE PONER LA DEPENDENCIA DE FILEPICKER

class _StorageScreenState extends State<StorageScreen> {

  PlatformFile? selectedFile;
  UploadTask? uploadTask; //Me dice si se ha subido el archivo o no

  //Funcion para seleccionar el archivo
  Future _seleccionarArchivo() async {
    final result = await FilePicker.platform.pickFiles();
    if ( result == null ) return;
    setState(() {
      selectedFile = result.files.first;
    });
  }

  //Funcion para subir el archivo
  Future _subirArchivo() async{
    if (selectedFile == null) return;
    final path =  'dam2/${selectedFile!.name}'; //path donde quiero guardar el archivo
    final file =  File(selectedFile!.name);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    //Puedo esperar a que la tarea se complete
    final snapshot = await uploadTask!.whenComplete((){});

    //coge la url del archivo
    final dowloadUrl = await ref.getDownloadURL();
    print('Archivo subido correctamente a: ${dowloadUrl}');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subir Archivo'),), 
      body: Center(
         child:Column(
          mainAxisAlignment: .center,
          children: [

            if ( selectedFile != null ) Container(
              height: 350,
              color: Colors.blue[100],
              child: //Text('Archivo seleccionado: ${selectedFile!.name}')
              Image.file( 
                File(selectedFile!.path!),
                fit: .cover,
                width: double.infinity,
              ),
            ) else 
            Icon(Icons.cloud_upload, size: 100, color: Colors.blue,),


            SizedBox(height: 24,),
            Text('Aquí puedes subir archivos a la nube', style: TextStyle(fontSize: 18),),

            SizedBox(height: 24,),
            ElevatedButton(onPressed: _seleccionarArchivo,
             child: Text('Seleccionar archivo')),
            SizedBox(height: 24,),
            // Lógica para SUBIR archivos
            ElevatedButton(onPressed: _subirArchivo,
             child: Text('Subir archivo')),
          ],
         )
      ),
    );
  }
}