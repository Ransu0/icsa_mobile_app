import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:icsa_mobile_app/src/common/widgets/navigation_bar.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int _currentIndex = 0;

  // Stores index of the event whose "More Info" was pressed
  int? selectedEventIndex;

  // Search input
  TextEditingController searchController = TextEditingController();

  // Original list
  List<Map<String, String>> events = [
    {
      'title': 'Panagtagbo 2025',
      'date': 'April 29, 2025',
      'image': 'images/image_placeholder.png',
      'info': 'Panagtagbo 2025 is a grand celebration that unites communities across the region. '
          'The event showcases cultural performances, traditional rituals, and local arts. '
          'It aims to strengthen the spirit of togetherness among participants. '
          'Various activities will be held throughout the day highlighting unity and culture. '
          'Everyone is welcome to join and experience the vibrant festival atmosphere.',
    },
    {
      'title': 'Test Event 2025',
      'date': 'December 29, 2025',
      'image': 'images/image_placeholder.png',
      'info': 'The Test Event 2025 serves as an experimental showcase for new event formats. '
          'Participants will engage in interactive sessions and creative workshops. '
          'The goal is to explore new ideas and test community engagement methods. '
          'Fun challenges and mini-competitions will be available for attendees. '
          'The Test Event 2025 serves as an experimental showcase for new event formats. '
          'Participants will engage in interactive sessions and creative workshops. '
          'The goal is to explore new ideas and test community engagement methods. '
          'Fun challenges and mini-competitions will be available for attendees. '
          'This event encourages innovation, participation, and collaboration.',
    },
  ];

  // Filtered list (changes when searching)
  List<Map<String, String>> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    filteredEvents = List.from(events); // Start with full list
  }

  // Search function
  void filterSearch(String query) {
    query = query.toLowerCase();

    setState(() {
      filteredEvents = events.where((event) {
        return event['title']!.toLowerCase().contains(query);
      }).toList();

      // If the current selected event is not in filtered list, hide info
      if (selectedEventIndex != null &&
          !filteredEvents.contains(events[selectedEventIndex!])) {
        selectedEventIndex = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
      backgroundColor: const Color(0xFF1F2630),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP BAR (back + title + search)
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Events",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),

                  // SEARCH BAR
                  SizedBox(
                    width: 160,
                    child: TextField(
                      controller: searchController,
                      onChanged: filterSearch,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white24),
                        ),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  "Upcoming Events",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // If no event matches search
              if (filteredEvents.isEmpty)
                const Center(
                  child: Text(
                    "No events found.",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ),

              if (filteredEvents.isNotEmpty)
                CarouselSlider(
                  items: filteredEvents.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, String> event = entry.value;
                    return _buildEventCard(event, index);
                  }).toList(),
                  options: CarouselOptions(
                    height: 400,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),

              const SizedBox(height: 12),

              // Indicator dots
              if (filteredEvents.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    filteredEvents.length,
                    (index) => Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Colors.orange
                            : Colors.white24,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // INFO BOX (outside card)
              if (selectedEventIndex != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    filteredEvents[_currentIndex]['info']!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Card builder
  Widget _buildEventCard(Map<String, String> event, int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C3440),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    event['image']!,
                    width: 270,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  event['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  event['date']!,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (selectedEventIndex == index) {
                        // If same card is clicked again → hide
                        selectedEventIndex = null;
                      } else {
                        // Otherwise show the new card's info
                        selectedEventIndex = index;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C3440),
                    side: const BorderSide(color: Colors.white70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "More Info",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
