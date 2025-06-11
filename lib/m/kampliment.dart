// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Kampliment {
  final int id;
  final KamplimentType kampType;
  final String kampliment;
  final String toWho;
  final int cardIndex;

  const Kampliment({
    required this.id,
    required this.kampType,
    required this.kampliment,
    required this.toWho,
    required this.cardIndex,
  });

  Kampliment copyWith({
    int? id,
    KamplimentType? kampType,
    String? kampliment,
    String? toWho,
    int? cardIndex,
  }) {
    return Kampliment(
      id: id ?? this.id,
      kampType: kampType ?? this.kampType,
      kampliment: kampliment ?? this.kampliment,
      toWho: toWho ?? this.toWho,
      cardIndex: cardIndex ?? this.cardIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'kampType': kampType.index,
      'kampliment': kampliment,
      'toWho': toWho,
      'cardIndex': cardIndex,
    };
  }

  factory Kampliment.fromMap(Map<String, dynamic> map) {
    return Kampliment(
      id: map['id'] as int,
      kampType: KamplimentType.values[map['kampType'] as int],
      kampliment: map['kampliment'] as String,
      toWho: map['toWho'] as String,
      cardIndex: map['cardIndex'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kampliment.fromJson(String source) =>
      Kampliment.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum KamplimentType {
  me('Me'),
  friends('Friends'),
  loved('Loved');

  const KamplimentType(this.name);

  final String name;

  String get image {
    switch (this) {
      case KamplimentType.me:
        return 'assets/images/me.png';
      case KamplimentType.friends:
        return 'assets/images/friends.png';
      case KamplimentType.loved:
        return 'assets/images/loved.png';
    }
  }
}

class KamplimentData {
  static const Map<KamplimentType, List<String>> compliments = {
    KamplimentType.me: [
      "You're doing an amazing job at being yourself",
      "Your resilience is truly inspiring",
      "You have such a beautiful soul",
      "Your creativity knows no bounds",
      "You make the world a better place",
      "Your strength is remarkable",
      "You're capable of amazing things",
    ],
    KamplimentType.friends: [
      "You're such a great friend",
      "Your friendship means the world to me",
      "You always know how to make me smile",
      "You're the kind of friend everyone wishes they had",
      "Your support means everything",
      "You bring so much joy to those around you",
      "Your kindness is contagious",
    ],
    KamplimentType.loved: [
      "You mean everything to me",
      "My world is brighter with you in it",
      "You're my favorite person",
      "Your love makes me a better person",
      "You're the best thing that's ever happened to me",
      "Every moment with you is precious",
      "You're my greatest adventure",
    ],
  };

  static List<String> getComplimentsForType(KamplimentType type) {
    return compliments[type] ?? [];
  }
}

List<String> containerImages = [
  'assets/images/0.png',
  'assets/images/1.png',
  'assets/images/2.png',
  'assets/images/3.png',
];
