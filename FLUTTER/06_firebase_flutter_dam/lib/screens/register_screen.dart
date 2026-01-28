import 'package:firebase_flutter_dam/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String email = "";
  String pass = "";
  String nombre = "";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _authService = AuthService();
  bool _isLoding = false;
  @override
  void dispose(){
    _nombreController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async{
    //antes de setState hay que hacer esto, lo que compruebo es que los validadores esten correctos sino se sale de ahi
    if(_formKey.currentState!.validate()) return;
    setState(() => _isLoding = true);
    try{
      _authService.registroConEmailYContrasena(
        email: _emailController.text.trim(), 
        password: _passController.text
      );

      //tenemos que mostrar un mensaje de exito
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuario creado correctamente'),
            backgroundColor: const Color.fromARGB(255, 168, 255, 168),
          )
        );
      }
      
      Navigator.pop(context);

      //no necesitamos navegar manualmente, el stream builder lo hace automaticamente
    }catch(e){
      //Mostramos el mensaje al usuario
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: const Color.fromARGB(255, 255, 126, 126),
          )
        );
      }
    }finally{
      if(mounted){
        setState(() => _isLoding = false);
      }
    }
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/car.PNG", fit: BoxFit.cover),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 2.0,
                        horizontal: 30.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFEDf0f8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _nombreController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nombre",
                          hintStyle: TextStyle(
                            color: Color(0xFFB2B7BF),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 2.0,
                        horizontal: 30.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFEDf0f8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Color(0xFFB2B7BF),
                            fontSize: 18,
                          ),
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Porfavor ingrsa un correo';
                          }
                          if(value.contains('@')){
                            return 'Porfavor ingrsa un correo';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 2.0,
                        horizontal: 30.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFEDf0f8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Color(0xFFB2B7BF),
                            fontSize: 18,
                          ),
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Porfavor ingrsa una contraseña';
                          }
                          if(value.length<6){ //Se pueden meter mas caracteres requeridos
                            return 'La contraseña debe de tener almenos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: _isLoding ? null : _signUp,
                      child: _isLoding? SizedBox(
                        height: 30,
                        width: 20,
                        child: CircularProgressIndicator.adaptive(),
                      ) : Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF273671),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Registrar Usuario",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            color: Color(0xFF8C8E98),
                            fontSize: 15,
                            fontWeight: .w500,
                          ),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Ir a Login',
                            style: TextStyle(
                              color: Color(0xFF273671),
                              fontSize: 16,
                              fontWeight: .w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}