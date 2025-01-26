import 'package:flutter/material.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arama'),
        centerTitle: true,
      ),
      body:  Column(
        children: [
           TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Ara',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          
        ],
      )
    );
  }
}