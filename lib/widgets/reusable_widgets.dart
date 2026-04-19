/// Widgets reutilizables para la aplicación M3E Demo.
///
/// Este archivo centraliza componentes que se usan en múltiples pantallas,
/// facilitando consistencia visual y mantenimiento.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Widget de tarjeta de módulo reutilizable con patrón MVVM.
///
/// Permite crear tarjetas de módulos con estado, animaciones y acciones.
/// Se usa para paneles como Routines, Focus, Finance, etc.
///
/// Parámetros:
/// - [title]: Título del módulo (ej: "Routines")
/// - [icon]: Icono del módulo
/// - [backgroundColor]: Color de fondo
/// - [child]: Widget contenido dentro de la tarjeta
/// - [onTap]: Callback cuando se toca la tarjeta
/// - [hasAnimation]: Si aplica animación de entrada
///
/// Ejemplo:
/// ```dart
/// ModuleCard(
///   title: 'Focus',
///   icon: Icons.focus_center,
///   backgroundColor: Colors.blue,
///   child: Text('Sesión de foco'),
///   onTap: () { ... },
/// )
/// ```
class ModuleCard extends StatelessWidget {
  /// Título del módulo.
  final String title;

  /// Icono del módulo.
  final IconData icon;

  /// Color de fondo de la tarjeta.
  final Color backgroundColor;

  /// Widget contenido dentro de la tarjeta.
  final Widget child;

  /// Callback cuando se toca la tarjeta. Opcional.
  final VoidCallback? onTap;

  /// Si aplica animación de entrada. Defecto: true.
  final bool hasAnimation;

  /// Relleno interno. Defecto: 16.
  final double padding;

  const ModuleCard({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.child,
    this.onTap,
    this.hasAnimation = true,
    this.padding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: backgroundColor),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: backgroundColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              child,
            ],
          ),
        ),
      ),
    );

    // Aplicar animación si está habilitada
    if (hasAnimation) {
      card = card
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 400))
          .scaleXY(begin: 0.9);
    }

    return card;
  }
}

/// Widget contador reutilizable con estilo M3E.
///
/// Muestra un número con animaciones y proporciona botones para incrementar/decrementar.
///
/// Ejemplo:
/// ```dart
/// CounterWidget(
///   value: 42,
///   label: 'Pasos',
///   onIncrement: () { ... },
/// )
/// ```
class CounterWidget extends StatelessWidget {
  /// Valor actual del contador.
  final int value;

  /// Etiqueta descriptiva del contador.
  final String label;

  /// Callback para incrementar.
  final VoidCallback? onIncrement;

  /// Callback para decrementar.
  final VoidCallback? onDecrement;

  /// Color del contador. Defecto: tema primario.
  final Color? color;

  const CounterWidget({
    required this.value,
    required this.label,
    this.onIncrement,
    this.onDecrement,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = color ?? Theme.of(context).primaryColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: primaryColor, width: 2),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            '$value',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ).animate().scale(duration: const Duration(milliseconds: 300)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (onDecrement != null)
              IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: onDecrement,
                color: primaryColor,
              ),
            if (onIncrement != null)
              IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: onIncrement,
                color: primaryColor,
              ),
          ],
        ),
      ],
    );
  }
}

/// Widget de botón de control reutilizable.
///
/// Botón con icono y efecto hover, pensado para acciones comunes.
///
/// Ejemplo:
/// ```dart
/// ControlButton(
///   icon: Icons.play_arrow,
///   label: 'Play',
///   onPressed: () { ... },
/// )
/// ```
class ControlButton extends StatelessWidget {
  /// Icono del botón.
  final IconData icon;

  /// Etiqueta del botón.
  final String label;

  /// Callback al presionar.
  final VoidCallback onPressed;

  /// Color del botón. Defecto: tema primario.
  final Color? color;

  /// Tamaño del icono. Defecto: 24.
  final double iconSize;

  const ControlButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final btnColor = color ?? Theme.of(context).primaryColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: btnColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(icon, size: iconSize, color: btnColor),
            onPressed: onPressed,
            tooltip: label,
          ),
        ).animate(onPlay: (controller) {
          controller.repeat(reverse: true);
        }).scaleXY(begin: 1.0, end: 1.05, duration: const Duration(milliseconds: 600)),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: btnColor,
              ),
        ),
      ],
    );
  }
}

/// Widget de valor con descripción reutilizable.
///
/// Muestra un valor grande con una descripción pequeña debajo.
///
/// Ejemplo:
/// ```dart
/// ValueDisplay(
///   value: '42',
///   label: 'Horas',
///   icon: Icons.schedule,
/// )
/// ```
class ValueDisplay extends StatelessWidget {
  /// Valor a mostrar (ej: "42", "3.14").
  final String value;

  /// Descripción del valor.
  final String label;

  /// Icono opcional.
  final IconData? icon;

  /// Color del valor. Defecto: tema primario.
  final Color? valueColor;

  const ValueDisplay({
    required this.value,
    required this.label,
    this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = valueColor ?? Theme.of(context).primaryColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
        ],
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
