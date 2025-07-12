import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo/screens/add_que/add_view.dart';
import 'package:odoo/screens/loginScreen/loginScreen.dart';
import 'package:odoo/screens/view_que/view_question_page.dart';

import '../../controller/ans_controller.dart';
import '../../module/ans_module.dart';


class TempRun extends StatelessWidget {
  const TempRun({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _ansController = Get.put(AnsController());

  final TextEditingController _searchController  =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const FilterDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'StackIt',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: const Text('Login', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => _ansController.filterAnswers(_searchController.text),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // NEW: Filter Dropdown
                Obx(() => DropdownButton<String>(
                  dropdownColor: Colors.grey[900],
                  value: _ansController.selectedFilter.value,
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  underline: Container(height: 0),
                  onChanged: (value) {
                    if (value != null) {
                      _ansController.setFilter(value);
                    }
                  },
                  items: _ansController.filters
                      .map((filter) => DropdownMenuItem(
                    value: filter,
                    child: Text(filter),
                  ))
                      .toList(),
                )),
              ],
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AskQuestionScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                "Ask New Question",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            // Question Card
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final answers = _ansController.filteredAnswers;

                    return QuestionCard(answer: answers[index],);
                  },
                  itemCount: _ansController.filteredAnswers.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//comment

class QuestionCard extends StatelessWidget {
  final AnsModule answer;

  const QuestionCard({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewQuestionPage()));
      },
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Votes and Title Row
              Row(
                children: [
                  Column(
                    children: [
                      IconButton(icon: Icon(Icons.keyboard_arrow_up, color: Colors.white),onPressed: () {

                      },),
                      Text(
                        (answer.upVotes - answer.downVotes).toString()  ,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      IconButton(icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),onPressed: () {

                      },),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      answer.que,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: const [
                  Chip(
                    label: Text("Sample", style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blueGrey,
                  ),
                  Chip(
                    label: Text("Tags", style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blueGrey,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                answer.content,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                answer.author,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        children: const [
          Text(
            "Filters",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            title: Text("Newest", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            title: Text("Unanswered", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            title: Text("More", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
