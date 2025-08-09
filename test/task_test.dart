import 'package:flutter_test/flutter_test.dart';
import 'package:tasks_app/tasks_list.dart';

void main() {
  test('Task should be created correctly', () {
    final task = Task(
      id: 1,
      title: 'Test Task',
      description: 'Test Description',
      isComplete: false,
    );

    expect(task.id, 1);
    expect(task.title, 'Test Task');
    expect(task.description, 'Test Description');
    expect(task.isComplete, false);
  });

  test('Task fromJson should work', () {
    final json = {
      'id': 2,
      'title': 'JSON Task',
      'description': 'From JSON',
      'isComplete': true,
    };

    final task = Task.fromJson(json);

    expect(task.id, 2);
    expect(task.title, 'JSON Task');
    expect(task.isComplete, true);
  });

  test('Task toJson should work', () {
    final task = Task(
      id: 3,
      title: 'To JSON',
      description: 'Converting to JSON',
      isComplete: false,
    );

    final json = task.toJson();

    expect(json['id'], 3);
    expect(json['title'], 'To JSON');
    expect(json['isComplete'], false);
  });
}