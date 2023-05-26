import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_firebase/provider/service_provider.dart';
import 'package:gap/gap.dart';

class CardTodoListWidget extends ConsumerWidget {
  final int getIndex;

  const CardTodoListWidget({super.key, required this.getIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);

    return todoData.when(
        data: (todoData) {
          final getCategory = todoData[getIndex].category;
          Color categoryColor = Colors.white;
          switch (getCategory) {
            case 'Learning':
              categoryColor = Colors.green;
              break;
            case 'Working':
              categoryColor = Colors.blue.shade700;
              break;
            case 'General':
              categoryColor = Colors.amberAccent.shade700;
              break;
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: IconButton(
                            icon: const Icon(CupertinoIcons.delete),
                            onPressed: () => ref
                                .read(serviceProvider)
                                .deleteTask(todoData[getIndex].docId),
                          ),
                          title: Text(
                            todoData[getIndex].titleTask,
                            maxLines: 1,
                            style: TextStyle(
                              decoration: todoData[getIndex].isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          subtitle: Text(
                            todoData[getIndex].descriptionsTask,
                            maxLines: 1,
                            style: TextStyle(
                              decoration: todoData[getIndex].isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                activeColor: Colors.blue.shade800,
                                shape: const CircleBorder(),
                                value: todoData[getIndex].isDone,
                                onChanged: (value) {
                                  log(value.toString());
                                  log(todoData[getIndex].docId.toString());
                                  ref.read(serviceProvider).updateTask(
                                      todoData[getIndex].docId, value);
                                }),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -12),
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                children: [
                                  const Text('Today'),
                                  const Gap(12),
                                  Text(todoData[getIndex].timeTask)
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => const Center(
              child: Text('Error'),
            ),
        loading: (() => const Center(
              child: CircularProgressIndicator(),
            )));
  }
}
