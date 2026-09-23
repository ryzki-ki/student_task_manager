import 'package:flutter/material.dart';

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

void main() {
  runApp(const StudentTaskManager());
}

class StudentTaskManager extends StatefulWidget {
  const StudentTaskManager({super.key});

  @override
  State<StudentTaskManager> createState() => _StudentTaskManagerState();
}

class _StudentTaskManagerState extends State<StudentTaskManager> {
  List<Task> tasks = [
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

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void changeColor(int index, Color color) {
    setState(() {
      tasks[index].color = color;
    });
  }

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
      home: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          title: const Text(
            'Student Task Manager',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tugas Kamu 📚',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                '${tasks.length} tugas tersedia',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada tugas 🎉',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];

                          return TaskCard(
                            task: task,
                            onToggle: () => toggleTask(index),
                            onDelete: () => deleteTask(index),
                            onColorChanged: (color) {
                              changeColor(index, color);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showAddTaskDialog();
          },
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: const Text('Tambah Tugas'),
        ),
      ),
    );
  }

  void showAddTaskDialog() {
    final titleController = TextEditingController();
    final subjectController = TextEditingController();
    final noteController = TextEditingController();

    Color selectedColor = Colors.blue;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Tambah Tugas'),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Nama tugas',
                        prefixIcon: Icon(Icons.task_alt),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Mata pelajaran',
                        prefixIcon: Icon(Icons.book_outlined),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        labelText: 'Catatan',
                        prefixIcon: Icon(Icons.notes),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Warna tugas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        colorButton(
                          Colors.red,
                          selectedColor,
                          (color) {
                            setDialogState(() {
                              selectedColor = color;
                            });
                          },
                        ),

                        colorButton(
                          Colors.orange,
                          selectedColor,
                          (color) {
                            setDialogState(() {
                              selectedColor = color;
                            });
                          },
                        ),

                        colorButton(
                          Colors.green,
                          selectedColor,
                          (color) {
                            setDialogState(() {
                              selectedColor = color;
                            });
                          },
                        ),

                        colorButton(
                          Colors.blue,
                          selectedColor,
                          (color) {
                            setDialogState(() {
                              selectedColor = color;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Batal'),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty) {
                      return;
                    }

                    setState(() {
                      tasks.add(
                        Task(
                          title: titleController.text,
                          subject: subjectController.text,
                          deadline: DateTime.now(),
                          note: noteController.text,
                          color: selectedColor,
                        ),
                      );
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('Tambah'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget colorButton(
    Color color,
    Color selectedColor,
    Function(Color) onSelected,
  ) {
    final isSelected = selectedColor == color;

    return GestureDetector(
      onTap: () {
        onSelected(color);
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 3,
          ),
        ),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(Color) onColorChanged;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(task),

      direction: DismissDirection.endToStart,

      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),

      onDismissed: (direction) {
        onDelete();
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),

          border: Border(
            left: BorderSide(
              color: task.color,
              width: 7,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [
              Checkbox(
                value: task.isDone,
                activeColor: task.color,
                onChanged: (_) {
                  onToggle();
                },
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        decoration: task.isDone
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.isDone
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      task.subject,
                      style: TextStyle(
                        color: task.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 15,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 5),

                        Text(
                          '${task.deadline.day}/${task.deadline.month}/${task.deadline.year}',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    if (task.note.isNotEmpty) ...[
                      const SizedBox(height: 5),

                      Text(
                        task.note,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              PopupMenuButton<Color>(
                icon: const Icon(Icons.more_vert),

                onSelected: (color) {
                  onColorChanged(color);
                },

                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: Colors.red,
                      child: Text('🔴 Merah'),
                    ),
                    const PopupMenuItem(
                      value: Colors.orange,
                      child: Text('🟠 Kuning'),
                    ),
                    const PopupMenuItem(
                      value: Colors.green,
                      child: Text('🟢 Hijau'),
                    ),
                    const PopupMenuItem(
                      value: Colors.blue,
                      child: Text('🔵 Biru'),
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