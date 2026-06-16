import 'package:flutter/material.dart';

//Esto es la transion que hacen los elementos de ir poco a poco cuando le pulsas
//permiten hacer efectos sin crear un AnimationController manual
//intervalStart e intervalEnd están declarados pero aquí mismo no se usan realmente.
// Widget reutilizable que hace aparecer un hijo con una animación de opacidad
class FadeAnimationWidget extends StatelessWidget {
  const FadeAnimationWidget({
    super.key, 
    this.begin = 0.0, 
    this.end = 1.0, 
    this.duration = const Duration(milliseconds: 3000), 
    this.intervalStart = 0.0, 
    this.intervalEnd = 1.0, 
    this.curve = Curves.fastEaseInToSlowEaseOut, 
    required this.child
  });

  final double begin;
  final double end;
  final Duration duration;
  final double intervalStart;
  final double intervalEnd;
  final Curve curve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: begin, end: end), 
      duration: duration, 
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child,);
      },
      child: child,
    );
  }
}