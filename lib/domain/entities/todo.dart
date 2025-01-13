class Todo {
  final String? id;
  final String text;
  bool isDone;

  Todo({
    this.id,
    required this.text,
    this.isDone = false,
  });
}
