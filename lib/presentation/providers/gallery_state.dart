import '../../data/models/image_model.dart';

class GalleryState {
  final List<ImageModel> images;
  final bool isLoading;
  final String? error;
  final int page;

  const GalleryState({
    required this.images,
    required this.isLoading,
    required this.error,
    required this.page,
  });

  factory GalleryState.initial() {
    return const GalleryState(
      images: [],
      isLoading: false,
      error: null,
      page: 1,
    );
  }

  GalleryState copyWith({
    List<ImageModel>? images,
    bool? isLoading,
    String? error,
    int? page,
  }) {
    return GalleryState(
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      page: page ?? this.page,
    );
  }
}