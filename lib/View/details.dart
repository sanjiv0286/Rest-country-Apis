import 'package:countries/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CountryDetailScreen extends StatefulWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      // backgroundColor: const Color.fromARGB(255, 228, 227, 227),
      appBar: AppBar(
        title: Text(widget.country.name),
        // backgroundColor: Colors.white, // Customize app bar color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Add padding around the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,

                // width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    // color: Colors.black,
                    color: Get.isDarkMode ? Colors.white : Colors.black,

                    width: 2,
                  ),
                ),
                child: Center(
                  child: SvgPicture.network(
                    widget.country.flag,
                    placeholderBuilder: (context) =>
                        const CircularProgressIndicator(),
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  color: Get.isDarkMode ? Colors.black : Colors.white,

                  // color: Theme.of(context).textTheme.bodyLarge!.color,

                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _generateLoremText(30),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  color: Get.isDarkMode ? Colors.black : Colors.white,

                  // color: Theme.of(context).textTheme.bodyLarge!.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("Capital", widget.country.capital),
                    // _buildInfoRow("Population", country.population ),
                    _buildInfoRow("Population", widget.country.population.toString()),

                    _buildInfoRow("Continent", widget.country.continent),
                    _buildInfoRow("Subregion", widget.country.subregion),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  String _generateLoremText(int wordsCount) {
    String loremText =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
    List<String> words = loremText.split(" ");
    return words.take(wordsCount).join(" ");
  }
}
