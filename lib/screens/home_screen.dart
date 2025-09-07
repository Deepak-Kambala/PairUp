import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> opportunities = [
    {
      "title": "AI-Powered Fitness App",
      "tag": "Mobile App",
      "description":
      "Looking for a frontend developer to help build an innovative fitness tracking app with AI recommendations.",
      "skills": ["React Native", "JavaScript", "UI/UX Design"],
      "teamSize": "4 people",
      "deadline": "Feb 15",
      "remote": true,
      "postedBy": "Sarah Chen"
    },
    {
      "title": "Blockchain Payment System",
      "tag": "Fintech",
      "description":
      "Backend engineer needed for scalable blockchain-based payment gateway.",
      "skills": ["Solidity", "Node.js", "AWS"],
      "teamSize": "6 people",
      "deadline": "Mar 10",
      "remote": false,
      "postedBy": "Arjun Mehta"
    },
  ];

  final CardSwiperController controller = CardSwiperController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // dark background
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'), // replace with your logo
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: CardSwiper(
          controller: controller,
          cardsCount: opportunities.length,
          cardBuilder: (context, index, percentX, percentY) {
            final opp = opportunities[index];
            return _buildOpportunityCard(opp);
          },
          onEnd: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No more opportunities to show!"),
                backgroundColor: Colors.deepPurple,
              ),
            );
          },
          allowedSwipeDirection: AllowedSwipeDirection.only(
            left: true,
            right: true,
          ),

          // 🔥 Tinder-like stacking
          numberOfCardsDisplayed: 2, // show current + next card
          scale: 0.9, // back card slightly smaller
          backCardOffset: const Offset(0, 40), // peek effect
          padding: EdgeInsets.zero,
          maxAngle: 15,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  /// Builds a single opportunity card
  Widget _buildOpportunityCard(Map<String, dynamic> opp) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          // Card background (dark but not full black)
          Container(
            color: const Color(0xFF1E1E1E),
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      opp["tag"],
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Title
                  Text(
                    opp["title"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Description
                  Text(
                    opp["description"],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Skills
                  const Text(
                    "Required Skills:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: List.generate(
                      opp["skills"].length,
                          (i) => Chip(
                        label: Text(opp["skills"][i]),
                        backgroundColor: Colors.redAccent.withOpacity(0.1),
                        labelStyle: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Team + Deadline + Remote
                  Row(
                    children: [
                      const Icon(Icons.group, size: 18, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        "Team size: ${opp["teamSize"]}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 18, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        "Deadline: ${opp["deadline"]}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 18, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        opp["remote"] ? "Remote" : "On-site",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Posted by ${opp["postedBy"]}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 100), // space for buttons
                ],
              ),
            ),
          ),

          // Gradient overlay at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Action buttons
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _circleButton(Icons.refresh, Colors.yellow, () {
                  controller.undo();
                }),
                _circleButton(Icons.close, Colors.red, () {
                  controller.swipe(CardSwiperDirection.left);
                }),
                _circleButton(Icons.star, Colors.blue, () {}),
                _circleButton(Icons.favorite, Colors.green, () {
                  controller.swipe(CardSwiperDirection.right);
                }),
                _circleButton(Icons.share_rounded, Colors.purple, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          border: Border.all(color: color, width: 2),
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}
