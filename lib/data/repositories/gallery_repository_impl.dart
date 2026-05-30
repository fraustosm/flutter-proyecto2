import '../../domain/repositories/gallery_repository.dart';
import '../../data/datasources/unsplash_service.dart';
import '../../data/models/image_model.dart';

class GalleryRepositoryImpl
    implements GalleryRepository {

  final UnsplashService service;

  GalleryRepositoryImpl(this.service);

  @override
  Future<List<ImageModel>> getPhotos() async {

    final response =
        await service.fetchPhotos();

    return response
        .map<ImageModel>(
          (json) => ImageModel.fromJson(json),
        )
        .toList();
  }
}