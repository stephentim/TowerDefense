//
//  LevelScene14.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/2/19.
//


import Foundation

let levelScene09 = LevelScene(
    id: 9,
    packageId: 0,
    name: "是有两条辫子",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "**",
    startCoins: 20000,
    startLives: 20,
    wavecount: 70,
    isFixedRoad: true,
    cells: [
        [.road, .road, .road, .road, .road, .road, .road, .road],      // 1
        [.road, .empty, .road, .road, .road, .road, .empty, .road],      // 2
        [.road, .empty, .road, .empty, .empty, .road, .empty, .road],      // 3
        [.road, .departure, .road, .empty, .empty, .road, .destination, .road],      // 4
        [.empty, .empty, .road, .road, .road, .road, .empty, .empty],      // 5
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
            CGPoint(x: 175, y:  75),  // 4
            CGPoint(x: 125, y:  75),  // 5
            CGPoint(x: 125, y: 225),  // 6
            CGPoint(x: 175, y: 225),  // 7
            CGPoint(x: 175, y: 275),  // 8
            CGPoint(x:  25, y: 275),  // 9
            CGPoint(x:  25, y: 375),  // 10
            CGPoint(x: 175, y: 375),  // 11
            CGPoint(x: 175, y: 475),  // 12
            CGPoint(x:  25, y: 475),  // 13
            CGPoint(x:  25, y: 675),  // 14
            CGPoint(x: 175, y: 675),  // 15
            CGPoint(x: 175, y: 575),  // 16
            CGPoint(x: 225, y: 575),  // 17
            CGPoint(x: 225, y: 675),  // 18
            CGPoint(x: 375, y: 675),  // 19
            CGPoint(x: 375, y: 475),  // 20
            CGPoint(x: 225, y: 475),  // 21
            CGPoint(x: 225, y: 375),  // 22
            CGPoint(x: 375, y: 375),  // 23
            CGPoint(x: 375, y: 275),  // 24
            CGPoint(x: 225, y: 275),  // 25
            CGPoint(x: 225, y: 225),  // 26
            CGPoint(x: 275, y: 225),  // 27
            CGPoint(x: 275, y:  75),  // 28
            CGPoint(x: 225, y:  75),  // 29
            CGPoint(x: 225, y:  25),  // 30
            CGPoint(x: 375, y:  25),  // 31
            CGPoint(x: 375, y: 175),  // 32
            CGPoint(x: 325, y: 175)   // 33
    ]
)
