import 'package:flutter/material.dart';

import 'search_screen.dart';
import 'stats_screen.dart';

class Inicio extends StatefulWidget {
  final VoidCallback cambiarModo;
  final VoidCallback logout;
  final bool modoOscuro;
  final VoidCallback aumentarTexto;
  final VoidCallback disminuirTexto;
  final double tamanoTexto;
  final String nombreUsuario;
  final List<Map<String, Object>> medicamentos;
  final Future<void> Function(String nombre, TimeOfDay hora, String frecuencia)
  agregarMedicamento;
  final Future<void> Function(int index) eliminarMedicamento;
  final Future<void> Function(int index) marcarTomado;

  const Inicio({
    super.key,
    required this.cambiarModo,
    required this.logout,
    required this.modoOscuro,
    required this.aumentarTexto,
    required this.disminuirTexto,
    required this.tamanoTexto,
    required this.nombreUsuario,
    required this.medicamentos,
    required this.agregarMedicamento,
    required this.eliminarMedicamento,
    required this.marcarTomado,
  });

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int get totalMedicamentos => widget.medicamentos.length;

  int get tomados =>
      widget.medicamentos.where((m) => m['tomado'] == true).length;

  int get pendientes =>
      widget.medicamentos.where((m) => m['tomado'] == false).length;

  double get porcentajeCompletado =>
      totalMedicamentos == 0 ? 0.0 : tomados / totalMedicamentos;

