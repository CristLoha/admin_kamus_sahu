import 'dart:collection';

class TrieNode {
  final Map<String, TrieNode> children = {};
  bool isEndOfWord = false;
  List<int> output = [];

  TrieNode insert(String word) {
    TrieNode node = this;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      node.children[char] ??= TrieNode();
      node = node.children[char]!;
    }
    node.isEndOfWord = true;
    return node;
  }
}

class AhoCorasick {
  final TrieNode _root = TrieNode();

  void build(List<String> patterns) {
    // Build the Trie and failure links.
    for (String pattern in patterns) {
      _root.insert(pattern);
    }

    // Add all child nodes of the root to the queue to be linked to the root as failure links.
    Queue<TrieNode> queue = Queue<TrieNode>();
    for (TrieNode child in _root.children.values) {
      child.output = [_root.children.length - 1];
      queue.add(child);
    }

    // Build failure links using BFS.
    while (queue.isNotEmpty) {
      TrieNode current = queue.removeFirst();
      for (String char in current.children.keys) {
        TrieNode child = current.children[char]!;
        queue.add(child);
        TrieNode failure = current;
        // Find failure link by following output link until root or finding a node with a matching child.
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
            ? [...failure.output, failure.children.length - 1]
            : [...failure.output];
      }
    }
  }

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
