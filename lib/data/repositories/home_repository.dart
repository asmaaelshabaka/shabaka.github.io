import 'package:shabakahub2025/data/providers/home_provider.dart';

class HomeRepository
{
  final HomeProvider _homeProvider;

  HomeRepository(this._homeProvider);
 Future<String?> getIntroVideo()async
  {
    try{
    return await  _homeProvider.getIntroVideo();
    }
        catch(e)
    { throw Exception(
      'Failed to fetch intro video from repository: ${e.toString()}',
    );}
  }
}