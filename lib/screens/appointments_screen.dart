import 'package:barbearia_rei_du_corte/models/booking_model.dart';
import 'package:barbearia_rei_du_corte/services/firestore_service.dart';
import 'package:barbearia_rei_du_corte/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    final dateFormatter = DateFormat('dd/MM/yyyy \'às\' HH:mm', 'pt_BR');

    // Função para mostrar o diálogo de confirmação de cancelamento
    Future<void> _showCancelDialog(BookingModel booking) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: AppColors.cardBackground,
            title: const Text('Cancelar Agendamento'),
            content: const SingleChildScrollView(
              child: Text('Você tem certeza que deseja cancelar este agendamento?'),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Voltar', style: TextStyle(color: AppColors.textSecondary)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                child: const Text('Confirmar', style: TextStyle(color: AppColors.primary)),
                onPressed: () async {
                  // Chama o método para deletar do Firebase
                  await firestoreService.deleteBooking(booking.id);
                  Navigator.of(dialogContext).pop(); // Fecha o diálogo
                  // Mostra uma mensagem de confirmação
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Agendamento cancelado.'),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: StreamBuilder<List<BookingModel>>(
        stream: firestoreService.getBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar agendamentos: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month, size: 80, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum agendamento encontrado',
                    style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
                  ),
                ],
              ),
            );
          }

          final bookings = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                  title: Text(
                    booking.serviceName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    dateFormatter.format(booking.bookingDate),
                    style: TextStyle(color: AppColors.textSecondary, height: 1.5),
                  ),
                  // Ícone de lixeira para cancelar
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () => _showCancelDialog(booking),
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
