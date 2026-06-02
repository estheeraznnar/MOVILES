import 'package:flutter/material.dart';

class BotonMenu extends StatelessWidget {
  const BotonMenu(IconData icon, String label, {super.key})
    : _icon = icon,
      _label = label;

  final IconData _icon;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent.shade700,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            _label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
