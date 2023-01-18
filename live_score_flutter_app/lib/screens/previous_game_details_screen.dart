import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import '../models/game.dart';

class PreviousGameDetailsScreen extends StatefulWidget {
  Game game;
  PreviousGameDetailsScreen({required this.game});

  @override
  State<PreviousGameDetailsScreen> createState() =>
      _PreviousGameDetailsScreenState();
}

class _PreviousGameDetailsScreenState extends State<PreviousGameDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.game.gameType,
                    style:
                        const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 10.0),
                   Flexible(
                     child: Text(
                                 '${widget.game.winner} 🏆',
                                 style:
                                     const TextStyle(color:Colors.purple,fontSize: 28, fontWeight: FontWeight.w700),
                                 ),
                   ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 0.18 * size.height,
                    width: 0.35 * size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.game.team1.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 10.0),
                        Text(widget.game.score1.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40.0))
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "VS",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    height: 0.18 * size.height,
                    width: 0.35 * size.width,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.game.team2.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 10.0),
                        Text(widget.game.score2.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40.0))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ExpandableText(
                  widget.game.description,
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 1,
                  linkColor: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Highlights",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w500))),
              const SizedBox(
                height: 8,
              ),
            ]),
          ),
          Expanded(
            child: ListView(
                children: widget.game.keyMoments.reversed
                    .map((e) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            textColor: Colors.white,
                            tileColor: Color(0xDFEA3C3C),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: Text(e),
                          ),
                        ))
                    .toList()),
          ),
        ]),
      ),
    );
  }
}
