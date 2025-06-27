import 'package:flutter/material.dart';  // Flutter Material package for UI components

void main() {  // Entry point of the app
  runApp(const MyApp());  // Initializes the widget tree with MyApp
}

// Root app widget
class MyApp extends StatelessWidget {  // Root widget of the app, no internal state
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  // Configures the overall app theme and initial screen
      title: 'Repair Tracker',
      theme: ThemeData(  // Sets theme using color scheme seed and Material 3
        colorSchemeSeed: Colors.blueAccent,
        useMaterial3: true,
      ),
      home: const MainNavigation(),  // Sets the first screen of the app
    );
  }
}

// Main screen with bottom navigation
class MainNavigation extends StatefulWidget {  // Widget that manages bottom navigation state
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();  // Creates state object for MainNavigation
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;  // Tracks the currently selected tab

  late final List<Widget> _pages;

  @override
  void initState() {  // Initializes widget state when inserted into widget tree
    super.initState();  // Initializes widget state when inserted into widget tree
    _pages = [  // Defines the different pages/screens for navigation
      HomePage(
        onTrackPressed: () {
          setState(() {  // Triggers a UI update by modifying state
            _selectedIndex = 1;  // Tracks the currently selected tab
          });
        },
      ),
      const RepairTrackingPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Provides the basic visual layout structure (app bar, body, nav bar)
      appBar: AppBar(  // Top bar of the app with title
        title: const Text('Repair Tracker'),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],  // Displays the current screen based on selected index
      bottomNavigationBar: NavigationBar(  // The bottom navigation bar with icons/tabs
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {  // Triggers a UI update by modifying state
            _selectedIndex = index;  // Tracks the currently selected tab
          });
        },
        destinations: const [
          NavigationDestination(  // A single tab in the bottom nav bar
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(  // A single tab in the bottom nav bar
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Track',
          ),
        ],
      ),
    );
  }
}

// Home screen widget
class HomePage extends StatelessWidget {
  final void Function()? onTrackPressed;

  const HomePage({super.key, this.onTrackPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.deepPurple.shade50],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.build_rounded, size: 48, color: Colors.blueAccent),
            ),
            const SizedBox(height: 24),
            const Text(
              'Track Your Repair Easily',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Use your note number or phone number to check the status of your device anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('Track My Device'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              onPressed: onTrackPressed,
            ),
            const SizedBox(height: 40),
            const Divider(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contact Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📞 Phone: (915) 123-4567'),
                  Text('🕘 Hours: Mon–Fri, 9am–5pm'),
                  Text('📍 1193 Hollow Oak Ln, Crestview Hills, TX'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Repair tracking screen
class RepairTrackingPage extends StatefulWidget {
  const RepairTrackingPage({super.key});

  @override
  State<RepairTrackingPage> createState() => _RepairTrackingPageState();  // Creates state object for MainNavigation
}

class _RepairTrackingPageState extends State<RepairTrackingPage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _statusResult;

  static const List<String> steps = [
    'Received',
    'In Diagnosis',
    'In Repair',
    'Ready for Pickup',
  ];

  final Map<String, String> _noteRepairs = {
    '1001': 'In Diagnosis',
    '1002': 'In Repair',
    '1003': 'Ready for Pickup',
  };

  final Map<String, String> _phoneRepairs = {
    '9151234567': 'In Diagnosis',
    '9159876543': 'In Repair',
    '9155551212': 'Ready for Pickup',
  };

  void _checkStatus() {
    final note = _noteController.text.trim();
    final phone = _phoneController.text.trim();

    if (note.isNotEmpty) {
      final status = _noteRepairs[note];
      setState(() {  // Triggers a UI update by modifying state
        _statusResult = status ?? 'NOT_FOUND';
      });
    } else if (phone.isNotEmpty) {
      final status = _phoneRepairs[phone];
      setState(() {  // Triggers a UI update by modifying state
        _statusResult = status ?? 'NOT_FOUND';
      });
    } else {
      setState(() {  // Triggers a UI update by modifying state
        _statusResult = 'EMPTY';
      });
    }
  }

  List<Widget> _buildStatusSteps(String currentStatus) {
    final currentIndex = steps.indexOf(currentStatus);

    return List.generate(steps.length, (index) {
      final isActive = index <= currentIndex;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                isActive ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: isActive ? Colors.deepPurple : Colors.grey,
              ),
              if (index < steps.length - 1)
                Container(
                  width: 2,
                  height: 30,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                steps[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Check your repair status:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Note Number (optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number (optional)',
              hintText: 'e.g. 9151234567',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _checkStatus,
            child: const Text('Check Status'),
          ),
          const SizedBox(height: 20),
          if (_statusResult == 'EMPTY')
            const Text(
              'Please enter either a note number or phone number.',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            )
          else if (_statusResult == 'NOT_FOUND')
            const Text(
              'No repair found. Please check your input.',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            )
          else if (_statusResult != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Repair Progress:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ..._buildStatusSteps(_statusResult!),
              ],
            ),
        ],
      ),
    );
  }
}
