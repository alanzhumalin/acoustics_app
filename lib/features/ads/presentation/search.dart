// import 'package:acousticsapp/features/ads/data/ad_model.dart';
// import 'package:acousticsapp/features/ads/data/category.dart';
// import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
// import 'package:acousticsapp/features/ads/presentation/category_detail.dart';
// import 'package:flutter/material.dart';

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Category> results = [];
//   String userType = '';

//   void _search(String query) {
//     setState(() {
//       userType = query;
//       results = query.isEmpty
//           ? []
//           : categories
//               .where((category) =>
//                   category.category.toLowerCase().contains(query.toLowerCase()))
//               .toList();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final containerColor = Theme.of(context).colorScheme.secondaryContainer;
//     return Scaffold(
//       appBar: AppBar(
//         forceMaterialTransparency: true,
//         title: TextField(
//           autocorrect: false,
//           onChanged: _search,
//           controller: _searchController,
//           decoration: const InputDecoration(
//             hintText: 'Поиск...',
//             border: InputBorder.none,
//           ),
//         ),
//       ),
//       body:
//     );
//   }
// }
