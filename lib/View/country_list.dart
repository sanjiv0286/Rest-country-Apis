// *View: Represents the UI components.
// *********************************************

import 'package:countries/Model/model.dart';
import 'package:countries/View/country_search.dart';
import 'package:countries/View/details.dart';
import 'package:countries/ViewModel/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  CountryListScreenState createState() => CountryListScreenState();
}

class CountryListScreenState extends State<CountryListScreen> {
  late TextEditingController _searchController;
  var isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: Get.isDarkMode
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        title: const Text('Countries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: CountrySearch(
                      countryProvider: Provider.of<CountryProvider>(context,
                          listen: false)));
            },
          ),
          IconButton(
            onPressed: () {
              Get.changeTheme(
                Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
              );
              setState(() {
                // Toggle the isDarkMode variable
                isDarkMode = !isDarkMode;
              });
            },
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                // Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<CountryProvider>(
        builder: (context, countryProvider, child) {
          if (countryProvider.countries.isEmpty) {
            countryProvider.fetchCountries();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Group countries by continent
            Map<String, List<Country>> countriesByContinent = {};
            for (var country in countryProvider.countries) {
              if (!countriesByContinent.containsKey(country.continent)) {
                countriesByContinent[country.continent] = [];
              }
              countriesByContinent[country.continent]!.add(country);
            }

            return ListView.builder(
              itemCount: countriesByContinent.length,
              itemBuilder: (context, index) {
                String continent = countriesByContinent.keys.elementAt(index);
                List<Country> countries = countriesByContinent[continent]!;

                return ExpansionTile(
                  title: Text(continent),
                  children: countries.map((country) {
                    return ListTile(
                      leading: SvgPicture.network(
                        country.flag,
                        placeholderBuilder: (context) =>
                            const CircularProgressIndicator(),
                        height: 40,
                        width: 40,
                      ),
                      title: Text(country.name),
                      subtitle: Text(
                        'Capital: ${country.capital} - Population: ${country.population}',
                      ),
                      onTap: () {
                        // Navigate to detail view for the selected country
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CountryDetailScreen(country: country),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
