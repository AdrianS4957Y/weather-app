import 'package:flutter/material.dart';
import 'package:weathers/globals/fonts.dart';
import 'package:weathers/globals/gradients.dart';
import 'package:weathers/pages/search/cities_list.dart';
import 'package:weathers/pages/search/custom_search_bar.dart';

class Search extends StatefulWidget {
  const Search({
    super.key,
  });

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Search",
            style: Fonts.inter(
              fontSize: 11,
              color: const Color(0xFF313341),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 15 / 471,
              horizontal: MediaQuery.of(context).size.width * 15 / 218,
            ),
            child: Column(
              children: [
                CustomSearchBar(
                  onChange: (String text) {
                    setState(() {
                      searchText = text;
                    });
                  },
                ),
                CitiesList(
                  searchText: searchText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
