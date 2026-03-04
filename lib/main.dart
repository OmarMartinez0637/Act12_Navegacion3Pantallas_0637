import 'package:flutter/material.dart';
import 'package:myapp/mispantallas/inicio.dart';
import 'package:myapp/mispantallas/pantalla2.dart';
import 'package:myapp/mispantallas/pantalla3.dart';

void main() {
  runApp(const DairyQueenApp());
}

class DairyQueenApp extends StatelessWidget {
  const DairyQueenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HeladosScreen(),
        '/bebidas': (context) => const BebidasScreen(),
        '/pasteles': (context) => const PastelesScreen(),
      },
    );
  }
}

// --- CABECERA SUPERIOR ---
class HeaderSuperior extends StatelessWidget implements PreferredSizeWidget {
  final String routeName;
  const HeaderSuperior({super.key, required this.routeName});

  @override
  Size get preferredSize => const Size.fromHeight(110);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // --- ESTO CENTRA TU NOMBRE ---
          centerTitle: true, 
          leadingWidth: 120,
          leading: Row(
            children: [
              const SizedBox(width: 15),
              const Icon(Icons.menu, color: Colors.black),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text("DQ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          // --- AQUÍ VA TU NOMBRE ---
          title: const Text(
            "Omar Martínez 6I",
            style: TextStyle(
              color: Colors.black, 
              fontSize: 16, 
              fontWeight: FontWeight.bold
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.account_circle_outlined, color: Colors.black, size: 30),
            ),
          ],
        ),
        // Barra de navegación (Helados, Bebidas, Pasteles)
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navLink(context, "Helados", "/", routeName == "/"),
              _navLink(context, "Bebidas", "/bebidas", routeName == "/bebidas"),
              _navLink(context, "Pasteles", "/pasteles", routeName == "/pasteles"),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }

  Widget _navLink(BuildContext context, String text, String route, bool active) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, route),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
          color: active ? Colors.blue : Colors.black54,
        ),
      ),
    );
  }
}

// --- WIDGET DE ITEM (IMAGEN REAL + TEXTO) ---
class ItemMenu extends StatelessWidget {
  final String title;
  final String imageUrl; // Ruta de la imagen
  final bool isAsset;    // Para saber si la imagen es local o de internet

  const ItemMenu({
    super.key, 
    required this.title, 
    required this.imageUrl,
    this.isAsset = false, // Por defecto usamos links de internet
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 2),
            image: DecorationImage(
              fit: BoxFit.cover,
              // Aquí decidimos si cargar de internet o de assets
              image: isAsset 
                ? AssetImage(imageUrl) as ImageProvider
                : NetworkImage(imageUrl),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 120,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, height: 1.2, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}