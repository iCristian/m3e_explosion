part of '../main.dart';

// Responsibility: Showcase screen displaying various UI components.

class _ShowcaseScreen extends StatefulWidget {
  const _ShowcaseScreen();

  @override
  State<_ShowcaseScreen> createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<_ShowcaseScreen> {
  /// ViewModel del reproductor obtenido del service locator.
  /// Se usa como Singleton compartido en toda la app.
  late VideoPlayerViewModel _videoVM;

  double _energy = 0.75;
  double _organic = 0.65;
  String _query = '';
  double _productivity = 0.68;
  bool _focusMode = true;
  bool _smartAlerts = true;
  final Set<int> _doneTasks = {0, 2};

  static const List<_UtilityModule> _modules = [
    _UtilityModule(_ModuleKind.routines, 'Rutinas', 'Hábitos, streaks y objetivos diarios', Icons.track_changes),
    _UtilityModule(_ModuleKind.focus, 'Focus', 'Bloqueo de distracciones y bloques deep work', Icons.center_focus_strong),
    _UtilityModule(_ModuleKind.finance, 'Finanzas', 'Seguimiento de gasto y alertas de presupuesto', Icons.pie_chart_outline),
    _UtilityModule(_ModuleKind.health, 'Salud', 'Hidratación, sueño y movimiento', Icons.favorite_outline),
    _UtilityModule(_ModuleKind.agenda, 'Agenda', 'Eventos, recordatorios y prioridades', Icons.event_note),
    _UtilityModule(_ModuleKind.automation, 'Automatización', 'Reglas inteligentes según contexto', Icons.auto_mode),
  ];

  void _openModule(_UtilityModule module) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _UtilityModuleScreen(module: module),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Obtener el ViewModel del service locator (es un Singleton)
    _videoVM = videoPlayerViewModel;
    // Escucha cambios del ViewModel para reconstruir la UI del reproductor.
    _videoVM.addListener(_onVideoVMChange);
  }

  void _onVideoVMChange() => setState(() {});

