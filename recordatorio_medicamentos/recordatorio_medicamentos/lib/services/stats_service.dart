class StatsService {
  int total(List meds) => meds.length;

  int tomados(List meds) =>
      meds.where((m) => m["tomado"] == true).length;

  int pendientes(List meds) =>
      meds.where((m) => m["tomado"] == false).length;
}