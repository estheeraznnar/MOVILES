import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_dam/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String pass = "";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _authService = AuthService();
  bool _isLoding = false;

  @override
  void dispose(){
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
//Para que el boton solo se pueda pulsar una vez o si hay un error nos muestre que error es
  Future<void> _signIn() async{
    //antes de setState hay que hacer esto, lo que compruebo es que los validadores esten correctos sino se sale de ahi
    if(_formKey.currentState!.validate()) return;
    setState(() => _isLoding = true);
    try{
      _authService.iniciarSesion(
        email: _emailController.text.trim(), 
        password: _passController.text
      );
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

  Future<void> _logueoConGoogle() async{
    setState(() => _isLoding = true);
    try {
      final UserCredential = await _authService.loginConGoogle();
      if (UserCredential != null) {
        //Aqui nuestro stream lo detectara automaticametne y ya pasaremos a nuestra pagina de home
        print('Usuario logueado con google correctamente');
      }
    } catch (e) {
      throw FirebaseAuthException(code: 'Error con google');
    }
    finally{
      setState(() => _isLoding = false);
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
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Color(0xFFB2B7BF),
                            fontSize: 18,
                          ),
                        ),
                        //compruebo que todos los validadores son correctos 
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
                      onTap: _isLoding ? null : _signIn,
                      child: Container(
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
                            "Login with Firebase",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        '¿Contraseña olvidada?',
                        style: TextStyle(
                          color: Color(0xFF8C8E98),
                          fontSize: 15,
                          fontWeight: .w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'O Logueate con: ',
                      style: TextStyle(
                        color: Color(0xFF273671),
                        fontSize: 15,
                        fontWeight: .w500,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        GestureDetector(
                          onTap: _isLoding ? null: _logueoConGoogle,
                          child: Image.asset(
                            'assets/google.png',
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/apple1.png',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          '¿Aún no tienes cuenta?',
                          style: TextStyle(
                            color: Color(0xFF8C8E98),
                            fontSize: 15,
                            fontWeight: .w500,
                          ),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context, 
                              '/register'
                            );
                          },
                          child: Text(
                            'Registrar Usuario',
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
