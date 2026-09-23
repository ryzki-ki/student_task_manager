import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ====================
// APP ROOT
// ====================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),

      home: const StudentTaskManager(),
    );
  }
}

// ====================
// TASK MODEL
// ====================

class Task {
  String title;
  String subject;
  DateTime deadline;
  String note;
  bool isDone;
  Color color;

  Task({
    required this.title,
    required this.subject,
    required this.deadline,
    required this.note,
    this.isDone = false,
    required this.color,
  });
}

// ====================
// STUDENT TASK MANAGER
// ====================

class StudentTaskManager extends StatefulWidget {
  const StudentTaskManager({super.key});

  @override
  State<StudentTaskManager> createState() =>
      _StudentTaskManagerState();
}

class _StudentTaskManagerState
    extends State<StudentTaskManager> {

  // ====================
  // DATA TASK
  // ====================

  final List<Task> tasks = [
    Task(
      title: 'Tugas Matematika',
      subject: 'Matematika',
      deadline: DateTime(2026, 9, 25),
      note: 'Kerjakan halaman 20',
      color: Colors.red,
    ),

    Task(
      title: 'Membuat UI Flutter',
      subject: 'PPLG',
      deadline: DateTime(2026, 9, 27),
      note: 'Buat halaman dashboard',
      color: Colors.blue,
    ),

    Task(
      title: 'Belajar Bahasa Jawa',
      subject: 'Bahasa Jawa',
      deadline: DateTime(2026, 9, 28),
      note: 'Pelajari tembang macapat',
      color: Colors.green,
    ),
  ];

  // ====================
  // CHECK TASK
  // ====================

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone =
          !tasks[index].isDone;
    });
  }

  // ====================
  // DELETE TASK
  // ====================

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // ====================
  // CHANGE COLOR
  // ====================

  void changeColor(
    int index,
    Color color,
  ) {
    setState(() {
      tasks[index].color = color;
    });
  }

  // ====================
  // ADD TASK
  // ====================

  void showAddTaskDialog() {
    final titleController =
        TextEditingController();

    final subjectController =
        TextEditingController();

    final noteController =
        TextEditingController();

    DateTime selectedDate =
        DateTime.now();

    Color selectedColor =
        Colors.blue;

    showDialog(
      context: context,

      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            return AlertDialog(
              title: const Text(
                'Tambah Tugas',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              content:
                  SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    // ====================
                    // TASK NAME
                    // ====================

                    TextField(
                      controller:
                          titleController,

                      decoration:
                          const InputDecoration(
                        labelText:
                            'Nama tugas',

                        hintText:
                            'Contoh: Tugas Matematika',

                        prefixIcon:
                            Icon(
                          Icons.task_alt,
                        ),

                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    // ====================
                    // SUBJECT
                    // ====================

                    TextField(
                      controller:
                          subjectController,

                      decoration:
                          const InputDecoration(
                        labelText:
                            'Mata pelajaran',

                        hintText:
                            'Contoh: Matematika',

                        prefixIcon:
                            Icon(
                          Icons.book_outlined,
                        ),

                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    // ====================
                    // DEADLINE
                    // ====================

                    InkWell(
                      onTap: () async {
                        final pickedDate =
                            await showDatePicker(
                          context: context,

                          initialDate:
                              selectedDate,

                          firstDate:
                              DateTime.now(),

                          lastDate:
                              DateTime(2035),
                        );

                        if (pickedDate !=
                            null) {
                          setDialogState(() {
                            selectedDate =
                                pickedDate;
                          });
                        }
                      },

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),

                      child: Container(
                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets.all(
                          14,
                        ),

                        decoration:
                            BoxDecoration(
                          border:
                              Border.all(
                            color: Colors
                                .grey
                                .shade400,
                          ),

                          borderRadius:
                              BorderRadius
                                  .circular(
                            12,
                          ),
                        ),

                        child: Row(
                          children: [

                            const Icon(
                              Icons
                                  .calendar_month,

                              color:
                                  Colors.deepPurple,
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                const Text(
                                  'Deadline',

                                  style:
                                      TextStyle(
                                    fontSize:
                                        12,

                                    color:
                                        Colors.grey,
                                  ),
                                ),

                                const SizedBox(
                                  height: 3,
                                ),

                                Text(
                                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',

                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    // ====================
                    // NOTE
                    // ====================

                    TextField(
                      controller:
                          noteController,

                      maxLines: 3,

                      decoration:
                          const InputDecoration(
                        labelText:
                            'Catatan',

                        hintText:
                            'Tambahkan catatan...',

                        prefixIcon:
                            Icon(
                          Icons.notes,
                        ),

                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // ====================
                    // COLOR
                    // ====================

                    const Align(
                      alignment:
                          Alignment.centerLeft,

                      child: Text(
                        'Warna tugas',

                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceEvenly,

                      children: [

                        buildColorButton(
                          Colors.red,
                          selectedColor,

                          (color) {
                            setDialogState(() {
                              selectedColor =
                                  color;
                            });
                          },
                        ),

                        buildColorButton(
                          Colors.orange,
                          selectedColor,

                          (color) {
                            setDialogState(() {
                              selectedColor =
                                  color;
                            });
                          },
                        ),

                        buildColorButton(
                          Colors.green,
                          selectedColor,

                          (color) {
                            setDialogState(() {
                              selectedColor =
                                  color;
                            });
                          },
                        ),

                        buildColorButton(
                          Colors.blue,
                          selectedColor,

                          (color) {
                            setDialogState(() {
                              selectedColor =
                                  color;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ====================
              // BUTTON
              // ====================

              actions: [

                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                    );
                  },

                  child:
                      const Text('Batal'),
                ),

                ElevatedButton.icon(
                  onPressed: () {

                    // Nama tugas wajib
                    if (titleController
                        .text
                        .trim()
                        .isEmpty) {

                      ScaffoldMessenger
                          .of(this.context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Nama tugas belum diisi!',
                          ),
                        ),
                      );

                      return;
                    }

                    // Tambahkan task
                    setState(() {

                      tasks.add(
                        Task(
                          title:
                              titleController
                                  .text
                                  .trim(),

                          subject:
                              subjectController
                                  .text
                                  .trim(),

                          deadline:
                              selectedDate,

                          note:
                              noteController
                                  .text
                                  .trim(),

                          color:
                              selectedColor,
                        ),
                      );
                    });

                    Navigator.pop(
                      dialogContext,
                    );
                  },

                  icon:
                      const Icon(
                    Icons.add,
                  ),

                  label:
                      const Text(
                    'Tambah',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ====================
  // COLOR BUTTON
  // ====================

  Widget buildColorButton(
    Color color,
    Color selectedColor,
    Function(Color) onSelected,
  ) {
    final bool isSelected =
        selectedColor == color;

    return GestureDetector(
      onTap: () {
        onSelected(color);
      },

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 200,
        ),

        width:
            isSelected ? 46 : 40,

        height:
            isSelected ? 46 : 40,

        decoration:
            BoxDecoration(
          color: color,

          shape:
              BoxShape.circle,

          border:
              Border.all(
            color: isSelected
                ? Colors.black
                : Colors.transparent,

            width: 3,
          ),
        ),

        child: isSelected
            ? const Icon(
                Icons.check,
                color:
                    Colors.white,
              )
            : null,
      ),
    );
  }

  // ====================
  // BUILD
  // ====================

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F7),

      // ====================
      // APP BAR
      // ====================

      appBar: AppBar(
        backgroundColor:
            Colors.deepPurple,

        foregroundColor:
            Colors.white,

        elevation: 0,

        title: const Text(
          'Student Task Manager',

          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [

          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons
                  .notifications_outlined,
            ),
          ),
        ],
      ),

      // ====================
      // BODY
      // ====================

      body: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'Tugas Kamu 📚',

              style: TextStyle(
                fontSize: 26,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 4,
            ),

            Text(
              '${tasks.length} tugas tersedia',

              style: TextStyle(
                color:
                    Colors.grey.shade600,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada tugas 🎉',

                        style:
                            TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    )

                  : ListView.builder(
                      itemCount:
                          tasks.length,

                      itemBuilder:
                          (context, index) {

                        final task =
                            tasks[index];

                        return TaskCard(
                          task: task,

                          onToggle: () {
                            toggleTask(
                              index,
                            );
                          },

                          onDelete: () {
                            deleteTask(
                              index,
                            );
                          },

                          onColorChanged:
                              (color) {
                            changeColor(
                              index,
                              color,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // ====================
      // ADD BUTTON
      // ====================

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed:
            showAddTaskDialog,

        backgroundColor:
            Colors.deepPurple,

        foregroundColor:
            Colors.white,

        icon:
            const Icon(Icons.add),

        label: const Text(
          'Tambah Tugas',

          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =====================================================
// TASK CARD
// =====================================================

class TaskCard
    extends StatelessWidget {

  final Task task;

  final VoidCallback onToggle;

  final VoidCallback onDelete;

  final Function(Color)
      onColorChanged;

  const TaskCard({
    super.key,

    required this.task,

    required this.onToggle,

    required this.onDelete,

    required this.onColorChanged,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Dismissible(
      key:
          ObjectKey(task),

      direction:
          DismissDirection
              .endToStart,

      // ====================
      // DELETE BACKGROUND
      // ====================

      background:
          Container(
        margin:
            const EdgeInsets.only(
          bottom: 12,
        ),

        padding:
            const EdgeInsets.only(
          right: 20,
        ),

        alignment:
            Alignment.centerRight,

        decoration:
            BoxDecoration(
          color: Colors.red,

          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),

        child: const Icon(
          Icons.delete,

          color:
              Colors.white,
        ),
      ),

      onDismissed:
          (direction) {
        onDelete();
      },

      // ====================
      // CARD
      // ====================

      child: Container(
        margin:
            const EdgeInsets.only(
          bottom: 12,
        ),

        decoration:
            BoxDecoration(
          color:
              Colors.white,

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          border:
              Border(
            left:
                BorderSide(
              color:
                  task.color,

              width: 7,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(
                0.05,
              ),

              blurRadius:
                  10,

              offset:
                  const Offset(
                0,
                4,
              ),
            ),
          ],
        ),

        child: Padding(
          padding:
              const EdgeInsets.all(
            16,
          ),

          child: Row(
            children: [

              // ====================
              // CHECKBOX
              // ====================

              Checkbox(
                value:
                    task.isDone,

                activeColor:
                    task.color,

                onChanged:
                    (_) {
                  onToggle();
                },
              ),

              const SizedBox(
                width: 8,
              ),

              // ====================
              // INFO
              // ====================

              Expanded(
                child:
                    Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(
                      task.title,

                      style:
                          TextStyle(
                        fontSize:
                            17,

                        fontWeight:
                            FontWeight
                                .bold,

                        decoration:
                            task.isDone
                                ? TextDecoration
                                    .lineThrough
                                : null,

                        color:
                            task.isDone
                                ? Colors.grey
                                : Colors.black87,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Text(
                      task.subject,

                      style:
                          TextStyle(
                        color:
                            task.color,

                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Row(
                      children: [

                        const Icon(
                          Icons
                              .calendar_today_outlined,

                          size: 15,

                          color:
                              Colors.grey,
                        ),

                        const SizedBox(
                          width: 5,
                        ),

                        Text(
                          '${task.deadline.day}/${task.deadline.month}/${task.deadline.year}',

                          style:
                              const TextStyle(
                            color:
                                Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    if (task.note
                        .isNotEmpty) ...[
                      const SizedBox(
                        height: 5,
                      ),

                      Text(
                        task.note,

                        style:
                            TextStyle(
                          color:
                              Colors.grey.shade600,

                          fontSize:
                              13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // ====================
              // MENU COLOR
              // ====================

              PopupMenuButton<Color>(
                icon:
                    const Icon(
                  Icons.more_vert,
                ),

                onSelected:
                    (color) {
                  onColorChanged(
                    color,
                  );
                },

                itemBuilder:
                    (context) {
                  return const [

                    PopupMenuItem(
                      value:
                          Colors.red,

                      child:
                          Text(
                        '🔴 Merah',
                      ),
                    ),

                    PopupMenuItem(
                      value:
                          Colors.orange,

                      child:
                          Text(
                        '🟠 Orange',
                      ),
                    ),

                    PopupMenuItem(
                      value:
                          Colors.green,

                      child:
                          Text(
                        '🟢 Hijau',
                      ),
                    ),

                    PopupMenuItem(
                      value:
                          Colors.blue,

                      child:
                          Text(
                        '🔵 Biru',
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}