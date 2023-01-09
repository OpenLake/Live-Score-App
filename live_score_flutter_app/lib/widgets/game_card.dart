import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/game.dart';

class GameCard extends StatelessWidget {
  Game game;
  VoidCallback? onPressed;
  bool isAdminCard;
  bool isPreviousCard;
  GameCard(
      {required this.game,
      this.onPressed,
      this.isAdminCard = false,
      this.isPreviousCard = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        height: 230,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.0,
              spreadRadius: 1.0,
            )
          ],
          color: Colors.amberAccent,
        ),
        width: size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height:110,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0)),
                            color: Colors.blue,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                 textAlign:TextAlign.center,
                                 TextSpan(children:[TextSpan(text:game.winner == game.team1 ? "🏆 ":""),TextSpan(text: game.team1)]),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              const SizedBox(height: 10.0),
                              Text(game.score1.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 110,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15.0)),
                              color: Colors.green),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                              textAlign:TextAlign.center,
                              TextSpan(children:[TextSpan(text:game.winner == game.team2 ? "🏆 ":""),TextSpan(text: game.team2)]),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              const SizedBox(height: 10.0),
                              Text(game.score2.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(game.college,
                                  style: const TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700)),
                              isAdminCard
                                  ? const Text("")
                                  : Text("Created By : ${game.creatorName}"),
                              const SizedBox(height: 20.0),
                              Text(
                                  DateFormat('dd MMMM yyyy \nkk:mm')
                                      .format(DateTime.parse(game.createdOn)),
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 10.0)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                  game.gameType
                                      .substring(game.gameType.length - 2),
                                  style: const TextStyle(fontSize: 50.0)),
                              const SizedBox(height: 10.0),
                              Text(game.gameType),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}


// Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 6),
//                       alignment: Alignment.center,
//                       height: 25,
//                       decoration: const BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0))),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Creator: ${game.creatorName}',
//                             overflow: TextOverflow.fade,
//                             softWrap: false,
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             'College: ${game.college}',
//                             overflow: TextOverflow.fade,
//                             softWrap: false,
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(children: [
//                   Container(
//                     alignment: Alignment.center,
//                     child: Text(
//                       game.gameType,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12.0),
//                         decoration: BoxDecoration(
//                           color:Colors.blue,
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Column(
//                           children: [
//                             Text(game.team1,style:const TextStyle(color:Colors.white)),
//                             const SizedBox(height: 8),
//                             Text(game.score1.toString(),style:const TextStyle(color:Colors.white))
//                           ],
//                         ),
//                       ),
//                    Container(
//                         padding: const EdgeInsets.all(12.0),
//                         decoration: BoxDecoration(
//                           color:Colors.green,
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Column(
//                           children: [
//                             Text(game.team2,style:const TextStyle(color:Colors.white)),
//                             const SizedBox(height: 8),
//                             Text(game.score2.toString(),style:const TextStyle(color:Colors.white))
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 15.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       isPreviousCard ? Text("Winner : ${game.winner}") : const Text(""),
//                       Text(
//                         DateFormat('dd MMMM yyyy \n kk:mm')
//                             .format(DateTime.parse(game.createdOn)),
//                         textAlign: TextAlign.end,
//                         style: TextStyle(
//                             fontSize: 12, color: Colors.black.withOpacity(0.6)),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height:10.0),
//                 ]),
//               ),
//             ]),
//       ),
//     );
//   }
// }

