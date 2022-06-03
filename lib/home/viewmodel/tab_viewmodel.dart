import 'package:mobx/mobx.dart';

import '../model/photos_rover_model.dart';
import '../service/tab_service.dart';

part 'tab_viewmodel.g.dart';

class TabViewModel = _TabViewModelBase with _$TabViewModel;

abstract class _TabViewModelBase with Store {
  @observable
  TabModel? tabModel;
  @observable
  bool listEnd = false;
  @observable
  String? filter;

  @action
  getData(int page, String roverName) async {
    dynamic response = await TabService().getPhotos(page, roverName, filter);
    tabModel = TabModel.fromJson(response);
  }

  @action
  getNewDatas(int page, String roverName) async {
    listEnd = false;
    dynamic response = await TabService().getPhotos(page, roverName, filter);
    if (TabModel.fromJson(response).photos!.isEmpty) {
      print('boş');
      listEnd = true;
    }
    tabModel!.photos!.addAll(TabModel.fromJson(response).photos!);
    tabModel = tabModel;
  }

  getFilterData(int page, String roverName) async {
    tabModel!.photos!.clear();
    dynamic response = await TabService().getPhotos(page, roverName, filter);
    tabModel = TabModel.fromJson(response);
    //bir sonraki sayfa boş ise proccesbar durması için
    dynamic response2 = await TabService().getPhotos(++page, roverName, filter);
    if (TabModel.fromJson(response2).photos!.isEmpty) {
      print('boş');
      listEnd = true;
    }
  }
}
