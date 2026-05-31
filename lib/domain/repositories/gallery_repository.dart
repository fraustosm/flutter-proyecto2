import '../../data/models/image_model.dart';

abstract class GalleryRepository {
  Future<List<ImageModel>> getPhotos({
    int page = 1,
  });
}