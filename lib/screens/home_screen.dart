cardBuilder: (context, index, percentX, percentY) {
final user = users[index];
final screenHeight = MediaQuery.of(context).size.height;
final screenWidth = MediaQuery.of(context).size.width;

return SizedBox(
height: screenHeight - kToolbarHeight - kBottomNavigationBarHeight,
width: screenWidth,
child: Container(
margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
decoration: BoxDecoration(
borderRadius: const BorderRadius.only(
topLeft: Radius.circular(25),
topRight: Radius.circular(25),
), // only top corners rounded
boxShadow: [
BoxShadow(
color: Colors.black.withOpacity(0.3),
blurRadius: 15,
spreadRadius: 2,
offset: const Offset(0, 5),
),
],
),
child: ClipRRect(
borderRadius: const BorderRadius.only(
topLeft: Radius.circular(25),
topRight: Radius.circular(25),
),
child: Stack(
children: [
// Instead of image, add your card content widget here
Container(
color: Colors.white,
width: double.infinity,
height: double.infinity,
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Chip(
label: Text("Fintech"),
backgroundColor: Colors.green.shade100,
),
const SizedBox(height: 10),
const Text(
"Blockchain Payment System",
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
const Text(
"Backend engineer needed for scalable blockchain-based payment gateway.",
style: TextStyle(fontSize: 16, color: Colors.black87),
),
const SizedBox(height: 15),
Wrap(
spacing: 10,
children: const [
Chip(label: Text("Solidity")),
Chip(label: Text("Node.js")),
Chip(label: Text("AWS")),
],
),
const Spacer(),
Row(
children: const [
Icon(Icons.group, size: 20, color: Colors.grey),
SizedBox(width: 5),
Text("Team size: 6 people"),
],
),
const SizedBox(height: 5),
Row(
children: const [
Icon(Icons.calendar_today, size: 20, color: Colors.grey),
SizedBox(width: 5),
Text("Deadline: Mar 10"),
],
),
const SizedBox(height: 5),
Row(
children: const [
Icon(Icons.location_on, size: 20, color: Colors.grey),
SizedBox(width: 5),
Text("On-site"),
],
),
const SizedBox(height: 10),
const Text(
"Posted by Arjun Mehta",
style: TextStyle(color: Colors.grey, fontSize: 14),
),
],
),
),

// gradient at bottom
Container(
decoration: BoxDecoration(
gradient: LinearGradient(
begin: Alignment.bottomCenter,
end: Alignment.topCenter,
colors: [
Colors.black.withOpacity(0.1),
Colors.transparent,
],
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
)
],
),
),
),
);
},
