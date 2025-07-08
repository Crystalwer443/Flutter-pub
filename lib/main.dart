import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => StockModel()),
      ],
      child: const StockApp(),
    ),
  );
}

class StockApp extends StatelessWidget {
  const StockApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);

    return MaterialApp(
      title: 'Stock Tracker',
      debugShowCheckedModeBanner: false,
      themeMode: themeModel.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
      ),
      home: const NavigationScreen(),
    );
  }
}

class ThemeModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Stock {
  final String symbol;
  final String name;
  final double price;
  final double change;

  Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
  });
}

class StockModel extends ChangeNotifier {
  final List<Stock> _stocks = [
    Stock(symbol: 'AAPL', name: 'Apple Inc.', price: 192.32, change: 1.23),
    Stock(symbol: 'GOOGL', name: 'Alphabet Inc.', price: 2855.12, change: -12.45),
    Stock(symbol: 'AMZN', name: 'Amazon.com', price: 3450.55, change: 25.67),
    Stock(symbol: 'TSLA', name: 'Tesla Inc.', price: 880.45, change: -4.56),
    Stock(symbol: 'MSFT', name: 'Microsoft Corp.', price: 310.20, change: 3.14),
  ];

  List<Stock> get stocks => _stocks;
}

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    MarketScreen(),
    PortfolioScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Market'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Portfolio'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stocks = Provider.of<StockModel>(context).stocks;

    return Scaffold(
      appBar: AppBar(title: const Text('Market Overview')),
      body: ListView.separated(
        itemCount: stocks.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final stock = stocks[index];
          final color = stock.change >= 0 ? Colors.green : Colors.red;
          return ListTile(
            title: Text('${stock.symbol} - ${stock.name}'),
            subtitle: Text('\$${stock.price.toStringAsFixed(2)}'),
            trailing: Text(
              '${stock.change >= 0 ? '+' : ''}${stock.change.toStringAsFixed(2)}%',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Portfolio')),
      body: const Center(child: Text('Portfolio summary will appear here.')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final isDark = themeModel.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: SwitchListTile(
          title: const Text('Dark Mode'),
          value: isDark,
          onChanged: themeModel.toggleTheme,
        ),
      ),
    );
  }
}