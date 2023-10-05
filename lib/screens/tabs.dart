import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favorites = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    var isExisting = _favorites.contains(meal);

    if (isExisting) {
      setState(() {
        _favorites.remove(meal);
      });
      _showMessage('Meal removed from Favorites');
    } else {
      setState(() {
        _favorites.add(meal);
      });
      _showMessage('Meal added to Favorites');
    }
  }

  void _setScreen(String identifier) {
    if (identifier == 'meals') {
      Navigator.of(context).pop();
    } else if (identifier == 'filters') {}
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Pick your category';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favorites,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
