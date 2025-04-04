//
//  LevelScene14.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/2/19.
//


import Foundation

let levelScene07 = LevelScene(
    id: 7,
    packageId: 0,
    name: "OHH，NO，你不该来",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "容易",
    startCoins: 20000,
    startLives: 10,
    wavecount: 60,
    isFixedRoad: true,
    cells: [
        [.road, .road, .road, .road, .road, .road, .road, .road],      // 1
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],      // 2
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],      // 3
        [.road, .departure, .empty, .road, .road, .empty, .destination, .road],      // 4
        [.empty, .empty, .empty, .road, .road, .empty, .empty, .empty],      // 5
        [.road, .road, .road, .road, .road, .road, .road, .road],      // 6
        [.road, .empty, .empty, .empty, .empty, .empty, .empty, .road],      // 7
        [.road, .road, .road, .road, .road, .road, .road, .road],      // 8
        [.empty, .empty, .empty, .road, .road, .empty, .empty, .empty],      // 9
        [.road, .road, .road, .road, .road, .road, .road, .road],      // 10
        [.road, .empty, .empty, .empty, .empty, .empty, .empty, .road],      // 11
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],      // 12
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],      // 13
        [.road, .road, .road, .road, .road, .road, .road, .road]      // 14
    ],
    pathPoints: [
        CGPoint(x:  75, y: 175),  // 0
        CGPoint(x:  25, y: 175),  // 1
        CGPoint(x:  25, y:  25),  // 2
        CGPoint(x: 175, y:  25),  // 3
        CGPoint(x: 175, y: 275),  // 4
        CGPoint(x:  25, y: 275),  // 5
        CGPoint(x:  25, y: 375),  // 6
        CGPoint(x: 175, y: 375),  // 7
        CGPoint(x: 175, y: 475),  // 8
        CGPoint(x:  25, y: 475),  // 9
        CGPoint(x:  25, y: 675),  // 10
        CGPoint(x: 175, y: 675),  // 11
        CGPoint(x: 175, y: 575),  // 12
        CGPoint(x: 225, y: 575),  // 13
        CGPoint(x: 225, y: 675),  // 14
        CGPoint(x: 375, y: 675),  // 15
        CGPoint(x: 375, y: 475),  // 16
        CGPoint(x: 225, y: 475),  // 17
        CGPoint(x: 225, y: 375),  // 18
        CGPoint(x: 375, y: 375),  // 19
        CGPoint(x: 375, y: 275),  // 20
        CGPoint(x: 225, y: 275),  // 21
        CGPoint(x: 225, y:  25),  // 22
        CGPoint(x: 375, y:  25),  // 23
        CGPoint(x: 375, y: 175),  // 24
        CGPoint(x: 325, y: 175)   // 25
    ],
    wavesId: 2
)
