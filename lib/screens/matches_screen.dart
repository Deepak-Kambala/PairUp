
import 'package:flutter/material.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  final List<Map<String, dynamic>> matches = const [
    {
      "name": "Sarah Chen",
      "initials": "SC",
      "projectType": "Mobile App",
      "projectName": "AI-Powered Fitness App",
      "lastMessage": "Thanks for showing interest! Would you like to discuss the project details?",
      "daysAgo": 600,
      "unread": 2,
    },
    {
      "name": "Alex Rodriguez",
      "initials": "AR",
      "projectType": "Web Platform",
      "projectName": "Sustainable Fashion Marketplace",
      "lastMessage": "You: Looking forward to working together!",
      "daysAgo": 601,
      "unread": 0,
    },
    {
      "name": "Maya Patel",
      "initials": "MP",
      "projectType": "VR/AR",
      "projectName": "Educational VR Experience",
      "lastMessage": "New match",
      "daysAgo": 602,
      "unread": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              color: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        match["initials"],
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (match["unread"] > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.redAccent,
                          child: Text(
                            "${match["unread"]}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text(
                  match["name"],
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        match["projectType"],
                        style:
                        const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      match["projectName"],
                      style: const TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      match["lastMessage"],
                      style: const TextStyle(color: Colors.white54),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.chat_bubble_outline, color: Colors.white70),
                    Text("${match["daysAgo"]}d ago",
                        style: const TextStyle(color: Colors.white38)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
