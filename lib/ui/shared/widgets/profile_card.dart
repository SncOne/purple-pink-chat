import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    List<Container> cards = [
      Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: const Text('1'),
      ),
      Container(
        alignment: Alignment.center,
        color: Colors.red,
        child: const Text('2'),
      ),
      Container(
        alignment: Alignment.center,
        color: Colors.purple,
        child: const Text('3'),
      )
    ];
    return Flexible(
      child: CardSwiper(
        cardsCount: cards.length,
        cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
            cards[index],
      ),
    );
  }
}
