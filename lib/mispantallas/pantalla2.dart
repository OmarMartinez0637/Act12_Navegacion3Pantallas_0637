import 'package:flutter/material.dart';

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
// --- PANTALLA 2: BEBIDAS ---
class BebidasScreen extends StatelessWidget {
  const BebidasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderSuperior(routeName: "/bebidas"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("MALTEADAS", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ItemMenu(title: "Malteada Caramelo", imageUrl: "https://raw.githubusercontent.com/OmarMartinez0637/Imagenes-Para-DairyQueen/refs/heads/main/caramelo.JPG"),
                ItemMenu(title: "Malteada Cereza Negra", imageUrl: "https://raw.githubusercontent.com/OmarMartinez0637/Imagenes-Para-DairyQueen/refs/heads/main/cereza.JPG"),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ItemMenu(title: "Malteada Chocolate", imageUrl: "https://raw.githubusercontent.com/OmarMartinez0637/Imagenes-Para-DairyQueen/refs/heads/main/chocolateDQ.JPG"),
                ItemMenu(title: "Malteada Avellana", imageUrl: "https://raw.githubusercontent.com/OmarMartinez0637/Imagenes-Para-DairyQueen/refs/heads/main/Avellana.JPG"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}