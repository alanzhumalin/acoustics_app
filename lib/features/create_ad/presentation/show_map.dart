import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({super.key});

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  Position? position;
  late MapController mapController;
  List<String> results = [];
  String text = '';
  LatLng currentCenter = LatLng(43.2452, 76.9345);
  double currentZoom = 13;

  List<String> cities = [
    "Актобе",
    "Алматы",
    "Астана",
    "Шымкент",
    "Караганда",
    "Атырау",
    "Усть-Каменогорск",
    "Павлодар",
    "Актау",
    "Кызылорда",
    "Тараз",
    "Костанай",
    "Петропавловск",
    "Темиртау",
    "Семей",
    "Уральск",
    "Экибастуз",
    "Жезказган",
    "Балхаш",
    "Кентау",
    "Рудный",
    "Талдыкорган",
    "Капшагай",
    "Сатпаев",
    "Туркестан",
    "Арыс",
    "Шу",
    "Байконур",
    "Каскелен",
    "Зыряновск",
    "Степногорск",
    "Щучинск"
  ];

  void zoomIn() {
    currentZoom = currentZoom + 0.5;
    mapController.move(currentCenter, currentZoom);
  }

  void zoomOut() {
    currentZoom = currentZoom - 0.5;
    mapController.move(currentCenter, currentZoom);
  }

  void showCities(String value) {
    setState(() {
      text = value;
      results = text.isEmpty
          ? []
          : cities
              .where(
                  (city) => city.toLowerCase().startsWith(text.toLowerCase()))
              .toList();
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var loc = await Geolocator.getCurrentPosition();

    setState(() {
      position = loc;
    });

    if (position != null) {
      currentCenter = LatLng(position!.latitude, position!.longitude);
      mapController.move(
          LatLng(position!.latitude, position!.longitude), currentZoom);
    }
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  void dispose() {
    results = [];
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme.surfaceContainer;

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: currentCenter,
              initialZoom: currentZoom,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.thunderforest.com/mobile-atlas/{z}/{x}/{y}.png?apikey=83c49e07601543538a8907806945e4ed',
              ),
              position == null
                  ? SizedBox.shrink()
                  : MarkerLayer(markers: [
                      Marker(
                          point: LatLng(
                              currentCenter.latitude, currentCenter.longitude),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ))
                    ])
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  TextField(
                    onChanged: showCities,
                    autofocus: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme,
                      prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      hintText: 'Поиск',
                      contentPadding: const EdgeInsets.all(0),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 2)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop('Мое местоположение');
                    },
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(color: theme),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Мое местоположение',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ),
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.blue,
                            ),
                          ],
                        )),
                  ),
                  if (results.isNotEmpty)
                    SizedBox(
                      height: size.height,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                          color: Colors.blue,
                          thickness: 1,
                        ),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pop(results[index]);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(color: theme),
                              child: Text(
                                results[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: size.height / 14,
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: theme, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: zoomIn,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  decoration:
                      BoxDecoration(color: theme, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: zoomOut,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration:
                      BoxDecoration(color: theme, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: _determinePosition,
                    icon: const Icon(
                      Icons.gps_fixed,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
