library packagebaru;

class GlobalState {
  List<int> counters = [];

  // untuk tambahkan counter ke dalam list counters
  void addCounter() {
    counters.add(0);
  }

  // untuk menghapus counter dari list counters berdasarkan index
  void removeCounter(int index) {
    counters.removeAt(index);
  }

  // untuk menambahkan nilai counter pada index tertentu
  void incrementCounter(int index) {
    counters[index]++;
  }

  // untuk mengurangi nilai counter pada index tertentu
  void decrementCounter(int index) {
    if (counters[index] > 0) {
      counters[index]--;
    }
  }
}

