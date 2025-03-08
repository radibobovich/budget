abstract class HomeEvent {}

class HomeTransactionsSubscribed implements HomeEvent {}

class HomeCategoryFilterAdded implements HomeEvent {
  final int categoryId;
  HomeCategoryFilterAdded(this.categoryId);
}

class HomeCategoryFilterRemoved implements HomeEvent {
  final int categoryId;
  HomeCategoryFilterRemoved(this.categoryId);
}

class HomeCategoryFilterReset implements HomeEvent {}

class HomeDateFilterSet implements HomeEvent {
  final DateTime? Function()? start;
  final DateTime? Function()? end;
  HomeDateFilterSet(this.start, this.end);
}
