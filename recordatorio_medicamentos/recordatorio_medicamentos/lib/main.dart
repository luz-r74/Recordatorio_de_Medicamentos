import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('medicamentos');
  await NotificationService.instance.init();

  runApp(const MiAplicacion());
}

class MiAplicacion extends StatefulWidget {
  const MiAplicacion({super.key});

  @override
  State<MiAplicacion> createState() => _MiAplicacionState();
}

class _MiAplicacionState extends State<MiAplicacion> {
  late final Box box;
  bool modoOscuro = false;
  double tamanoTexto = 18;
  String? usuarioActual;
  List<Map<String, Object>> medicamentos = [];

  @override
  void initState() {
    super.initState();
    box = Hive.box('medicamentos');
    usuarioActual = box.get('usuario') as String?;
    debugPrint('initState -> usuarioActual: $usuarioActual');
    if (usuarioActual != null) {
      cargarMedicamentos();
    }
  }

  void _guardarUsuario(String nombre) {
    debugPrint('_guardarUsuario -> nombre: $nombre');
    box.put('usuario', nombre);
    setState(() {
      usuarioActual = nombre;
    });
    cargarMedicamentos();
  }

  void _logout() {
    box.delete('usuario');
    setState(() {
      usuarioActual = null;
      medicamentos = [];
    });
  }

  void cargarMedicamentos() {
    debugPrint('cargarMedicamentos() -> Iniciando carga');
    final datos = box.get('lista', defaultValue: '[]');
    debugPrint('Datos obtenidos de Hive: $datos');

    try {
      final List<dynamic> decoded =
          jsonDecode(datos as String) as List<dynamic>;

      final nuevos = decoded
          .map(
            (e) =>
                Map<String, Object>.from(Map<String, dynamic>.from(e as Map)),
          )
          .toList();

      debugPrint('Medicamentos cargados: ${nuevos.length}');
      setState(() {
        medicamentos = nuevos;
      });

      for (final medicamento in medicamentos) {
        NotificationService.instance.scheduleMedicamento(medicamento);
      }
    } catch (e, stackTrace) {
      debugPrint('Error cargando medicamentos: $e');
      debugPrint('$stackTrace');
      setState(() {
        medicamentos = [];
      });
    }
  }

  Future<void> guardarDatos() async {
    debugPrint(
      'guardarDatos() -> guardando ${medicamentos.length} medicamentos',
    );
    try {
      final jsonString = jsonEncode(medicamentos);
      await box.put('lista', jsonString);
      debugPrint('guardarDatos() completado. Datos guardados: $jsonString');

      // Verificar que se guardó correctamente
      final verificacion = box.get('lista');
      debugPrint('Verificación de guardado: $verificacion');
    } catch (error, stackTrace) {
      debugPrint('Error guardando datos: $error');
      debugPrint('$stackTrace');
    }
  }

  Future<void> agregarMedicamento(
    String nombre,
    TimeOfDay hora,
    String frecuencia,
  ) async {
    final id = DateTime.now().millisecondsSinceEpoch.remainder(1000000);
    final horaFormateada =
        '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}';
    final nuevoMedicamento = {
      'id': id,
      'nombre': nombre,
      'hora': horaFormateada,
      'hour': hora.hour,
      'minute': hora.minute,
      'frecuencia': frecuencia,
      'tomado': false,
    };

    debugPrint(
      'agregarMedicamento() -> nombre=$nombre hora=$horaFormateada frecuencia=$frecuencia',
    );

    setState(() {
      medicamentos = List<Map<String, Object>>.from(medicamentos);
      medicamentos.add(nuevoMedicamento);
    });

    await guardarDatos();

    NotificationService.instance
        .scheduleDailyNotification(
          id: id,
          title: 'Hora de tomar $nombre',
          body: 'Recuerda tomar $nombre ahora.',
          hour: hora.hour,
          minute: hora.minute,
        )
        .catchError((error, stackTrace) {
          debugPrint('Error al programar notificación: $error');
        });
  }

  Future<void> eliminarMedicamento(int index) async {
    final medicamento = medicamentos[index];
    final id = medicamento['id'] as int?;
    if (id != null) {
      NotificationService.instance.cancel(id);
    }

    setState(() {
      medicamentos.removeAt(index);
    });

    await guardarDatos();
  }

  Future<void> marcarTomado(int index) async {
    setState(() {
      medicamentos[index]['tomado'] = !(medicamentos[index]['tomado'] as bool);
    });

    await guardarDatos();
  }

  @override
  Widget build(BuildContext context) {
    final seedColor = const Color(0xFF5E35B1);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: modoOscuro ? ThemeMode.dark : ThemeMode.light,
      themeAnimationDuration: const Duration(milliseconds: 350),
      themeAnimationCurve: Curves.easeOutCubic,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F4FF),
        cardColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1F1B2E),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      home: usuarioActual == null
          ? LoginScreen(onLogin: _guardarUsuario)
          : KeyedSubtree(
              key: ValueKey(medicamentos.length),
              child: Inicio(
                cambiarModo: () {
                  setState(() {
                    modoOscuro = !modoOscuro;
                  });
                },
                logout: _logout,
                modoOscuro: modoOscuro,
                aumentarTexto: () {
                  setState(() {
                    tamanoTexto += 2;
                  });
                },
                disminuirTexto: () {
                  setState(() {
                    if (tamanoTexto > 14) tamanoTexto -= 2;
                  });
                },
                tamanoTexto: tamanoTexto,
                nombreUsuario: usuarioActual ?? 'Usuario',
                medicamentos: medicamentos,
                agregarMedicamento: agregarMedicamento,
                eliminarMedicamento: eliminarMedicamento,
                marcarTomado: marcarTomado,
              ),
            ),
    );
  }
}
