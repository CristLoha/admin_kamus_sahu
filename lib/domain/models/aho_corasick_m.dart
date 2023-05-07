import 'dart:collection';

class TrieNode {
  // children menyimpan hubungan antara karakter dengan anak node
  final Map<String, TrieNode> children = {};
  // isEndOfWord menandakan apakah node ini merupakan akhir dari kata
  bool isEndOfWord = false;
  // output menyimpan indeks dari pola yang ditemukan pada node ini
  List<int> output = [];

  // Fungsi insert digunakan untuk memasukkan pola ke dalam trie
  TrieNode insert(String word, int patternIndex) {
    TrieNode node = this;
    // Memasukkan pola karakter demi karakter
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      node.children[char] ??= TrieNode();
      node = node.children[char]!;
    }
    node.isEndOfWord = true;
    node.output.add(patternIndex);
    return node;
  }
}

class AhoCorasick {
  // _root adalah node awal dari trie
  final TrieNode _root = TrieNode();

  // Fungsi build digunakan untuk membangun trie dan tautan kegagalan
  void build(List<String> patterns) {
    // Membangun trie dengan memasukkan setiap pola
    for (int i = 0; i < patterns.length; i++) {
      _root.insert(patterns[i], i);
    }

    // Menambahkan semua anak node dari root ke dalam antrian untuk dihubungkan ke root sebagai tautan kegagalan
    Queue<TrieNode> queue = Queue<TrieNode>();
    for (TrieNode child in _root.children.values) {
      child.output = [];
      queue.add(child);
    }

    // Membangun tautan kegagalan menggunakan BFS (Breadth-First Search)
    while (queue.isNotEmpty) {
      TrieNode current = queue.removeFirst();
      for (String char in current.children.keys) {
        TrieNode child = current.children[char]!;
        queue.add(child);
        TrieNode failure = current;

        // Menemukan tautan kegagalan dengan mengikuti tautan output sampai root atau menemukan node dengan anak(childreen) yang cocok
        while (failure != _root && !failure.children.containsKey(char)) {
          failure = failure.output.isEmpty
              ? _root
              : _root.children[failure.output.first]!;
        }
        if (failure.children.containsKey(char) &&
            failure.children[char] != child) {
          failure = failure.children[char]!;
        }
        child.output = failure.isEndOfWord
            ? [...failure.output, ...child.output]
            : [...failure.output];
      }
    }
  }

  // Fungsi search digunakan untuk mencari teks dengan pola menggunakan algoritma Aho-Corasick
  List<int> search(String text) {
    List<int> results = [];
    TrieNode current = _root;
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      while (current != _root && !current.children.containsKey(char)) {
        current = _root.children[current.output.first]!;
      }
      if (current.children.containsKey(char)) {
        current = current.children[char]!;
      }
      results = [...results, ...current.output.map((index) => i - index)];
    }
    return results;
  }
}
