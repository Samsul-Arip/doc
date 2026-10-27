import 'package:flutter/material.dart';
import '../../../core/api_client.dart';

class FailureView extends StatelessWidget {
  const FailureView({super.key, required this.error, required this.onRetry});
  final Object error;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off_outlined, size: 48),
          const SizedBox(height: 16),
          Text(errorMessage(error), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: onRetry,
            child: const Text('Coba lagi'),
          ),
        ],
      ),
    ),
  );
}

String rupiah(double value) {
  final parts = value.toStringAsFixed(2).split('.');
  final whole = parts[0].replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return 'Rp $whole,${parts[1]}';
}

class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: child,
    ),
  );
}
