import 'dart:collection';

class TrieNode {
  // Kelas TrieNode merepresentasikan sebuah node di dalam Trie.
  final Map<String, TrieNode> children =
      {}; // Menyimpan child node dengan key berupa karakter.
  bool isEndOfWord =
      false; // Menandakan apakah suatu node merupakan akhir dari sebuah kata.
  List<int> output =
      []; // Menyimpan indeks dari kata-kata yang cocok dengan pola yang sedang dicari.

  TrieNode insert(String word) {
    // Menambahkan kata ke Trie.
    TrieNode node = this;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      node.children[char] ??=
          TrieNode(); // Jika belum ada child node dengan key char, buatlah node baru.
      node = node.children[char]!;
    }
    node.isEndOfWord = true; // Set node terakhir sebagai akhir dari kata.
    return node;
  }
}

class AhoCorasick {
  final TrieNode _root = TrieNode(); // Root dari Trie.

  void build(List<String> words) {
    // Membangun Trie dan failure links.
    for (String word in words) {
      _root.insert(word); // Menambahkan kata ke Trie.
    }

    // Memasukkan semua child node dari root ke queue untuk dihubungkan dengan root sebagai failure link.
    Queue<TrieNode> queue = Queue<TrieNode>();
    for (TrieNode child in _root.children.values) {
      child.output = [
        _root.children.length - 1
      ]; // Set output child node sebagai indeks root - 1.
      queue.add(child);
    }

    // Membangun failure links menggunakan BFS.
    while (queue.isNotEmpty) {
      TrieNode current = queue.removeFirst(); // Ambil node dari queue.
      for (String char in current.children.keys) {
        TrieNode child = current.children[char]!;
        queue.add(child); // Tambahkan child node ke queue.
        TrieNode failure =
            current; // Inisialisasi failure dengan node saat ini.
        // Cari failure link dengan mengikuti output link sampai root atau menemukan node dengan child yang cocok.
        while (failure != _root && !failure.children.containsKey(char)) {
          failure = failure.output.isEmpty
              ? _root // Jika output kosong, set failure sebagai root.
              : _root.children[failure.output.first]!;
        }
        if (failure.children.containsKey(char) &&
            failure.children[char] != child) {
          failure = failure.children[
              char]!; // Jika node dengan child cocok ditemukan, set failure sebagai node tersebut.
        }
        child.output = failure.isEndOfWord
            ? [
                ...failure.output,
                failure.children.length - 1
              ] // Jika node failure adalah akhir dari kata, tambahkan indeks ke output.
            : [
                ...failure.output
              ]; // Jika bukan, tambahkan output node failure ke output child node saat ini.
      }
    }
  }

  List<int> search(String text) {
    List<int> results =
        []; // Menyimpan indeks kata-kata yang cocok dengan pola yang sedang dicari.
    TrieNode current = _root;
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      // Traversal Trie sampai menemukan node dengan child yang cocok atau kembali ke root
      while (current != _root && !current.children.containsKey(char)) {
        // Melintasi tautan kegagalan sampai ditemukan anak yang cocok atau sampai mencapai akar trie.
        current = _root.children[current.output.first]!;
      }
      if (current.children.containsKey(char)) {
        //Mengikuti (child) yang sesuai jika ada
        current = current.children[char]!;
      }
      // Add any output of the current node to the results

      results = [...results, ...current.output.map((index) => i - index)];
    }
    return results;
  }
}
