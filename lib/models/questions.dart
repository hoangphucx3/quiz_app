
class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.answer,
      required this.question,
      required this.options});
}

//demo data

const List demoData = [
  {
    'id': 1,
    'question': 'Con đường dài nhất là đường nào ?',
    'options': ['Đường Quốc lộ', 'Đường mòn HCM', 'Đường đời', 'Đường cao tốc'],
    'answer': 3,
  },
  {
    'id': 2,
    'question': 'Cái gì đen khi bạn mua nó, đỏ khi dùng nó và xám xịt khi vứt nó đi ?',
    'options': ['Than', 'Quần áo', 'Bật lửa', 'Vé số'],
    'answer': 1,
  },
  {
    'id': 3,
    'question': 'Con gì đập thì sống, không đập thì chết ?',
    'options': ['Con cá mập', 'Con cua', 'Con cá lóc', 'Con tim'],
    'answer': 4,
  },
  {
    'id': 4,
    'question': 'Từ gì mà 100% nguời dân Việt Nam đều phát âm sai ?',
    'options': ['Nghiêng', 'Khéo', 'Sai', 'Ngã'],
    'answer': 3,
  },
  {
    'id': 5,
    'question': 'Cái gì tay trái cầm được còn tay phải cầm không được ?',
    'options': ['Bút', 'Tay phải', 'Bát cơm', 'Dĩa'],
    'answer': 2,
  },
];
