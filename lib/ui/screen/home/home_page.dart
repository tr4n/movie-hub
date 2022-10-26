import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:moviehub/ui/components/top_movie_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _buildTop5(),
        ],
      ),
    );
  }

  Widget _buildTop5() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [1, 2, 3, 4, 5].map((e) => Top5MovieWidget(e, "")).toList(),
      ),
    );
  }
}
