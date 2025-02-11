import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({super.key});

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
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

  List<String> results = [];
  String text = '';

  @override
  void dispose() {
    super.dispose();
    results = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(43.2452, 76.9345), // Almaty
              initialZoom: 9.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Column(
                children: [
                  TextField(
                    onChanged: showCities,
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      hintText: 'Поиск',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  if (results.isNotEmpty)
                    SizedBox(
                      height: 600,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                          color: Colors.black,
                          thickness: 1,
                        ),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 13),
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Text(
                              results[index],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
