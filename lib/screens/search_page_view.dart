import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatli_sozluk/screens/title_view_page.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot<Object?>> searchResults = []; // List of results
  FirestoreService firestore = FirestoreService();
  Future<void> searchData(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
   } // search function
      final results = await firestore.searchTitle(query);
      
      setState(() {
        searchResults = results.docs;
      });
  }
    @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
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
            onChanged: (query) {
              searchData(query);
            },
            decoration: const InputDecoration(
              
              hintText: 'Ara',
              prefixIcon: Icon(Iconsax.search_normal),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))
              )
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context,index){
                var item = searchResults[index];
                return ListTile(
                  title: Text(item['title'] ?? 'Başlık bulunamadı'),
                  onTap: (){
                    Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => TitleViewPage(),
                        settings: RouteSettings(
                          arguments: {
                            'docID': item.id,
                            'titleText': item['title'],
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
          )
        ],
      )
    );
  }
}