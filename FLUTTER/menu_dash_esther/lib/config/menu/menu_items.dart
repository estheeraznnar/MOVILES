import 'package:flutter/material.dart';
import 'package:menu_dash/config/theme/app_theme.dart';
import 'package:menu_dash/widgets/option_menu_item.dart';

class MenuItems {
  List<OptionMenuItem> get listOptionMenuItem => [

    OptionMenuItem(
      color: AppTheme.listaColores[0], 
      iconData: Icons.sports_basketball_rounded, 
      texto: 'Marcador Baloncesto', 
      screenName: 'contadorbaloncesto',
    ),
    OptionMenuItem(
      color: AppTheme.listaColores[1], 
      iconData: Icons.pets_outlined, 
      texto: 'API Perros', 
      screenName: 'apiperros',
    ),
    OptionMenuItem(
      color: AppTheme.listaColores[2], 
      iconData: Icons.supervised_user_circle, 
      texto: 'API JsonPlaceHolder', 
      screenName: 'api1',
    ),
    OptionMenuItem(
      color: AppTheme.listaColores[3], 
      iconData: Icons.local_drink, 
      texto: 'API Simpsons', 
      screenName: 'simpsons',
    ),
    OptionMenuItem(
      color: AppTheme.listaColores[4], 
      iconData: Icons.design_services, 
      texto: 'Diseño', 
      screenName: 'estilos',
    ),
    
    OptionMenuItem(
      color: AppTheme.listaColores[5], 
      iconData: Icons.qr_code_2_sharp, 
      texto: 'Lector QR', 
      screenName: 'lectorQr',
    ),
    
    OptionMenuItem(
      color: AppTheme.listaColores[6], 
      iconData: Icons.snowmobile, 
      texto: 'Opcion 7', 
      screenName: 'opcion 7',
    ),
    
    OptionMenuItem(
      color: AppTheme.listaColores[7], 
      iconData: Icons.move_to_inbox_outlined, 
      texto: 'Opcion 8', 
      screenName: 'opcion 8',
    ),
    



  ];
}