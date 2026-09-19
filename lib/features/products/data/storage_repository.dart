import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageRepository {
  final FirebaseStorage _storage;

  StorageRepository({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  Future<String> uploadProductImage(XFile imageFile, String productId) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${imageFile.name}';
    final ref = _storage.ref().child('products/$productId/$fileName');

    final uploadTask = await ref.putFile(File(imageFile.path));
    final downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<List<String>> uploadProductImages(
      List<XFile> imageFiles, String productId) async {
    final List<String> downloadUrls = [];
    for (final file in imageFiles) {
      final url = await uploadProductImage(file, productId);
      downloadUrls.add(url);
    }
    return downloadUrls;
  }
}
