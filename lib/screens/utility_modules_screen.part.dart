part of '../main.dart';

// Responsibility: Utility modules and helper classes/enums.

class _UtilityModuleScreen extends StatelessWidget {
  const _UtilityModuleScreen({required this.module});

  final _UtilityModule module;

  @override
  Widget build(BuildContext context) {
    final Widget content = switch (module.kind) {
      _ModuleKind.routines => const _RoutinesModulePanel(),
      _ModuleKind.focus => const _FocusModulePanel(),
      _ModuleKind.finance => const _FinanceModulePanel(),
      _ModuleKind.health => const _HealthModulePanel(),
      _ModuleKind.agenda => const _AgendaModulePanel(),
      _ModuleKind.automation => const _AutomationModulePanel(),
    };

    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: module.title, actions: [_appBarBrandIcon()]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HeroBlast(
            title: module.title,
            subtitle: module.subtitle,
            icon: module.icon,
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}

class _RoutinesModulePanel extends StatefulWidget {
  const _RoutinesModulePanel();

  @override
  State<_RoutinesModulePanel> createState() => _RoutinesModulePanelState();
}

class _RoutinesModulePanelState extends State<_RoutinesModulePanel> {
  final Set<int> _done = {1};
  final List<String> _habits = const ['Leer 20 min', 'Estirar 10 min', 'Planificar top 3', 'Inbox cero'];

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(PrefKeys.routinesDone);
    if (raw == null || !mounted) {
      return;
    }
    setState(() {
      _done
        ..clear()
        ..addAll(raw.map(int.tryParse).whereType<int>());
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(PrefKeys.routinesDone, _done.map((e) => '$e').toList());
  }

  @override
  Widget build(BuildContext context) {
    final completed = _done.length / _habits.length;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Streak semanal', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            LinearProgressIndicatorM3E(value: completed),
            const SizedBox(height: 10),
            Text('${_done.length}/${_habits.length} hábitos completados', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            ...List.generate(_habits.length, (index) {
              final done = _done.contains(index);
              return CheckboxListTile(
                value: done,
                onChanged: (_) {
                  setState(() {
                    if (done) {
                      _done.remove(index);
                    } else {
                      _done.add(index);
                    }
                  });
                  _saveState();
                },
                title: Text(_habits[index]),
                controlAffinity: ListTileControlAffinity.leading,
              );
            }),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _FocusModulePanel extends StatefulWidget {
  const _FocusModulePanel();

  @override
  State<_FocusModulePanel> createState() => _FocusModulePanelState();
}

class _FocusModulePanelState extends State<_FocusModulePanel> {
  static const List<int> _presetMinutes = [5, 10, 15, 25, 45, 60];
  int _durationMinutes = 25;
  List<int> _favoriteMinutes = [15, 25, 45];
  Timer? _timer;
  int _remaining = 25 * 60;

  int get _totalSeconds => _durationMinutes * 60;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final duration = prefs.getInt(PrefKeys.focusDuration);
    final saved = prefs.getInt(PrefKeys.focusRemaining);
    final rawFavorites = prefs.getStringList(PrefKeys.focusFavorites);
    if (!mounted) {
      return;
    }
    setState(() {
      if (duration != null) {
        _durationMinutes = duration.clamp(5, 60);
      }
      if (rawFavorites != null && rawFavorites.isNotEmpty) {
        final ordered = <int>[];
        for (final value in rawFavorites.map(int.tryParse).whereType<int>()) {
          if (value >= 5 && value <= 60 && !ordered.contains(value)) {
            ordered.add(value);
          }
        }
        if (ordered.isNotEmpty) {
          _favoriteMinutes = ordered;
        }
      }
      if (saved != null) {
        _remaining = saved.clamp(0, _totalSeconds);
      } else {
        _remaining = _totalSeconds;
      }
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefKeys.focusDuration, _durationMinutes);
    await prefs.setInt(PrefKeys.focusRemaining, _remaining);
    await prefs.setStringList(PrefKeys.focusFavorites, _favoriteMinutes.map((m) => '$m').toList());
  }

  void _setDurationMinutes(int minutes) {
    final normalized = minutes.clamp(5, 60);
    _timer?.cancel();
    _timer = null;
    setState(() {
      _durationMinutes = normalized;
      _remaining = _totalSeconds;
    });
    _saveState();
  }

  void _addCurrentToFavorites() {
    if (_favoriteMinutes.contains(_durationMinutes)) {
      return;
    }
    setState(() {
      _favoriteMinutes = [..._favoriteMinutes, _durationMinutes];
      if (_favoriteMinutes.length > 4) {
        _favoriteMinutes = _favoriteMinutes.sublist(1);
      }
    });
    _saveState();
  }

  void _removeFavorite(int minutes) {
    setState(() {
      _favoriteMinutes.remove(minutes);
      if (_favoriteMinutes.isEmpty) {
        _favoriteMinutes = [15, 25, 45];
      }
    });
    _saveState();
  }

  void _reorderFavorites(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _favoriteMinutes.removeAt(oldIndex);
      _favoriteMinutes.insert(newIndex, item);
    });
    _saveState();
  }

  bool get _running => _timer != null;

  void _toggleTimer() {
    if (_running) {
      _timer?.cancel();
      _timer = null;
      setState(() {});
      _saveState();
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remaining <= 0) {
        timer.cancel();
        _timer = null;
        setState(() {});
        _saveState();
        return;
      }
      setState(() => _remaining -= 1);
      _saveState();
    });
    setState(() {});
  }

  void _reset() {
    _timer?.cancel();
    _timer = null;
    setState(() => _remaining = _totalSeconds);
    _saveState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _saveState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = 1 - (_remaining / _totalSeconds);
    final minutes = (_remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remaining % 60).toString().padLeft(2, '0');
    final selectedPreset = _presetMinutes.contains(_durationMinutes)
        ? _presetMinutes.indexOf(_durationMinutes)
        : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Focus Timer', style: Theme.of(context).textTheme.titleLarge),
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: ProgressWithLabelM3E(value: progress),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('$minutes:$seconds', style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 10),
            LinearProgressIndicatorM3E(value: progress),
            const SizedBox(height: 14),
            Text('Duración acotada: $_durationMinutes min', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            ButtonGroupM3E(
              selection: true,
              selectedIndex: selectedPreset,
              actions: _presetMinutes
                  .map(
                    (m) => ButtonGroupM3EAction(
                      label: Text('${m}m'),
                      onPressed: () => _setDurationMinutes(m),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ReorderableListView.builder(
                      scrollDirection: Axis.horizontal,
                      buildDefaultDragHandles: false,
                      itemCount: _favoriteMinutes.length,
                      onReorder: _reorderFavorites,
                      itemBuilder: (context, index) {
                        final m = _favoriteMinutes[index];
                        return Padding(
                          key: ValueKey('fav-$m'),
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InputChip(
                                label: Text('Fav ${m}m'),
                                selected: _durationMinutes == m,
                                onSelected: (_) => _setDurationMinutes(m),
                                onDeleted: _favoriteMinutes.length > 1 ? () => _removeFavorite(m) : null,
                              ),
                              ReorderableDragStartListener(
                                index: index,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Icon(Icons.drag_indicator, size: 18),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ButtonM3E(
                  label: const Text('Guardar'),
                  size: ButtonM3ESize.sm,
                  style: ButtonM3EStyle.outlined,
                  onPressed: _addCurrentToFavorites,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButtonM3E(
                  icon: const Icon(Icons.remove),
                  onPressed: _durationMinutes > 5 ? () => _setDurationMinutes(_durationMinutes - 5) : null,
                ),
                Expanded(
                  child: SliderM3E(
                    value: (_durationMinutes - 5) / 55,
                    onChanged: (v) {
                      final stepped = (5 + (v * 11).round() * 5).clamp(5, 60);
                      _setDurationMinutes(stepped);
                    },
                    showValueIndicator: true,
                    startIcon: const Icon(Icons.timer_rounded),
                    endIcon: const Icon(Icons.hourglass_bottom),
                  ),
                ),
                IconButtonM3E(
                  icon: const Icon(Icons.add),
                  onPressed: _durationMinutes < 60 ? () => _setDurationMinutes(_durationMinutes + 5) : null,
                  variant: IconButtonM3EVariant.filled,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              children: [
                ButtonM3E(
                  label: Text(_running ? 'Pausar' : 'Iniciar'),
                  style: ButtonM3EStyle.filled,
                  onPressed: _toggleTimer,
                ),
                ButtonM3E(
                  label: const Text('Reiniciar'),
                  style: ButtonM3EStyle.tonal,
                  onPressed: _reset,
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _FinanceModulePanel extends StatefulWidget {
  const _FinanceModulePanel();

  @override
  State<_FinanceModulePanel> createState() => _FinanceModulePanelState();
}

class _FinanceModulePanelState extends State<_FinanceModulePanel> {
  double _spent = 0.56;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getDouble(PrefKeys.financeSpent);
    if (saved == null || !mounted) {
      return;
    }
    setState(() => _spent = saved.clamp(0.0, 1.0));
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(PrefKeys.financeSpent, _spent);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final spentAmount = (2500 * _spent).round();
    final budgetAmount = 2500;

    return Card(
      color: cs.tertiaryContainer.withValues(alpha: 0.38),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Presupuesto mensual', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('\$$spentAmount / \$$budgetAmount'),
            const SizedBox(height: 10),
            LinearProgressIndicatorM3E(value: _spent),
            const SizedBox(height: 12),
            SliderM3E(
              value: _spent,
              onChanged: (v) {
                setState(() => _spent = v);
                _saveState();
              },
              showValueIndicator: true,
            ),
            const SizedBox(height: 10),
            m3ec.M3ECardColumn(
              children: const [
                ListTile(leading: Icon(Icons.fastfood), title: Text('Comida'), trailing: Text('\$580')),
                ListTile(leading: Icon(Icons.directions_car), title: Text('Transporte'), trailing: Text('\$290')),
                ListTile(leading: Icon(Icons.movie), title: Text('Ocio'), trailing: Text('\$180')),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _HealthModulePanel extends StatefulWidget {
  const _HealthModulePanel();

  @override
  State<_HealthModulePanel> createState() => _HealthModulePanelState();
}

class _HealthModulePanelState extends State<_HealthModulePanel> {
  int _waterGlasses = 3;
  double _stepsProgress = 0.42;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final water = prefs.getInt(PrefKeys.healthWater);
    final steps = prefs.getDouble(PrefKeys.healthSteps);
    if (!mounted) {
      return;
    }
    setState(() {
      if (water != null) {
        _waterGlasses = water.clamp(0, 8);
      }
      if (steps != null) {
        _stepsProgress = steps.clamp(0.0, 1.0);
      }
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefKeys.healthWater, _waterGlasses);
    await prefs.setDouble(PrefKeys.healthSteps, _stepsProgress);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bienestar diario', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text('Hidratación: $_waterGlasses / 8 vasos'),
                ),
                IconButtonM3E(
                  icon: const Icon(Icons.remove),
                  onPressed: _waterGlasses > 0
                      ? () {
                          setState(() => _waterGlasses -= 1);
                          _saveState();
                        }
                      : null,
                ),
                IconButtonM3E(
                  icon: const Icon(Icons.add),
                  onPressed: _waterGlasses < 8
                      ? () {
                          setState(() => _waterGlasses += 1);
                          _saveState();
                        }
                      : null,
                  variant: IconButtonM3EVariant.filled,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Pasos del día', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            LinearProgressIndicatorM3E(value: _stepsProgress),
            const SizedBox(height: 10),
            Slider(
              value: _stepsProgress,
              onChanged: (v) {
                setState(() => _stepsProgress = v);
                _saveState();
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _AgendaModulePanel extends StatefulWidget {
  const _AgendaModulePanel();

  @override
  State<_AgendaModulePanel> createState() => _AgendaModulePanelState();
}

class _AgendaModulePanelState extends State<_AgendaModulePanel> {
  final Set<int> _confirmed = {};
  final List<String> _events = const ['Daily sync - 10:00', 'Diseño UX - 11:30', 'Deep work - 15:00', 'Retro - 18:00'];

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(PrefKeys.agendaConfirmed);
    if (raw == null || !mounted) {
      return;
    }
    setState(() {
      _confirmed
        ..clear()
        ..addAll(raw.map(int.tryParse).whereType<int>());
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(PrefKeys.agendaConfirmed, _confirmed.map((e) => '$e').toList());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Agenda priorizada', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            ...List.generate(_events.length, (index) {
              final ok = _confirmed.contains(index);
              return ListTile(
                leading: Icon(ok ? Icons.event_available : Icons.event_busy),
                title: Text(_events[index]),
                trailing: ButtonM3E(
                  label: Text(ok ? 'Confirmado' : 'Confirmar'),
                  size: ButtonM3ESize.sm,
                  style: ok ? ButtonM3EStyle.tonal : ButtonM3EStyle.outlined,
                  onPressed: () {
                    setState(() => _confirmed.add(index));
                    _saveState();
                  },
                ),
              );
            }),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _AutomationModulePanel extends StatefulWidget {
  const _AutomationModulePanel();

  @override
  State<_AutomationModulePanel> createState() => _AutomationModulePanelState();
}

class _AutomationModulePanelState extends State<_AutomationModulePanel> {
  bool _nightRoutine = true;
  bool _meetingMode = false;
  bool _budgetAlert = true;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) {
      return;
    }
    setState(() {
      _nightRoutine = prefs.getBool(PrefKeys.autoNight) ?? _nightRoutine;
      _meetingMode = prefs.getBool(PrefKeys.autoMeeting) ?? _meetingMode;
      _budgetAlert = prefs.getBool(PrefKeys.autoBudget) ?? _budgetAlert;
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefKeys.autoNight, _nightRoutine);
    await prefs.setBool(PrefKeys.autoMeeting, _meetingMode);
    await prefs.setBool(PrefKeys.autoBudget, _budgetAlert);
  }

  @override
  Widget build(BuildContext context) {
    final active = [_nightRoutine, _meetingMode, _budgetAlert].where((item) => item).length;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reglas activas: $active / 3', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Rutina nocturna automática'),
              subtitle: const Text('Atenúa brillo y activa sonido ambiente'),
              value: _nightRoutine,
              onChanged: (v) {
                setState(() => _nightRoutine = v);
                _saveState();
              },
            ),
            SwitchListTile(
              title: const Text('Modo reuniones'),
              subtitle: const Text('Silencia notificaciones al iniciar calendario'),
              value: _meetingMode,
              onChanged: (v) {
                setState(() => _meetingMode = v);
                _saveState();
              },
            ),
            SwitchListTile(
              title: const Text('Alerta de presupuesto'),
              subtitle: const Text('Notifica al superar 80% del límite mensual'),
              value: _budgetAlert,
              onChanged: (v) {
                setState(() => _budgetAlert = v);
                _saveState();
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

enum _ModuleKind { routines, focus, finance, health, agenda, automation }

class _UtilityModule {
  const _UtilityModule(this.kind, this.title, this.subtitle, this.icon);

  final _ModuleKind kind;
  final String title;
  final String subtitle;
  final IconData icon;
}
