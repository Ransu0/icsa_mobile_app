import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final eventName = TextEditingController();
  final fines = TextEditingController();

  // Date / Time variables
  DateTime? dateOfEvent;
  TimeOfDay? timeInStart;
  TimeOfDay? timeInEnd;
  TimeOfDay? timeOutStart;
  TimeOfDay? timeOutEnd;

  // File picker
  PlatformFile? selectedFile;

  // ***********************
  // PICKERS
  // ***********************
  Future<void> pickEventDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dateOfEvent ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: _darkPickerTheme,
    );

    if (picked != null) setState(() => dateOfEvent = picked);
  }

  Future<void> pickTime(Function(TimeOfDay?) assign) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
      builder: _darkTimePickerTheme,
    );
    if (picked != null) assign(picked);
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() => selectedFile = result.files.first);
    }
  }

  // ***********************
  // UI HELPERS
  // ***********************
  Widget _darkPickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7B61FF),
          onSurface: Colors.white,
        ),
      ),
      child: child!,
    );
  }

  Widget _darkTimePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: ThemeData.dark().copyWith(
        timePickerTheme: const TimePickerThemeData(
          backgroundColor: Color(0xFF1F2330),
          hourMinuteShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7B61FF),
        ),
      ),
      child: child!,
    );
  }

  Widget inputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget textInputField(String label, TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        inputLabel(label),
        TextFormField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1F2330),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
        ),
      ],
    );
  }

  Widget datePickerField(String label, DateTime? value, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        inputLabel(label),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2330),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              value != null
                  ? "${value.month}/${value.day}/${value.year}"
                  : "Select date",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Widget timePickerField(String label, TimeOfDay? value, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        inputLabel(label),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2330),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              value != null ? value.format(context) : "Select time",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  // ***********************
  // MAIN UI
  // ***********************
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16151C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            const Text("Create Event", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              textInputField("Event Name", eventName),
              const SizedBox(height: 18),

              datePickerField("Date of Event", dateOfEvent, pickEventDate),
              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                      child: timePickerField(
                          "Time In (Start)",
                          timeInStart,
                          () => pickTime(
                              (t) => setState(() => timeInStart = t)))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: timePickerField(
                          "Time In (End)",
                          timeInEnd,
                          () =>
                              pickTime((t) => setState(() => timeInEnd = t)))),
                ],
              ),
              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                      child: timePickerField(
                          "Time Out (Start)",
                          timeOutStart,
                          () => pickTime(
                              (t) => setState(() => timeOutStart = t)))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: timePickerField(
                          "Time Out (End)",
                          timeOutEnd,
                          () =>
                              pickTime((t) => setState(() => timeOutEnd = t)))),
                ],
              ),
              const SizedBox(height: 18),

              textInputField("Fines (₱)", fines, type: TextInputType.number),
              const SizedBox(height: 18),

              // FILE PICKER FIELD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  inputLabel("Attach File (Optional)"),
                  GestureDetector(
                    onTap: pickFile,
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F2330),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        selectedFile != null
                            ? selectedFile!.name
                            : "Choose file...",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Submit the form to Firebase
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B61FF),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Create Event",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
