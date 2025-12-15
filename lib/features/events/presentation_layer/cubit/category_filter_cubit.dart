import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class CategoryFilterCubit extends Cubit<CategoryFilterState> {
  CategoryFilterCubit() : super(const CategoryFilterState('All Categories'));

  void changeCategory(String category) {
    emit(CategoryFilterState(category));
  }

  void clearFilter() {
    emit(const CategoryFilterState('All Categories'));
  }
}

class CategoryFilterState extends Equatable {
  final String selectedCategory;

  const CategoryFilterState(this.selectedCategory);

  @override
  List<Object> get props => [selectedCategory];
}
