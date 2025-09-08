import 'package:flutter/material.dart';
import 'package:pairup/widget/main_wrapper.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _skillCtrl = TextEditingController();

  final List<String> _commonSkills = [
    "JavaScript", "Python", "React", "Node.js", "TypeScript",
    "Java", "C++", "Swift", "Kotlin", "Flutter", "Unity",
    "TensorFlow", "AWS", "Docker", "GraphQL", "MongoDB",
    "PostgreSQL", "UI/UX", "Design", "Marketing",
  ];

  final List<String> _selectedSkills = [];
  int _currentPage = 0;

  void _addSkill(String skill) {
    if (skill.isNotEmpty && !_selectedSkills.contains(skill)) {
      setState(() {
        _selectedSkills.insert(0, skill);
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() => _selectedSkills.remove(skill));
  }

  void _nextPage() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_currentPage < 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() => _currentPage++);
      } else {
        _finishSetup();
      }
    }
  }

  void _finishSetup() {
    if (_dobCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select your date of birth")),
      );
      return;
    }
    if (_selectedSkills.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least one skill")),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MainWrapper(
          startIndex: 4, // Profile tab
          firstName: _firstNameCtrl.text.trim(),
          lastName: _lastNameCtrl.text.trim(),
          skills: _selectedSkills,
        ),
      ),
    );
  }

  Widget _buildGradientBackground({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF3A5A), Color(0xFFFF7539)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Page 0: Name
            _buildGradientBackground(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    "What's your name?",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _firstNameCtrl,
                    style: const TextStyle(color: Colors.black),
                    decoration: _inputDecoration("First Name"),
                    validator: (v) =>
                    v == null || v.isEmpty ? "Enter first name" : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _lastNameCtrl,
                    style: const TextStyle(color: Colors.black),
                    decoration: _inputDecoration("Last Name"),
                    validator: (v) =>
                    v == null || v.isEmpty ? "Enter last name" : null,
                  ),
                  const Spacer(),
                  _nextButton("Next"),
                ],
              ),
            ),

            // Page 1: DOB
            _buildGradientBackground(
              child: Column(
                children: [
                  const Spacer(),
                  const Text(
                    "When's your birthday?",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _dobCtrl,
                    readOnly: true,
                    decoration: _inputDecoration("Date of Birth").copyWith(
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000, 1, 1),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        _dobCtrl.text =
                        "${picked.day}/${picked.month}/${picked.year}";
                      }
                    },
                    validator: (v) =>
                    v == null || v.isEmpty ? "Select your DOB" : null,
                  ),
                  const Spacer(),
                  _nextButton("Next"),
                ],
              ),
            ),

            // Page 2: Skills
            _buildGradientBackground(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Add your skills",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _skillCtrl,
                                    decoration: const InputDecoration(
                                      hintText: "Enter a new skill",
                                      border: InputBorder.none,
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle,
                                      color: Color(0xFFFF3A5A)),
                                  onPressed: () {
                                    _addSkill(_skillCtrl.text.trim());
                                    _skillCtrl.clear();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _selectedSkills.map((skill) {
                              return Chip(
                                label: Text(skill),
                                backgroundColor: Colors.green.shade400,
                                labelStyle:
                                const TextStyle(color: Colors.white),
                                deleteIcon: const Icon(Icons.close,
                                    size: 18, color: Colors.white),
                                onDeleted: () => _removeSkill(skill),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),

                          Text(
                            "Popular skills:",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 12,
                            children: _commonSkills.map((skill) {
                              final selected = _selectedSkills.contains(skill);
                              return GestureDetector(
                                onTap: () {
                                  selected
                                      ? _removeSkill(skill)
                                      : _addSkill(skill);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? Colors.grey.withOpacity(0.4)
                                        : Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    skill,
                                    style: TextStyle(
                                      color: selected
                                          ? Colors.black87
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _nextButton("Finish"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nextButton(String text) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _nextPage,
        style: ElevatedButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.white,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF3A5A),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black54),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }
}
