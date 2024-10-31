# shopping_provider

The important bits
lib/main.dart
Here the app sets up objects it needs to track state: a catalog and a shopping cart. It builds a MultiProvider to provide both objects at once to widgets further down the tree.

The CartModel instance is provided using a ChangeNotifierProxyProvider, which combines two types of functionality:

It will automatically subscribe to changes in CartModel (if you only want this functionality simply use ChangeNotifierProvider).
It takes the value of a previously provided object (in this case, CatalogModel, provided just above), and uses it to build the value of CartModel (if you only want this functionality, simply use ProxyProvider).
lib/models/*
This directory contains the model classes that are provided in main.dart. These classes represent the app state.

lib/screens/*
This directory contains widgets used to construct the two screens of the app: the catalog and the cart. These widgets have access to the current state of both the catalog and the cart via Provider.of.

Questions/issues