  @override
  void dispose() {
    _videoVM.removeListener(_onVideoVMChange);
    // NO llamar a dispose() del ViewModel aquí, ya que es un Singleton
    // que se comparte con otras pantallas. El dispose() se llamará
    // solo cuando la app se cierre (en setupServiceLocator cleanup).
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final isCompact = MediaQuery.sizeOf(context).width < 420;
    final query = _query.trim().toLowerCase();
    final filteredModules = query.isEmpty
      ? _modules
      : _modules
        .where((module) => '${module.title} ${module.subtitle}'.toLowerCase().contains(query))
        .toList();
    const tasks = ['Revisar métricas de energía', 'Enviar reporte del sprint', 'Sesión de focus 45 min', 'Actualizar presupuesto'];
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'Material 3 Expressive', actions: [_appBarBrandIcon()]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: isCompact ? 218 : 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primaryContainer, cs.tertiaryContainer, cs.secondaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 4,
                  right: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: SizedBox(
                      width: 132,
                      height: 132,
                      child: Image.asset('lib/assets/icono.png', fit: BoxFit.cover),
                    ),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scale(begin: const Offset(0.92, 0.92), end: const Offset(1.02, 1.02), duration: 1600.ms),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: m3shapes.M3EContainer.flower(
                    width: 62,
                    height: 62,
                    color: cs.secondary,
                    child: Icon(Icons.auto_awesome, color: cs.onSecondary),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true)).rotate(begin: -0.05, end: 0.07, duration: 1800.ms),
                ),
                Positioned(
                  top: isCompact ? 52 : 58,
                  left: 20,
                  right: isCompact ? 126 : 160,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: cs.surface.withValues(alpha: 0.34),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isCompact ? 'EXPLOSION M3E' : 'EXPLOSION\nM3E',
                        maxLines: isCompact ? 1 : 2,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: cs.onPrimaryContainer,
                          height: 0.95,
                          fontSize: isCompact ? 58 : null,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.12, end: 0),
                ),
                Positioned(
                  right: 18,
                  bottom: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: cs.surface.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('Material 3 Expressive', style: Theme.of(context).textTheme.labelLarge),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 450.ms).scale(begin: const Offset(0.92, 0.92), end: const Offset(1, 1)),
          const SizedBox(height: 8),
          Text(
            'Primera vista explosiva, motion continuo y controles de personalizacion para llevar M3E al limite.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Personalizacion Viva', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Text('Intensidad de energia', style: Theme.of(context).textTheme.labelLarge),
                  Slider(
                    value: _energy,
                    onChanged: (value) => setState(() => _energy = value),
                  ),
                  Text('Organicidad de forma', style: Theme.of(context).textTheme.labelLarge),
                  Slider(
                    value: _organic,
                    onChanged: (value) => setState(() => _organic = value),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      m3shapes.M3EContainer.puffy(
                        width: 72 + (_energy * 36),
                        height: 72 + (_energy * 36),
                        color: cs.primary.withValues(alpha: 0.25 + (_energy * 0.55)),
                        child: Icon(Icons.waves, color: cs.primary),
                      ),
                      m3shapes.M3EContainer.bun(
                        width: 72 + (_organic * 34),
                        height: 72 + (_organic * 34),
                        color: cs.tertiary.withValues(alpha: 0.2 + (_organic * 0.6)),
                        child: Icon(Icons.blur_on, color: cs.tertiary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 120.ms),
          const SizedBox(height: 16),
          Card(
            color: cs.tertiaryContainer.withValues(alpha: 0.45),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Color Burst', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Vista rápida de tonos activos del tema con animación de pulso.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _ColorPulseDot(color: cs.primary, label: 'Primary'),
                      _ColorPulseDot(color: cs.secondary, label: 'Secondary'),
                      _ColorPulseDot(color: cs.tertiary, label: 'Tertiary'),
                      _ColorPulseDot(color: cs.error, label: 'Error'),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 180.ms).slideY(begin: 0.06, end: 0),
          const SizedBox(height: 16),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            shadowColor: cs.primary.withValues(alpha: 0.28),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Banner gradient header ──────────────────────────────────
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [cs.primaryContainer, cs.tertiaryContainer],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      m3shapes.M3EContainer.gem(
                        width: 46,
                        height: 46,
                        color: cs.primary,
                        child: Icon(Icons.smart_display_rounded, color: cs.onPrimary, size: 26),
                      ).animate(onPlay: (c) => c.repeat(reverse: true))
                       .shimmer(duration: 2800.ms, color: cs.onPrimary.withValues(alpha: 0.15)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'M3E Media Stage',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: cs.onPrimaryContainer,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Material 3 Expressive · Vimeo',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: cs.onPrimaryContainer.withValues(alpha: 0.72),
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status badge animado
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                        child: Container(
                          key: ValueKey(_videoVM.playing),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: _videoVM.playing
                                ? cs.primary.withValues(alpha: 0.18)
                                : cs.outline.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _videoVM.playing ? cs.primary : cs.outline.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_videoVM.playing)
                                Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: cs.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ).animate(onPlay: (c) => c.repeat(reverse: true))
                                 .fadeIn(duration: 500.ms)
                              else
                                Icon(Icons.stop_circle_outlined, size: 8, color: cs.outline),
                              const SizedBox(width: 5),
                              Text(
                                _videoVM.playing ? 'PLAY' : 'M3E',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: _videoVM.playing ? cs.primary : cs.outline,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ── Zona de video / teaser ──────────────────────────────────
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: _videoVM.ready && _videoVM.controller != null
                        ? WebViewWidget(
                            key: const ValueKey('player'),
                            controller: _videoVM.controller!,
                          )
                        : GestureDetector(
                            key: const ValueKey('teaser'),
                            onTap: _videoVM.enable,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [cs.primaryContainer, cs.tertiaryContainer],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.ondemand_video_rounded,
                                      size: 88,
                                      color: cs.onPrimaryContainer.withValues(alpha: 0.35),
                                    ),
                                  ),
                                ),
                                // Gradiente inferior
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.72),
                                      ],
                                      stops: const [0.35, 1.0],
                                    ),
                                  ),
                                ),
                                // Botón play animado con M3E shape
                                Center(
                                  child: m3shapes.M3EContainer.softBurst(
                                    width: 76,
                                    height: 76,
                                    color: cs.primary.withValues(alpha: 0.93),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: cs.onPrimary,
                                      size: 42,
                                    ),
                                  ).animate(onPlay: (c) => c.repeat(reverse: true))
                                   .scaleXY(
                                     begin: 1.0,
                                     end: 1.12,
                                     duration: 1300.ms,
                                     curve: Curves.easeInOut,
                                   ),
                                ),
                                // Etiqueta inferior
                                Positioned(
                                  bottom: 14,
                                  left: 0,
                                  right: 0,
                                  child: Text(
                                    'Toca para cargar · Vimeo',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.85),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                // ── Controles M3E ───────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest.withValues(alpha: 0.55),
                  ),
                  child: Column(
                    children: [
                      // Botón principal — ancho completo con icono
                      SizedBox(
                        width: double.infinity,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          transitionBuilder: (child, anim) =>
                              FadeTransition(opacity: anim, child: ScaleTransition(scale: anim, child: child)),
                          child: ButtonM3E(
                            key: ValueKey(_videoVM.playing),
                            label: Text(_videoVM.playing ? '⏸  Pausar Vimeo' : '▶  Reproducir Vimeo'),
                            style: ButtonM3EStyle.filled,
                            onPressed: _videoVM.ready ? _videoVM.playPause : _videoVM.enable,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Fila de controles secundarios
                      Row(
                        children: [
                          Expanded(
                            child: ButtonM3E(
                              label: Text(_videoVM.muted ? '🔊  Sonido' : '🔇  Silenciar'),
                              style: ButtonM3EStyle.tonal,
                              onPressed: _videoVM.ready ? _videoVM.toggleMute : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ButtonM3E(
                              label: const Text('↺  Reiniciar'),
                              style: ButtonM3EStyle.outlined,
                              onPressed: _videoVM.ready ? _videoVM.restart : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Botón fullscreen con shape M3E
                          GestureDetector(
                            onTap: _videoVM.ready ? _videoVM.openFullscreen : null,
                            child: m3shapes.M3EContainer.gem(
                              width: 42,
                              height: 42,
                              color: _videoVM.ready ? cs.primary : cs.surfaceContainerHighest,
                              child: Icon(
                                Icons.fullscreen_rounded,
                                color: _videoVM.ready ? cs.onPrimary : cs.onSurface.withValues(alpha: 0.38),
                                size: 22,
                              ),
                            ).animate(target: _videoVM.ready ? 1 : 0)
                             .scaleXY(begin: 0.88, end: 1.0, curve: Curves.easeOut, duration: 300.ms),
                          ),
                        ],
                      ),
                      // Hint cuando no está cargado
                      if (!_videoVM.ready) ...[
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            m3shapes.M3EContainer.pill(
                              width: 20,
                              height: 20,
                              color: cs.secondaryContainer,
                              child: Icon(Icons.info_outline_rounded, size: 12, color: cs.onSecondaryContainer),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Si falla embebido, usa fullscreen para abrir Vimeo',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 220.ms).slideY(begin: 0.06, end: 0),
          const SizedBox(height: 24),
          SearchBar(
            hintText: 'Busca una funcionalidad...',
            onChanged: (value) => setState(() => _query = value),
            leading: const Icon(Icons.search),
            trailing: [
              if (query.isNotEmpty)
                IconButton(
                  onPressed: () => setState(() => _query = ''),
                  icon: const Icon(Icons.clear),
                )
              else
                IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
            ],
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
            ),
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 16),
          Card(
            color: cs.primaryContainer.withValues(alpha: 0.35),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Panel de Productividad', style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 62,
                        height: 62,
                        child: ProgressWithLabelM3E(value: _productivity),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicatorM3E(value: _productivity),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FilterChip(
                        label: const Text('Focus Mode'),
                        selected: _focusMode,
                        onSelected: (selected) => setState(() => _focusMode = selected),
                      ),
                      FilterChip(
                        label: const Text('Smart Alerts'),
                        selected: _smartAlerts,
                        onSelected: (selected) => setState(() => _smartAlerts = selected),
                      ),
                      ButtonM3E(
                        label: const Text('Boost +5%'),
                        style: ButtonM3EStyle.tonal,
                        onPressed: () => setState(() => _productivity = (_productivity + 0.05).clamp(0.0, 1.0)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 140.ms).slideY(begin: 0.06, end: 0),
          const SizedBox(height: 16),
          Text('Módulos activos', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          ...filteredModules.asMap().entries.map((entry) {
            final index = entry.key;
            final module = entry.value;
            final palette = [cs.primary, cs.secondary, cs.tertiary, cs.error];
            final tint = palette[index % palette.length];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                color: tint.withValues(alpha: 0.14),
                child: ListTile(
                  onTap: () => _openModule(module),
                  leading: m3shapes.M3EContainer.pill(
                    width: 44,
                    height: 44,
                    color: tint,
                    child: Icon(module.icon, color: cs.onPrimary),
                  ),
                  title: Text(module.title),
                  subtitle: Text(module.subtitle),
                  trailing: IconButtonM3E(
                    icon: const Icon(Icons.launch),
                    onPressed: () => _openModule(module),
                    variant: IconButtonM3EVariant.tonal,
                  ),
                ),
              ).animate().fadeIn(delay: Duration(milliseconds: 90 + (index * 60))).slideX(begin: 0.04, end: 0),
            );
          }),
          if (filteredModules.isEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'No se encontraron funcionalidades con "$query".',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: 12),
          Card(
            color: cs.secondaryContainer.withValues(alpha: 0.38),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Agenda inteligente de hoy', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  m3ec.M3ECardColumn(
                    children: List.generate(tasks.length, (index) {
                      final done = _doneTasks.contains(index);
                      return ListTile(
                        leading: Icon(done ? Icons.check_circle : Icons.radio_button_unchecked),
                        title: Text(
                          tasks[index],
                          style: TextStyle(
                            decoration: done ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        trailing: ButtonM3E(
                          label: Text(done ? 'Hecho' : 'Marcar'),
                          size: ButtonM3ESize.sm,
                          style: done ? ButtonM3EStyle.tonal : ButtonM3EStyle.outlined,
                          onPressed: () {
                            setState(() {
                              if (done) {
                                _doneTasks.remove(index);
                                _productivity = (_productivity - 0.04).clamp(0.0, 1.0);
                              } else {
                                _doneTasks.add(index);
                                _productivity = (_productivity + 0.04).clamp(0.0, 1.0);
                              }
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.08, end: 0),
          const SizedBox(height: 16),
          // ── GitHub Credits ──────────────────────────────────────────
          Card(
            color: cs.secondaryContainer.withValues(alpha: 0.45),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      m3shapes.M3EContainer.gem(
                        width: 42, height: 42, color: cs.secondary,
                        child: Icon(Icons.code_rounded, color: cs.onSecondary, size: 22)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(l10n.showcaseCredits,
                          style: Theme.of(context).textTheme.titleMedium),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(l10n.showcaseGithubTitle,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(l10n.showcaseGithubDesc,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
                  const SizedBox(height: 14),
                  ButtonM3E(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.open_in_new, size: 16),
                        const SizedBox(width: 6),
                        Text(l10n.showcaseGithubBtn),
                      ],
                    ),
                    style: ButtonM3EStyle.tonal,
                    onPressed: () async {
                      final uri = Uri.parse('https://github.com/iCristian/m3e_explosion');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 360.ms),
        ],
      ),
    );
  }
}

