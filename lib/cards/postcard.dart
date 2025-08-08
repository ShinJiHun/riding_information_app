import 'dart:math';

import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final int number; // ← final + non-nullable

  const PostCard({
    super.key,
    required this.number, // ← required
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  List<String> testImageList = [
    'https://images.pexels.com/photos/1973270/pexels-photo-1973270.jpeg',
    'https://images.pexels.com/photos/161709/newborn-baby-feet-basket-161709.jpeg',
    'https://images.pexels.com/photos/265987/pexels-photo-265987.jpeg',
    'https://images.pexels.com/photos/459957/pexels-photo-459957.jpeg',
    'https://images.pexels.com/photos/1648377/pexels-photo-1648377.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8JqDxQ1c8-RQTLvh_1XN5pNKYwCT5rt5TBQ&s',
                      ),
                    ),
                    SizedBox(width : 5),
                    Text('100sucoding', style: TextStyle(fontSize: 20))
                  ],
                ),
                Icon(Icons.subject),
              ],
            ),
          ),
          Container(
            height: 435,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Image.network(testImageList[Random().nextInt(5)]),
          ),
          Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.red, // 원하는 색으로
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 왼쪽 아이콘 묶음
                Row(
                  children: const [
                    Icon(Icons.favorite_border),
                    SizedBox(width: 7),
                    Icon(Icons.chat_outlined),
                    SizedBox(width: 7),
                    Icon(Icons.send),
                  ],
                ),

                // 가운데 텍스트(인디케이터)
                const Text('indic'),

                // 오른쪽 북마크
                const Icon(Icons.bookmark_border),
              ],
            ),
          ),
          Container(
            height: 20,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: Center(child: Text('좋아요 칸')),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Center(child: Text('포스트 설명 칸')),
          ),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            color: Colors.orange,
            child: Center(child: Text('댓글 칸')),
          ),
        ],
      ),
    );
  }
}
