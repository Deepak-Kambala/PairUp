// profile_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final List<String>? skills;

  const ProfileScreen({
    super.key,
    this.firstName,
    this.lastName,
    this.skills,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String hackathonPref = "Both";
  late List<String> skills;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final fullName = widget.firstName != null && widget.lastName != null
        ? '${widget.firstName} ${widget.lastName}'
        : "Deepak";

    _nameController = TextEditingController(text: fullName);
    _bioController = TextEditingController(); // <-- no default text

    skills = widget.skills ?? ["Flutter", "React", "Python", "Node.js", "Firebase"];
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url.startsWith("http") ? url : "https://$url");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _addSkillDialog() {
    final TextEditingController skillController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text("Add Skill", style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: skillController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Enter skill",
              hintStyle: TextStyle(color: Colors.white38),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.redAccent)),
            ),
            TextButton(
              onPressed: () {
                if (skillController.text.trim().isNotEmpty) {
                  setState(() {
                    skills.add(skillController.text.trim());
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Add", style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }

  void _toggleEdit() {
    if (isEditing) {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isEditing = !isEditing;
        });
      }
    } else {
      setState(() {
        isEditing = !isEditing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'),
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const AssetImage("assets/default_avatar.png") as ImageProvider,
                    backgroundColor: Colors.grey[800],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Name
              isEditing
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: "Enter your name",
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is mandatory";
                    }
                    return null;
                  },
                ),
              )
                  : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  _nameController.text.isEmpty
                      ? "Enter your name"
                      : _nameController.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 20),

              // Bio
              _sectionTitle("Bio"),
              isEditing
                  ? TextFormField(
                controller: _bioController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Write something that describes you",
                  hintStyle: TextStyle(color: Colors.white38),
                  border: OutlineInputBorder(),
                ),
              )
                  : Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _bioController.text.isEmpty
                      ? "Write something that describes you"
                      : _bioController.text,
                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ),
              const SizedBox(height: 20),

              // Skills
              _sectionTitle("Skills"),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...skills.map(
                        (skill) => InputChip(
                      label: Container(
                        constraints: const BoxConstraints(maxWidth: 150),
                        child: Text(
                          skill,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.redAccent),
                      ),
                      onDeleted: isEditing
                          ? () {
                        setState(() {
                          skills.remove(skill);
                        });
                      }
                          : null,
                    ),
                  ),
                  if (isEditing)
                    GestureDetector(
                      onTap: _addSkillDialog,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.redAccent),
                        ),
                        child: const Icon(Icons.add, color: Colors.redAccent),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // GitHub
              _sectionTitle("GitHub"),
              isEditing
                  ? _editTile(_githubController, Icons.link, "Enter GitHub URL")
                  : (_githubController.text.isNotEmpty
                  ? GestureDetector(
                onTap: () => _openLink(_githubController.text),
                child: _displayTile(
                    _githubController.text, Icons.link, "Enter GitHub URL"),
              )
                  : _displayTile("", Icons.link, "Enter GitHub URL")),
              const SizedBox(height: 20),

              // Education
              _sectionTitle("Education"),
              isEditing
                  ? Column(
                children: [
                  _editTile(_collegeController, Icons.school, "College"),
                  _editTile(_yearController, Icons.calendar_today, "Year"),
                  _editTile(_branchController, Icons.computer, "Branch"),
                  _editTile(_locationController, Icons.location_on, "Location"),
                ],
              )
                  : Column(
                children: [
                  _displayTile(
                      _collegeController.text, Icons.school, "College"),
                  _displayTile(
                      _yearController.text, Icons.calendar_today, "Year"),
                  _displayTile(
                      _branchController.text, Icons.computer, "Branch"),
                  _displayTile(
                      _locationController.text, Icons.location_on, "Location"),
                ],
              ),
              const SizedBox(height: 20),

              // Preferred Events
              _sectionTitle("Preferred Events"),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _prefButton("Online"),
                  _prefButton("Offline"),
                  _prefButton("Both"),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: _toggleEdit,
        child: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _editTile(
      TextEditingController controller, IconData icon, String placeholder) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withOpacity(0.3), width: 0.8),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.redAccent),
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _displayTile(String value, IconData icon, String placeholder) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withOpacity(0.3), width: 0.8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value.isEmpty ? placeholder : value,
              style: TextStyle(
                color: value.isEmpty ? Colors.white38 : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _prefButton(String text) {
    final bool selected = hackathonPref == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          hackathonPref = text;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.redAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.redAccent, width: 1.5),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
