import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  final String id;
  final String name;
  final double price;
  final int durationInMinutes;
  final String imageUrl; // Campo adicionado para a imagem

  ServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.durationInMinutes,
    required this.imageUrl, // Campo adicionado
  });

  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ServiceModel(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      durationInMinutes: data['durationInMinutes'] ?? 0,
      // Lê o campo da imagem do Firebase, com um valor padrão para evitar erros
      imageUrl: data['imageUrl'] ?? 'assets/rdc.PNG',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'durationInMinutes': durationInMinutes,
      'imageUrl': imageUrl,
    };
  }
}
