import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<AdModel> results = [];
  String userType = '';

  void _search(String query) {
    setState(() {
      userType = query;
      results = query.isEmpty
          ? []
          : ads
              .where(
                  (ad) => ad.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: TextField(
          autocorrect: false,
          onChanged: _search,
          autofocus: true,
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Поиск...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: userType.isEmpty
          ? const Center(
              child: Text(
                'Начните вводить для поиска...',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : results.isEmpty
              ? const Center(
                  child: Text(
                    'Ничего не найдено',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.separated(
                  itemCount: results.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12);
                  },
                  itemBuilder: (context, index) {
                    final ad = results[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdDetail(ad: ad)));
                      },
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image(
                            width: 50,
                            height: 60,
                            image: NetworkImage(ad.adImages[0]),
                            fit: BoxFit.cover,
                          )),
                      title: Text(
                        ad.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${ad.price} тг.  ${ad.city}'),
                    );
                  },
                ),
    );
  }
}
