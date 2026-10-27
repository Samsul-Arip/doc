import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/inventory/presentation/product_list_page.dart';
import 'features/inventory/presentation/product_detail_page.dart';
import 'features/inventory/presentation/product_form_page.dart';

GoRouter createRouter() => GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductListPage(),
      routes: [
        GoRoute(
          path: 'products/new',
          builder: (context, state) => const ProductFormPage(),
        ),
        GoRoute(
          path: 'products/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '');
            return id == null || id <= 0
                ? const InvalidRoute()
                : ProductDetailPage(id: id);
          },
          routes: [
            GoRoute(
              path: 'edit',
              builder: (context, state) {
                final id = int.tryParse(state.pathParameters['id'] ?? '');
                return id == null || id <= 0
                    ? const InvalidRoute()
                    : ProductFormPage(id: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const InvalidRoute(),
);

class InvalidRoute extends StatelessWidget {
  const InvalidRoute({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Halaman tidak ditemukan')),
    body: Center(
      child: FilledButton(
        onPressed: () => context.go('/'),
        child: const Text('Kembali ke inventaris'),
      ),
    ),
  );
}

class InventoryApp extends StatefulWidget {
  const InventoryApp({super.key});
  @override
  State<InventoryApp> createState() => _InventoryAppState();
}

class _InventoryAppState extends State<InventoryApp> {
  final router = createRouter();
  @override
  void dispose() {
    router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Inventaris Masterclass',
    debugShowCheckedModeBanner: false,
    routerConfig: router,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF126B56)),
      scaffoldBackgroundColor: const Color(0xFFF5F7F5),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}
