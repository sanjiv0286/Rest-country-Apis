
import 'package:countries/Model/model.dart';
import 'package:countries/View/details.dart';
import 'package:countries/ViewModel/country_provider.dart';
import 'package:flutter/material.dart';

class CountrySearch extends SearchDelegate<String> {
  final CountryProvider countryProvider;

  CountrySearch({required this.countryProvider});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Country> searchResults =
        countryProvider.filterCountriesByName(query);
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final Country country = searchResults[index];
        return ListTile(
          title: Text(country.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountryDetailScreen(country: country),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Country> searchResults =
        countryProvider.filterCountriesByName(query);
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final Country country = searchResults[index];
        return ListTile(
          title: Text(country.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountryDetailScreen(country: country),
              ),
            );
          },
        );
      },
    );
  }
}
