import 'package:get/get.dart';

import '../module/ans_module.dart';

class AnsController extends GetxController{
  var answers =  <AnsModule>[].obs;

  var filteredAnswers = <AnsModule>[].obs;

  // NEW: Filter options
  var filters = ["Upvoted", "Newest", "Oldest", "A-Z"].obs;
  var selectedFilter = "Upvoted".obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    answers.value = [
      AnsModule(id: 1, que: "How to join columns in SQL?", content: "Use CONCAT or CONCAT_WS to join columns in SQL.", author: "Alice", upVotes: ['4'], downVotes: ['0']),
      AnsModule(id: 2, que: "How to center a div in HTML?", content: "Use flexbox with justify-content and align-items.", author: "Bob", upVotes: ['3'], downVotes: ['1']),
      AnsModule(id: 3, que: "What is a foreign key in SQL?", content: "A foreign key links one table to another.", author: "Charlie", upVotes: ['5'], downVotes: ['0']),
      AnsModule(id: 4, que: "Difference between var, let, and const in JavaScript?", content: "var is function-scoped, let and const are block-scoped.", author: "Dave", upVotes: ['7'], downVotes: ['2']),
      AnsModule(id: 5, que: "How to make API call in Flutter?", content: "Use the http package or Dio for network calls.", author: "Eva", upVotes: ['6'], downVotes: ['1']),
      AnsModule(id: 6, que: "How to use GridView in Flutter?", content: "Use GridView.builder with SliverGridDelegate for custom layout.", author: "Frank", upVotes: ['4'], downVotes: ['0']),
      AnsModule(id: 7, que: "What is null safety in Dart?", content: "It ensures variables can't be null unless explicitly declared.", author: "Grace", upVotes: ['8'], downVotes: ['0']),
      AnsModule(id: 8, que: "How to create a responsive layout in Flutter?", content: "Use LayoutBuilder or MediaQuery for adaptive design.", author: "Hannah", upVotes: ['5'], downVotes: ['1']),
      AnsModule(id: 9, que: "What is the use of keys in Flutter widgets?", content: "Keys preserve widget state during rebuilds.", author: "Ian", upVotes: ['3'], downVotes: ['1']),
      AnsModule(id: 10, que: "How to implement dark mode in Flutter?", content: "Use ThemeData.dark() and listen to brightness changes.", author: "Jack", upVotes: ['6'], downVotes: ['0']),
    ];

    applyFilters();
  }

  void filterAnswers(String query) {
    var filtered = answers.where((ans) => (ans.que ?? "").toLowerCase().contains(query.toLowerCase())).toList();
    filteredAnswers.value = sortAnswers(filtered);
  }

  void setFilter(String newFilter) {
    selectedFilter.value = newFilter;
    applyFilters();
  }

  void applyFilters() {
    var currentSearch = filteredAnswers.isEmpty ? answers : filteredAnswers;
    filteredAnswers.value = sortAnswers(List.from(currentSearch));
  }

  List<AnsModule> sortAnswers(List<AnsModule> list) {
    switch (selectedFilter.value) {
      case "Upvoted":
        list.sort((a, b) => (b.upVotes - b.downVotes).compareTo(a.upVotes - a.downVotes));
        break;
      case "Newest":
        list.sort((a, b) => (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now()));
        break;
      case "Oldest":
        list.sort((a, b) => (a.createdAt ?? DateTime.now()).compareTo(b.createdAt ?? DateTime.now()));
        break;
      case "A-Z":
        list.sort((a, b) => (a.que ?? "").compareTo(b.que ?? ""));
        break;
    }
    return list;
  }

  Future<void> addAnswer() async{

  }

  Future<void> fetchAnswers() async{
    // _answers = await
  }

  Future<void> deleteUser() async{

  }

  // Future<void> addVote(bool isUp){
  //
  // }
}
