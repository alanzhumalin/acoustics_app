import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdAppbar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final bool isSearchSelected;
  final bool isCursorShown;
  final VoidCallback onBackPressed;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchTap;
  final Color containerColor;

  const AdAppbar({
    super.key,
    required this.searchController,
    required this.isSearchSelected,
    required this.isCursorShown,
    required this.onBackPressed,
    required this.onSearchChanged,
    required this.onSearchTap,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      titleSpacing: 10,
      centerTitle: false,
      forceMaterialTransparency: true,
      title: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              onTap: onSearchTap,
              showCursor: isCursorShown,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                prefixIcon: isSearchSelected
                    ? IconButton(
                        splashColor: Colors.transparent,
                        onPressed: onBackPressed,
                        icon: Icon(Icons.arrow_back_ios),
                      )
                    : null,
                filled: true,
                fillColor: containerColor,
                suffixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.blue,
                  size: 20,
                ),
                constraints: const BoxConstraints(maxHeight: 39),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                hintText: 'Поиск',
                hintStyle: const TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 132, 132, 132)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (!isSearchSelected)
            const Icon(
              Icons.notifications,
              color: Colors.orange,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
