extension ExtensionList<T> on List<T> {
  List<E> builder<E>(E Function(T) builder) =>
      map<E>((T e) => builder(e)).toList();

  List<E> builderEntry<E>(E Function(MapEntry<int, T>) builder) =>
      asMap().entries.map((MapEntry<int, T> entry) => builder(entry)).toList();
}
