# DishDash

DishDash is a Flutter application designed to help users find and explore a variety of recipes. Whether you're looking for a quick snack or planning a gourmet meal, DishDash has you covered with an extensive collection of recipes.

## Features

- **Recipe Search**: Easily search for recipes using the search bar with a user-friendly interface.
- **Recipe Details**: View detailed information about each recipe, including ingredients, steps, and nutritional information.
- **Category Browsing**: Explore recipes by categories such as Chilli Food, Desserts, Diet Food, Sea Food, and Pizza.
- **Favorites**: Mark your favorite recipes for quick access later.
- **Dynamic UI**: Enjoy a visually appealing interface with a dark gray/charcoal background and vibrant yellow accents.

## Screenshots

![Home Screen](screenshots/home_screen.png)
![Recipe Details](screenshots/recipe_details.png)

## Getting Started

This project is a starting point for a Flutter application. To get started with Flutter development, follow the resources below:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

## Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/dishdash.git
    ```
2. **Navigate to the project directory**:
    ```bash
    cd dishdash
    ```
3. **Install dependencies**:
    ```bash
    flutter pub get
    ```
4. **Run the application**:
    ```bash
    flutter run
    ```

## Project Structure

```plaintext
lib/
├── RecipeView.dart        # Widget to display detailed recipe information
├── main.dart              # Main entry point of the application
├── search.dart            # Search functionality implementation
└── home.dart              # Home screen of the application