  Map<String, Object>? get siguienteMedicamento {
    final pendientesList = widget.medicamentos
        .where((m) => m['tomado'] == false)
        .toList(growable: false);
    return pendientesList.isEmpty ? null : pendientesList.first;
  }

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(46),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _medicamentoCard(Map<String, Object> medicamento, int index) {
    final tomado = medicamento['tomado'] as bool;
    final cardGradient = LinearGradient(
      colors: tomado
          ? [Colors.green.shade300, Colors.green.shade200]
          : [Colors.deepPurple.shade600, Colors.deepPurple.shade400],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: cardGradient,
        boxShadow: [
          BoxShadow(
            color: tomado
                ? Colors.green.shade200.withAlpha(84)
                : Colors.deepPurple.shade200.withAlpha(84),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: Icon(
            tomado ? Icons.check_circle : Icons.medication,
            color: tomado ? Colors.green : Colors.deepPurple,
            size: 28,
          ),
        ),
        title: Text(
          medicamento['nombre'].toString(),
          style: TextStyle(
            fontSize: widget.tamanoTexto,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hora: ${medicamento['hora']}',
                style: TextStyle(
                  color: Colors.white.withAlpha(230),
                  fontSize: widget.tamanoTexto - 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Frecuencia: ${medicamento['frecuencia']}',
                style: TextStyle(
                  color: Colors.white.withAlpha(230),
                  fontSize: widget.tamanoTexto - 2,
                ),
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
              ),
              onPressed: () async => await widget.marcarTomado(index),
              icon: Icon(
                tomado ? Icons.undo : Icons.check,
                color: Colors.white,
                size: 18,
              ),
              label: Text(
                tomado ? 'Pendiente' : 'Tomado',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 4),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
              ),
              onPressed: () async => await widget.eliminarMedicamento(index),
              icon: const Icon(Icons.delete, color: Colors.white, size: 18),
              label: const Text('Eliminar', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = widget.modoOscuro;
    final accentColor = isDark
        ? Colors.deepPurpleAccent
        : const Color(0xFF5E35B1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistente de Salud"),
        centerTitle: true,
        actions: [
          Tooltip(
            message: widget.modoOscuro
                ? 'Cambiar a modo claro'
                : 'Cambiar a modo oscuro',
            child: IconButton(
              onPressed: widget.cambiarModo,
              icon: Icon(
                widget.modoOscuro ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
          ),
          Tooltip(
            message: 'Buscar medicamentos',
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchScreen(meds: widget.medicamentos),
                  ),
                );
              },
            ),
          ),
          Tooltip(
            message: 'Ver estadísticas',
            child: IconButton(
              icon: const Icon(Icons.bar_chart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatsScreen(
                      total: widget.medicamentos.length,
                      tomados: widget.medicamentos
                          .where((m) => m["tomado"] == true)
                          .length,
                      pendientes: widget.medicamentos
                          .where((m) => m["tomado"] == false)
                          .length,
                    ),
                  ),
                );
              },
            ),
          ),
          Tooltip(
            message: 'Cerrar sesión',
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: widget.logout,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF4B27C2), const Color(0xFF1F1142)]
                      : [const Color(0xFF5E35B1), const Color(0xFF7C4DFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(46),
                        ),
                        child: const Icon(
                          Icons.health_and_safety,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Bienvenido de nuevo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Aquí están tus recordatorios activos.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Hola ${widget.nombreUsuario} 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.tamanoTexto + 6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tienes $totalMedicamentos medicamentos registrados.',
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: widget.tamanoTexto - 2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: LinearProgressIndicator(
                      value: porcentajeCompletado,
                      minHeight: 14,
                      backgroundColor: Colors.white24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(porcentajeCompletado * 100).round()}% completado',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        '$tomados tomados',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tamaño del texto',
                  style: TextStyle(
                    fontSize: widget.tamanoTexto - 2,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: isDark ? Colors.white : Colors.black87,
                      ),
                      onPressed: widget.disminuirTexto,
                      icon: const Icon(Icons.zoom_out, size: 18),
                      label: const Text('Menos'),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: isDark ? Colors.white : Colors.black87,
                      ),
                      onPressed: widget.aumentarTexto,
                      icon: const Icon(Icons.zoom_in, size: 18),
                      label: const Text('Más'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  icon: Icon(
                    widget.modoOscuro ? Icons.dark_mode : Icons.light_mode,
                  ),
                  label: const Text('Modo'),
                  onPressed: widget.cambiarModo,
                ),
                FilledButton.icon(
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchScreen(meds: widget.medicamentos),
                      ),
                    );
                  },
                ),
                FilledButton.icon(
                  icon: const Icon(Icons.bar_chart),
                  label: const Text('Estadísticas'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatsScreen(
                          total: widget.medicamentos.length,
                          tomados: widget.medicamentos
                              .where((m) => m["tomado"] == true)
                              .length,
                          pendientes: widget.medicamentos
                              .where((m) => m["tomado"] == false)
                              .length,
                        ),
                      ),
                    );
                  },
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text('Salir'),
                  onPressed: widget.logout,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _infoCard(
                    'Registrados',
                    '$totalMedicamentos',
                    Icons.medication,
                    accentColor,
                  ),
                  const SizedBox(width: 14),
                  _infoCard(
                    'Pendientes',
                    '$pendientes',
                    Icons.access_time,
                    Colors.orange,
                  ),
                  const SizedBox(width: 14),
                  _infoCard(
                    'Tomados',
                    '$tomados',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tus medicamentos',
                  style: TextStyle(
                    fontSize: widget.tamanoTexto + 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchScreen(meds: widget.medicamentos),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white12 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Buscar',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (widget.medicamentos.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 18,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.medical_services, size: 80, color: accentColor),
                    const SizedBox(height: 20),
                    Text(
                      'Aún no tienes medicamentos',
                      style: TextStyle(
                        fontSize: widget.tamanoTexto,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Agrega un recordatorio para comenzar a recibir alertas y cuidar tu rutina diaria.',
                      style: TextStyle(
                        color: isDark
                            ? Colors.grey.shade300
                            : Colors.grey.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.medicamentos.length,
                itemBuilder: (context, index) {
                  return _medicamentoCard(widget.medicamentos[index], index);
                },
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: accentColor,
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
        onPressed: _mostrarDialogoAgregarMedicamento,
      ),
    );
  }

  void _mostrarDialogoAgregarMedicamento() {
    final accentColor = widget.modoOscuro
        ? Colors.deepPurpleAccent
        : const Color(0xFF5E35B1);
    final formKey = GlobalKey<FormState>();
    final TextEditingController nombreController = TextEditingController();
    TimeOfDay? horaSeleccionada;
    String frecuenciaSeleccionada = 'Diaria';
    bool mostrarErrorHora = false;

    showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: const Text('Nuevo Medicamento 💊'),
              scrollable: true,
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nombreController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Escribe el nombre del medicamento';
                          }
                          return null;
                        },
                        cursorColor: widget.modoOscuro
                            ? Colors.white
                            : Colors.black87,
                        style: TextStyle(
                          color: widget.modoOscuro
                              ? Colors.white
                              : Colors.black87,
                          fontSize: widget.tamanoTexto,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 14,
                          ),
                          labelText: 'Nombre del medicamento',
                          labelStyle: TextStyle(
                            color: widget.modoOscuro
                                ? Colors.white70
                                : Colors.black54,
                            fontSize: widget.tamanoTexto - 2,
                          ),
                          filled: true,
                          fillColor: widget.modoOscuro
                              ? Colors.grey.shade900
                              : Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      FilledButton.icon(
                        icon: const Icon(Icons.access_time),
                        label: Text(
                          horaSeleccionada == null
                              ? 'Elegir hora'
                              : 'Hora: ${horaSeleccionada!.format(context)}',
                          style: TextStyle(fontSize: widget.tamanoTexto - 2),
                        ),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: widget.modoOscuro
                              ? Colors.white12
                              : Colors.grey.shade300,
                          foregroundColor: accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () async {
                          final nuevaHora = await showTimePicker(
                            context: dialogContext,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: widget.modoOscuro
                                      ? const ColorScheme.dark(
                                          primary: Colors.deepPurpleAccent,
                                          onSurface: Colors.white,
                                        )
                                      : Theme.of(context).colorScheme,
                                  timePickerTheme: TimePickerThemeData(
                                    dialHandColor: accentColor,
                                    hourMinuteTextColor: accentColor,
                                    dayPeriodTextColor: accentColor,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (nuevaHora != null) {
                            setStateDialog(() {
                              horaSeleccionada = nuevaHora;
                              mostrarErrorHora = false;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Para guardar, completa el nombre y selecciona una hora.',
                        style: TextStyle(
                          color: widget.modoOscuro
                              ? Colors.white70
                              : Colors.black54,
                          fontSize: widget.tamanoTexto - 4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: frecuenciaSeleccionada,
                        decoration: InputDecoration(
                          labelText: 'Frecuencia',
                          labelStyle: TextStyle(
                            color: widget.modoOscuro
                                ? Colors.white70
                                : Colors.black54,
                            fontSize: widget.tamanoTexto - 2,
                          ),
                          filled: true,
                          fillColor: widget.modoOscuro
                              ? Colors.grey.shade900
                              : Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Diaria',
                            child: Text('Diaria'),
                          ),
                          DropdownMenuItem(
                            value: 'Cada 8h',
                            child: Text('Cada 8h'),
                          ),
                          DropdownMenuItem(
                            value: 'Cada 12h',
                            child: Text('Cada 12h'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setStateDialog(() {
                              frecuenciaSeleccionada = value;
                            });
                          }
                        },
                      ),
                      if (mostrarErrorHora)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Selecciona una hora antes de guardar',
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final nombreValido =
                        formKey.currentState?.validate() ?? false;
                    final horaValida = horaSeleccionada != null;

                    if (!nombreValido || !horaValida) {
                      setStateDialog(() {
                        mostrarErrorHora = !horaValida;
                      });
                      return;
                    }

                    final nombre = nombreController.text.trim();
                    debugPrint(
                      'Botón Guardar pulsado: nombre=$nombre hora=${horaSeleccionada!.format(context)} frecuencia=$frecuenciaSeleccionada',
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Guardando medicamento...'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                    await widget.agregarMedicamento(
                      nombre,
                      horaSeleccionada!,
                      frecuenciaSeleccionada,
                    );
                    Navigator.of(dialogContext).pop(true);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    ).then((guardado) {
      if (guardado == true) {
        setState(() {});
      }
    });
  }
}
