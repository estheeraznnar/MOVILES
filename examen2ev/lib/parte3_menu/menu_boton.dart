import 'package:flutter/material.dart';

/// Botón del menú: un elemento azul, completo (relleno) y redondeado,
/// con un icono y un texto. Reutilizable para cada celda del menú.
class MenuBoton extends StatelessWidget {
  final IconData icono;
  final String texto;
  final VoidCallback onTap;

  const MenuBoton({
    super.key,
    required this.icono,
    required this.texto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icono, color: Colors.white, size: 40),
              const SizedBox(height: 8),
              Text(
                texto,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
