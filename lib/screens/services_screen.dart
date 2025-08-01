import 'package:barbearia_rei_du_corte/models/service_model.dart';
import 'package:barbearia_rei_du_corte/screens/booking_screen.dart';
import 'package:barbearia_rei_du_corte/services/firestore_service.dart';
import 'package:barbearia_rei_du_corte/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    final currencyFormatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      body: StreamBuilder<List<ServiceModel>>(
        stream: firestoreService.getServices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar serviços: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum serviço encontrado.'));
          }

          final services = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(service: service),
                    ),
                  );
                },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Exibe a imagem do serviço
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Image.asset(
                          service.imageUrl,
                          fit: BoxFit.cover,
                          // Mostra um ícone de erro se a imagem não for encontrada
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported, size: 50, color: AppColors.textSecondary);
                          },
                        ),
                      ),
                      // Detalhes do serviço
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Duração: ${service.durationInMinutes} min',
                                    style: TextStyle(color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              currencyFormatter.format(service.price),
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
