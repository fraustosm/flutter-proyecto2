import '../../domain/repositories/gallery_repository.dart';
import '../../data/datasources/unsplash_service.dart';
import '../../data/models/image_model.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final UnsplashService service;

  GalleryRepositoryImpl(this.service);

  @override
  Future<List<ImageModel>> getPhotos({
    int page = 1,
  }) async {
    final response = await service.fetchPhotos(
      page: page,
    );

    return response
        .map<ImageModel>(
          (json) => ImageModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}



























































