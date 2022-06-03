// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TabViewModel on _TabViewModelBase, Store {
  late final _$tabModelAtom =
      Atom(name: '_TabViewModelBase.tabModel', context: context);

  @override
  TabModel? get tabModel {
    _$tabModelAtom.reportRead();
    return super.tabModel;
  }

  @override
  set tabModel(TabModel? value) {
    _$tabModelAtom.reportWrite(value, super.tabModel, () {
      super.tabModel = value;
    });
  }

  late final _$listEndAtom =
      Atom(name: '_TabViewModelBase.listEnd', context: context);

  @override
  bool get listEnd {
    _$listEndAtom.reportRead();
    return super.listEnd;
  }

  @override
  set listEnd(bool value) {
    _$listEndAtom.reportWrite(value, super.listEnd, () {
      super.listEnd = value;
    });
  }

  late final _$filterAtom =
      Atom(name: '_TabViewModelBase.filter', context: context);

  @override
  String? get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(String? value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  late final _$getDataAsyncAction =
      AsyncAction('_TabViewModelBase.getData', context: context);

  @override
  Future getData(int page, String roverName) {
    return _$getDataAsyncAction.run(() => super.getData(page, roverName));
  }

  late final _$getNewDatasAsyncAction =
      AsyncAction('_TabViewModelBase.getNewDatas', context: context);

  @override
  Future getNewDatas(int page, String roverName) {
    return _$getNewDatasAsyncAction
        .run(() => super.getNewDatas(page, roverName));
  }

  @override
  String toString() {
    return '''
tabModel: ${tabModel},
listEnd: ${listEnd},
filter: ${filter}
    ''';
  }
}
