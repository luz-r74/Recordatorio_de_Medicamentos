import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, Object>> meds;

  const SearchScreen({super.key, required this.meds});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, Object>> filtered = [];

  @override
  void initState() {
    super.initState();
    filtered = List<Map<String, Object>>.from(widget.meds);
  }

  @override
  void didUpdateWidget(covariant SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.meds, widget.meds)) {
      setState(() {
        filtered = List<Map<String, Object>>.from(widget.meds);
      });
    }
  }

  void search(String value) {
    setState(() {
      filtered = widget.meds
          .where(
            (m) => m["nombre"].toString().toLowerCase().contains(
              value.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
        title: const Text('Buscar medicamentos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  colors: [accentColor, accentColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withAlpha(40),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.white, size: 28),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Encuentra tu medicamento',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${filtered.length} resultados disponibles',
                          style: TextStyle(
                            color: Colors.white.withAlpha(220),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              onChanged: search,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                labelText: 'Buscar por nombre',
                labelStyle: TextStyle(
                  color: theme.colorScheme.onSurface.withAlpha(220),
                ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: theme.brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : theme.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.medical_services,
                            size: 70,
                            color: accentColor,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No se encontró ningún medicamento',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Prueba con otro nombre o agrega un nuevo recordatorio.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final m = filtered[index];
                        final tomado = m['tomado'] == true;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 14,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            leading: CircleAvatar(
                              radius: 26,
                              backgroundColor: tomado
                                  ? Colors.green.shade50
                                  : accentColor.withAlpha(30),
                              child: Icon(
                                tomado ? Icons.check : Icons.medication,
                                color: tomado ? Colors.green : accentColor,
                              ),
                            ),
                            title: Text(
                              m['nombre'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6),
                                Text('Hora: ${m['hora']}'),
                                Text('Frecuencia: ${m['frecuencia']}'),
                              ],
                            ),
                            trailing: Chip(
                              label: Text(tomado ? 'Tomado' : 'Pendiente'),
                              backgroundColor: tomado
                                  ? Colors.green.shade100
                                  : Colors.orange.shade100,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
