import 'package:cloud_firestore/cloud_firestore.dart';

class FilteredQuerySnapshot<T> extends QuerySnapshot<T> {
  FilteredQuerySnapshot(this.filteredDataList, this._metadata);

  final List<QueryDocumentSnapshot<T>> filteredDataList;
  final SnapshotMetadata _metadata;

  @override
  List<QueryDocumentSnapshot<T>> get docs => filteredDataList;

  @override
  SnapshotMetadata get metadata => _metadata;

  @override
  bool get isNotEmpty => filteredDataList.isNotEmpty;

  @override
  bool get isEmpty => filteredDataList.isEmpty;

  @override
  List<DocumentChange<T>> get docChanges => throw UnimplementedError();

  @override
  int get size => filteredDataList.length;
}
