import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../model/photos_rover_model.dart';
import '../viewmodel/tab_viewmodel.dart';

class TabView extends StatefulWidget {
  final String roverName;
  final TabViewModel tabViewModel;

  TabView({
    Key? key,
    required this.roverName,
    required this.tabViewModel,
  }) : super(key: key);

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    widget.tabViewModel.getData(page, widget.roverName);
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.offset) {
        page++;
        widget.tabViewModel.getNewDatas(page, widget.roverName);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return widget.tabViewModel.tabModel == null
            ? Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                ),
              )
            : _scrollView(context);
      },
    );
  }

  GridView _scrollView(BuildContext context) {
    return GridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: List.generate(
        (widget.tabViewModel.tabModel!.photos!.length) + 1,
        (index) {
          if (index == widget.tabViewModel.tabModel!.photos!.length) {
            if (widget.tabViewModel.listEnd) return Container();
            return CupertinoActivityIndicator(
              radius: 20,
            );
          }
          TabPhotos data = widget.tabViewModel.tabModel!.photos![index]!;
          return _imageCard(context, data, index);
        },
      ),
    );
  }

  InkWell _imageCard(BuildContext context, TabPhotos data, int index) {
    return InkWell(
      onTap: () {
        _detailDialog(context, data);
      },
      child: Card(
        child: Image.network(
          widget.tabViewModel.tabModel!.photos![index]!.imgSrc.toString(),
        ),
      ),
    );
  }

  Future<dynamic> _detailDialog(BuildContext context, TabPhotos data) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                data.imgSrc.toString(),
              ),
              _rowDetail(
                'Çekildiği tarih: ',
                data.earthDate,
              ),
              _rowDetail(
                'Araç adı: ',
                data.rover!.name,
              ),
              _rowDetail(
                'Kamera adı: ',
                data.camera!.fullName,
              ),
              _rowDetail(
                'Görev durumu: ',
                data.rover!.status,
              ),
              _rowDetail(
                'Fırlatma tarihi: ',
                data.rover!.launchDate,
              ),
              _rowDetail(
                'İniş tarihi: ',
                data.rover!.landingDate,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _rowDetail(String title, String? data) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(title),
          Flexible(
            child: Text(
              data.toString(),
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
