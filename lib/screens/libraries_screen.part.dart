part of '../main.dart';

// Responsibility: External libraries integration and demonstration screens.

class _LibrariesScreen extends StatelessWidget {
  const _LibrariesScreen();

  static final List<_LibraryDoc> _docs = [
    _LibraryDoc(
      name: 'm3e_collection',
      description: 'Agregador principal de componentes M3E para acelerar integración UI.',
      icon: Icons.apps,
      tint: const Color(0xFF6750A4),
      highlights: ['ButtonM3E', 'FabM3E', 'NavigationBarM3E', 'ToolbarM3E'],
      sections: [
        _LibraryGuideSection(
          title: 'Integración base',
          bullets: [
            'Importa el paquete en la capa UI donde montas componentes expresivos.',
            'Centraliza tokens visuales en tu ThemeData y usa los widgets de colección para coherencia.',
            'Combina con flutter_animate para entradas y feedback de interacción.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'm3e_collection.button_pack',
          title: 'Pack de acciones primarias',
          description: 'Ejemplo de botón principal + FAB contextual para acciones rápidas.',
          fileName: 'lib/ui/actions_panel.dart',
          code: "import 'package:m3e_collection/m3e_collection.dart';\n\nWrap(\n  spacing: 12,\n  children: [\n    ButtonM3E(\n      label: Text('Guardar cambios'),\n      style: ButtonM3EStyle.filled,\n      onPressed: () {},\n    ),\n    FabM3E(\n      icon: Icon(Icons.add),\n      kind: FabM3EKind.primary,\n      onPressed: () {},\n    ),\n  ],\n);",
        ),
        _LibrarySample(
          id: 'm3e_collection.nav_pack',
          title: 'Navegación expresiva',
          description: 'Navegación inferior con estados seleccionados y animación implícita.',
          fileName: 'lib/ui/navigation_shell.dart',
          code: "NavigationBarM3E(\n  selectedIndex: 1,\n  onDestinationSelected: (i) {},\n  destinations: const [\n    NavigationDestinationM3E(icon: Icon(Icons.home_outlined), label: 'Inicio'),\n    NavigationDestinationM3E(icon: Icon(Icons.search_outlined), label: 'Buscar'),\n    NavigationDestinationM3E(icon: Icon(Icons.person_outline), label: 'Perfil'),\n  ],\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'm3e_buttons',
      description: 'Botonera avanzada para flujos de decisión, split actions y acciones agrupadas.',
      icon: Icons.smart_button,
      tint: const Color(0xFF006E6D),
      highlights: ['M3EButton', 'M3ESplitButton', 'M3EButton.icon'],
      sections: [
        _LibraryGuideSection(
          title: 'Cuándo usarlo',
          bullets: [
            'Usa split button cuando una acción principal tiene variantes.',
            'Usa variante tonal para acciones secundarias y outlined para bajo énfasis.',
            'Alinea tamaños de botones por densidad de pantalla (sm, md, lg).',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'm3e_buttons.split',
          title: 'Split action de edición',
          description: 'Acción principal con menú alterno para flujos editoriales.',
          fileName: 'lib/ui/editor_actions.dart',
          code: "m3eb.M3ESplitButton<String>(\n  label: 'Publicar',\n  onPressed: () {},\n  onSelected: (value) {},\n  items: const [\n    m3eb.M3ESplitButtonItem(value: 'draft', child: Text('Guardar borrador')),\n    m3eb.M3ESplitButtonItem(value: 'schedule', child: Text('Programar')),\n  ],\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'm3e_core',
      description: 'Patrones de interfaz compleja: columnas de cards, expandibles, dismissibles y selección.',
      icon: Icons.extension,
      tint: const Color(0xFF7B5800),
      highlights: ['M3ECardColumn', 'M3EExpandableCardColumn', 'M3EDropdownMenu'],
      sections: [
        _LibraryGuideSection(
          title: 'Patrón recomendado',
          bullets: [
            'M3ECardColumn para listas estáticas con estructura visual fuerte.',
            'M3EExpandableCardColumn para documentación progresiva o FAQ técnico.',
            'M3EDropdownMenu con búsqueda para catálogos medianos o largos.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'm3e_core.expand',
          title: 'Lista expandible de features',
          description: 'Despliegue progresivo de contenido técnico por secciones.',
          fileName: 'lib/ui/features_expand.dart',
          code: "m3ec.M3EExpandableCardColumn(\n  itemCount: 3,\n  headerBuilder: (c, i, expanded) => Text('Feature \${i + 1}'),\n  bodyBuilder: (c, i) => Text('Detalle funcional de la feature \${i + 1}'),\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'app_bar_m3e + expressive_refresh',
      description: 'Combinación para cabeceras dinámicas y refresh expresivo basado en gesto o trigger manual.',
      icon: Icons.refresh,
      tint: const Color(0xFF8A2846),
      highlights: ['AppBarM3E', 'ExpressiveRefreshIndicator.contained'],
      sections: [
        _LibraryGuideSection(
          title: 'Flujo productivo',
          bullets: [
            'Define una función onRefresh idempotente para evitar dobles ejecuciones.',
            'Combina pull-to-refresh con botón forzar refresh para demos y QA.',
            'Expón contador y timestamp de refresh para feedback visible.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'refresh.integration',
          title: 'Integración de refresh controlado',
          description: 'Ejemplo completo con indicador expresivo y acciones manuales.',
          fileName: 'lib/ui/refresh_lab.dart',
          code: "ExpressiveRefreshIndicator.contained(\n  onRefresh: _onRefresh,\n  child: ListView.builder(\n    itemCount: items.length,\n    itemBuilder: (context, index) => ListTile(title: Text('Item \$index')),\n  ),\n);\n\nButtonM3E(\n  label: Text('Forzar refresh'),\n  onPressed: _onRefresh,\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'progress_indicator_m3e + expressive_loading_indicator',
      description: 'Sistema de carga y progreso expresivo para estados de espera, progreso parcial y completitud.',
      icon: Icons.hourglass_top,
      tint: const Color(0xFF004A77),
      highlights: ['LinearProgressIndicatorM3E', 'ProgressWithLabelM3E', 'ExpressiveLoadingIndicator'],
      sections: [
        _LibraryGuideSection(
          title: 'Buenas prácticas',
          bullets: [
            'Usa ProgressWithLabelM3E para tareas con avance cuantificable.',
            'Usa loading expresivo sólo para espera indeterminada real.',
            'Evita mezclar múltiples indicadores sin jerarquía visual.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'progress.loading',
          title: 'Panel de progreso mixto',
          description: 'Combinación de indicadores lineales, circulares y carga morfológica.',
          fileName: 'lib/ui/progress_panel.dart',
          code: "Column(\n  children: [\n    LinearProgressIndicatorM3E(value: 0.62),\n    ProgressWithLabelM3E(value: 0.62),\n    SizedBox(width: 48, height: 48, child: eli.ExpressiveLoadingIndicator()),\n  ],\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'flutter_m3shapes_extended',
      description: 'Librería de formas expresivas para construir identidad visual no genérica en M3E.',
      icon: Icons.category,
      tint: const Color(0xFF944500),
      highlights: ['M3EContainer.gem', 'M3EContainer.flower', 'M3EContainer.softBurst'],
      sections: [
        _LibraryGuideSection(
          title: 'Estrategia visual',
          bullets: [
            'Define 1 o 2 formas protagonistas por pantalla para evitar ruido visual.',
            'Asocia forma a semántica: burst para alertas, gem para acciones premium.',
            'Usa contraste alto entre shape y foreground para accesibilidad.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'shapes.palette',
          title: 'Galería de formas',
          description: 'Mosaico con formas expresivas y colores de la paleta activa.',
          fileName: 'lib/ui/shapes_gallery.dart',
          code: "Wrap(\n  spacing: 12,\n  children: [\n    m3shapes.M3EContainer.gem(width: 90, height: 90, color: cs.primaryContainer),\n    m3shapes.M3EContainer.flower(width: 90, height: 90, color: cs.secondaryContainer),\n    m3shapes.M3EContainer.softBurst(width: 90, height: 90, color: cs.tertiaryContainer),\n  ],\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'flutter_animate + dynamic_color',
      description: 'Motion declarativo + color dinámico para interfaces que se adaptan al usuario y al contexto.',
      icon: Icons.palette,
      tint: const Color(0xFF3B5E0B),
      highlights: ['fadeIn/slide/scale', 'Animate.defaultDuration', 'DynamicColorBuilder'],
      sections: [
        _LibraryGuideSection(
          title: 'Integración de motion y color',
          bullets: [
            'Centraliza duración por defecto con Animate.defaultDuration.',
            'Anima entradas críticas; evita animar todo al mismo tiempo.',
            'Usa DynamicColorBuilder con fallback ColorScheme.fromSeed.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'animate.dynamic',
          title: 'Entrada animada con color dinámico',
          description: 'Componente animado utilizando el colorScheme activo del sistema.',
          fileName: 'lib/ui/motion_dynamic.dart',
          code: "Animate.defaultDuration = const Duration(milliseconds: 400);\n\nContainer(\n  padding: const EdgeInsets.all(12),\n  color: Theme.of(context).colorScheme.primaryContainer,\n  child: Text('Hola M3E'),\n).animate().fadeIn().slideY(begin: 0.2);",
        ),
      ],
    ),
  ];

  void _openDoc(BuildContext context, _LibraryDoc doc) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => _LibraryDocScreen(doc: doc)),
    );
  }

  Widget _packageCard(
    BuildContext context, {
    required _LibraryDoc doc,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: doc.tint.withValues(alpha: 0.18),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => _openDoc(context, doc),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  m3shapes.M3EContainer.pill(
                    width: 44,
                    height: 44,
                    color: doc.tint,
                    child: Icon(doc.icon, color: cs.onPrimary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(doc.name, style: Theme.of(context).textTheme.titleLarge)),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 6),
              Text(doc.description, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: doc.highlights.map((item) => Chip(label: Text(item))).toList(),
              ),
              const SizedBox(height: 10),
              ButtonM3E(
                label: const Text('Ver documentación avanzada'),
                style: ButtonM3EStyle.tonal,
                onPressed: () => _openDoc(context, doc),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'Librerias y Funcionalidades', actions: [_appBarBrandIcon()]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _HeroBlast(
            title: 'Librerias en uso',
            subtitle: 'Referencia rapida de paquetes y funcionalidades de esta demo.',
            icon: Icons.menu_book,
          ),
          const SizedBox(height: 16),
          Text('Stack de la mega galeria', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('Documentación técnica navegable por librería con integración real, snippets y preview visual.'),
          const SizedBox(height: 16),
          ..._docs.map((doc) => _packageCard(context, doc: doc)),
          const SizedBox(height: 16),
          const _CreditsSection(),
          const SizedBox(height: 16),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.45),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lineamientos de interfaz M3 Expressive', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('1. Jerarquía visual fuerte con tipografía clara y bloques protagonistas.'),
                  Text('2. Movimiento significativo: transición de entrada, feedback y estado.'),
                  Text('3. Personalización visible: tema, tipografía y paleta accesibles.'),
                  Text('4. Color como sistema: usa seed + superficies para cohesión.'),
                  Text('5. Componentes expresivos sin sacrificar legibilidad y accesibilidad.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreditsSection extends StatelessWidget {
  const _CreditsSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Future<void> openGithub() async {
      final uri = Uri.parse('https://github.com/icristian');
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cs.primaryContainer.withValues(alpha: 0.92),
            cs.tertiaryContainer.withValues(alpha: 0.9),
            cs.secondaryContainer.withValues(alpha: 0.86),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: cs.primary.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                m3shapes.M3EContainer.pill(
                  width: 42,
                  height: 42,
                  color: cs.primary,
                  child: Icon(Icons.workspace_premium_rounded, color: cs.onPrimary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Créditos',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Autor: Cristian Carreño León',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text('Profesor de Matemática y Computación', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('Mag. Comunicación educativa, Nvas. Tecnologías', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text('Dipl. Data Science', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: openGithub,
              icon: const Icon(Icons.open_in_new_rounded),
              label: const Text('https://github.com/icristian'),
              style: FilledButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 520.ms, curve: Curves.easeOutCubic)
        .slideY(begin: 0.08, end: 0, duration: 620.ms, curve: Curves.easeOutCubic);
  }
}

class _LibraryDocScreen extends StatelessWidget {
  const _LibraryDocScreen({required this.doc});

  final _LibraryDoc doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: doc.name, actions: [_appBarBrandIcon()]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HeroBlast(
            title: doc.name,
            subtitle: doc.description,
            icon: doc.icon,
          ),
          const SizedBox(height: 16),
          ...doc.sections.map(
            (section) => Card(
              color: doc.tint.withValues(alpha: 0.12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section.title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    ...section.bullets.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text('• $item'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Ejemplos de integración', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          ...doc.samples.map(
            (sample) => _CodeEditorPanel(
              sample: sample,
              preview: _LibrarySamplePreview(sampleId: sample.id),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeEditorPanel extends StatelessWidget {
  const _CodeEditorPanel({
    required this.sample,
    required this.preview,
  });

  final _LibrarySample sample;
  final Widget preview;

  @override
  Widget build(BuildContext context) {
    final lines = sample.code.split('\n');
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sample.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(sample.description),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF10151E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF232B38)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF171F2C),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFFFF5F56), shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFFFFBD2E), shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF27C93F), shape: BoxShape.circle)),
                        const SizedBox(width: 12),
                        Text(
                          sample.fileName,
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12,
                            color: const Color(0xFF9EA7B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(
                              lines.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.jetBrainsMono(
                                    fontSize: 12,
                                    color: const Color(0xFF6B778C),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SelectableText(
                            sample.code,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 12,
                              height: 1.4,
                              color: const Color(0xFFE4E8EF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text('Preview renderizado', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: preview,
            ),
          ],
        ),
      ),
    );
  }
}

class _LibrarySamplePreview extends StatelessWidget {
  const _LibrarySamplePreview({required this.sampleId});

  final String sampleId;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    switch (sampleId) {
      case 'm3e_collection.button_pack':
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ButtonM3E(label: const Text('Guardar cambios'), style: ButtonM3EStyle.filled, onPressed: () {}),
            FabM3E(icon: const Icon(Icons.add), kind: FabM3EKind.primary, onPressed: () {}),
          ],
        );
      case 'm3e_collection.nav_pack':
        return NavigationBarM3E(
          selectedIndex: 1,
          onDestinationSelected: (_) {},
          destinations: const [
            NavigationDestinationM3E(icon: Icon(Icons.home_outlined), label: 'Inicio'),
            NavigationDestinationM3E(icon: Icon(Icons.search_outlined), label: 'Buscar'),
            NavigationDestinationM3E(icon: Icon(Icons.person_outline), label: 'Perfil'),
          ],
        );
      case 'm3e_buttons.split':
        return m3eb.M3ESplitButton<String>(
          label: 'Publicar',
          onPressed: () {},
          onSelected: (_) {},
          items: const [
            m3eb.M3ESplitButtonItem(value: 'draft', child: Text('Guardar borrador')),
            m3eb.M3ESplitButtonItem(value: 'schedule', child: Text('Programar')),
          ],
        );
      case 'm3e_core.expand':
        return m3ec.M3EExpandableCardColumn(
          itemCount: 2,
          headerBuilder: (context, index, expanded) => Text('Feature ${index + 1}'),
          bodyBuilder: (context, index) => Text('Detalle técnico de la feature ${index + 1}'),
        );
      case 'refresh.integration':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonM3E(label: const Text('Forzar refresh'), style: ButtonM3EStyle.tonal, onPressed: () {}),
            const SizedBox(height: 8),
            const Text('Combina pull-to-refresh + trigger manual para QA y demos.'),
          ],
        );
      case 'progress.loading':
        return Row(
          children: const [
            Expanded(child: LinearProgressIndicatorM3E(value: 0.62)),
            SizedBox(width: 10),
            SizedBox(width: 44, height: 44, child: ProgressWithLabelM3E(value: 0.62)),
            SizedBox(width: 10),
            SizedBox(width: 34, height: 34, child: eli.ExpressiveLoadingIndicator()),
          ],
        );
      case 'shapes.palette':
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            m3shapes.M3EContainer.gem(width: 72, height: 72, color: cs.primaryContainer, child: Icon(Icons.diamond, color: cs.onPrimaryContainer)),
            m3shapes.M3EContainer.flower(width: 72, height: 72, color: cs.secondaryContainer, child: Icon(Icons.local_florist, color: cs.onSecondaryContainer)),
            m3shapes.M3EContainer.softBurst(width: 72, height: 72, color: cs.tertiaryContainer, child: Icon(Icons.brightness_high, color: cs.onTertiaryContainer)),
          ],
        );
      case 'animate.dynamic':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text('Hola M3E', style: TextStyle(color: cs.onPrimaryContainer))
              .animate()
              .fadeIn(duration: 450.ms)
              .slideY(begin: 0.2, end: 0),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _LibraryDoc {
  const _LibraryDoc({
    required this.name,
    required this.description,
    required this.icon,
    required this.tint,
    required this.highlights,
    required this.sections,
    required this.samples,
  });

  final String name;
  final String description;
  final IconData icon;
  final Color tint;
  final List<String> highlights;
  final List<_LibraryGuideSection> sections;
  final List<_LibrarySample> samples;
}

class _LibraryGuideSection {
  const _LibraryGuideSection({required this.title, required this.bullets});

  final String title;
  final List<String> bullets;
}

class _LibrarySample {
  const _LibrarySample({
    required this.id,
    required this.title,
    required this.description,
    required this.fileName,
    required this.code,
  });

  final String id;
  final String title;
  final String description;
  final String fileName;
  final String code;
}

