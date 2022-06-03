import 'tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../viewmodel/tab_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _tabViewModel = TabViewModel();

  String roverName = 'curiosity';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: _scoffold(context),
      ),
    );
  }

  Scaffold _scoffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _filterIcon(context),
        ],
        bottom: _tabbar(),
        title: Text('Mars Photos'),
      ),
      body: _tabbarView(),
    );
  }

  TabBarView _tabbarView() {
    return TabBarView(
      children: [
        TabView(
          roverName: 'curiosity',
          tabViewModel: _tabViewModel,
        ),
        TabView(
          roverName: 'opportunity',
          tabViewModel: _tabViewModel,
        ),
        TabView(
          roverName: 'spirit',
          tabViewModel: _tabViewModel,
        ),
      ],
    );
  }

  TabBar _tabbar() {
    return TabBar(
      tabs: [
        Tab(child: Text('Curiosity')),
        Tab(child: Text('Opportunity')),
        Tab(child: Text('Spirit')),
      ],
      onTap: (index) {
        if (index == 0) {
          roverName = 'curiosity';
        } else if (index == 1) {
          roverName = 'opportunity';
        } else {
          roverName = 'spirit';
        }
      },
    );
  }

  IconButton _filterIcon(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Observer(builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Kamera Filtre'),
                    _dropDown(),
                    TextButton(
                      onPressed: () {
                        _tabViewModel.getFilterData(1, roverName);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Uygula',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _tabViewModel.filter = null;
                        _tabViewModel.getFilterData(1, roverName);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Temizle',
                      ),
                    ),
                  ],
                );
              }),
            );
          },
        );
      },
      icon: Icon(
        Icons.filter_list_alt,
        size: 30,
      ),
    );
  }

  DropdownButton<String> _dropDown() {
    return DropdownButton<String>(
      value: _tabViewModel.filter,
      hint: Text('Kamera Seçiniz'),
      icon: Icon(Icons.arrow_downward),
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        _tabViewModel.filter = newValue!;
      },
      items: <String>[
        'FHAZ',
        'RHAZ',
        'MAST',
        'CHEMCAM',
        'MAHLI',
        'MARDI',
        'NAVCAM',
        'PANCAM',
        'MINITES',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
