import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_firebase/model/todo_model.dart';
import 'package:flutter_todo_firebase/provider/date_time_provider.dart';
import 'package:flutter_todo_firebase/provider/radio_provider.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../constans/app_style.dart';
import '../provider/service_provider.dart';
import '../widget/date_time_widget.dart';
import '../widget/radio_widget.dart';
import '../widget/textfield_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
  const AddNewTaskModel({
    super.key,
  });

  static final titleController = TextEditingController();
  static final descriptionsController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              'New Task Todo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Gap(12),
          const Text(
            'Title Task',
            style: AppStyle.headingStyle,
          ),
          const Gap(6),
          TextFieldWidget(
            maxLines: 1,
            hintText: 'Add Task Name',
            textEditingController: titleController,
          ),
          const Gap(12),
          const Text(
            'Descriptions',
            style: AppStyle.headingStyle,
          ),
          const Gap(6),
          TextFieldWidget(
            maxLines: 5,
            hintText: 'Add Descriptions',
            textEditingController: descriptionsController,
          ),
          const Gap(12),
          //CATEGORY SECTION
          const Text(
            'Category',
            style: AppStyle.headingStyle,
          ),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  titleRadio: 'Learning',
                  categoryColor: Colors.green,
                  valueInput: 1,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 1),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: 'Working',
                  categoryColor: Colors.blue.shade700,
                  valueInput: 2,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 2),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: 'General',
                  categoryColor: Colors.amberAccent.shade700,
                  valueInput: 3,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 3),
                ),
              )
            ],
          ),

          //DATE AND TIME SECTION

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                  titleText: 'Date',
                  valueText: dateProv,
                  icon: CupertinoIcons.calendar,
                  onTap: () async {
                    final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025),
                    );
                    if (getValue != null) {
                      final format = DateFormat.yMd();
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => format.format(getValue));
                    }
                  }),
              const Gap(22),
              DateTimeWidget(
                  titleText: 'Time',
                  valueText: ref.watch(timeProvider),
                  icon: CupertinoIcons.clock,
                  onTap: () async {
                    final getValue = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (getValue != null) {
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => getValue.format(context));
                    }
                  }),
            ],
          ),

          //BUTTTON SECTION

          const Gap(12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.blue.shade800),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Gap(20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.blue.shade800),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Create'),
                  onPressed: () {
                    final getRadioValue = ref.read(radioProvider);
                    String category = '';
                    switch (getRadioValue) {
                      case 1:
                        category = 'Learning';
                        break;
                      case 2:
                        category = 'Working';
                        break;
                      case 3:
                        category = 'General';
                        break;
                    }
                    ref.read(serviceProvider).addNewTask(TodoModel(
                          titleTask: titleController.text,
                          descriptionsTask: descriptionsController.text,
                          category: category,
                          dateTask: ref.read(dateProvider),
                          timeTask: ref.read(timeProvider),
                          isDone: false,
                        ));
                    titleController.clear();
                    descriptionsController.clear();
                    ref.read(radioProvider.notifier).update((state) => 0);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
