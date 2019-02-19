import '../model/gank_info.dart';

class UpdateFavoritesEvent {
  final GankInfo gankInfo;

  UpdateFavoritesEvent(this.gankInfo);
}