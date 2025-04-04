//
//  LevelScene14.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/2/19.
//


import Foundation

let levelScene08 = LevelScene(
    id: 8,
    packageId: 0,
    name: "123木头人",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "容易",
    startCoins: 20000,
    startLives: 10,
    wavecount: 60,
    isFixedRoad: true,
    cells: [
        [.road, .road, .road, .road, .road, .road, .road, .road],      // 1
        [.road, .empty, .road, .road, .road, .road, .empty, .road],      // 2
        [.road, .empty, .road, .empty, .empty, .road, .empty, .road],      // 3
        [.road, .departure, .road, .empty, .empty, .road, .destination, .road],      // 4
        [.road, .road, .road, .road, .road, .road, .road, .road],      // 5
        [.road, .road, .road, .road, .road, .road, .road, .road],      // 6
        [.road, .empty, .empty, .empty, .empty, .empty, .empty, .road],      // 7
        [.road, .road, .road, .empty, .empty, .road, .road, .road],      // 8
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 9
        [.road, .road, .road, .empty, .empty, .road, .road, .road],      // 10
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],      // 11
        [.road, .road, .empty, .road, .road, .empty, .road, .road],      // 12
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],      // 13
        [.road, .road, .road, .road, .road, .road, .road, .road]      // 14
        ],
        pathPoints: [
            CGPoint(x:  75, y: 175),  // 0
            CGPoint(x:  75, y: 225),  // 1
            CGPoint(x:  25, y: 225),  // 2
            CGPoint(x:  25, y:  25),  // 3
            CGPoint(x: 175, y:  25),  // 4
            CGPoint(x: 175, y:  75),  // 5
            CGPoint(x: 125, y:  75),  // 6
            CGPoint(x: 125, y: 225),  // 7
            CGPoint(x: 175, y: 225),  // 8
            CGPoint(x: 175, y: 275),  // 9
            CGPoint(x:  25, y: 275),  // 10
            CGPoint(x:  25, y: 375),  // 11
            CGPoint(x: 125, y: 375),  // 12
            CGPoint(x: 125, y: 475),  // 13
            CGPoint(x:  25, y: 475),  // 14
            CGPoint(x:  25, y: 525),  // 15
            CGPoint(x:  75, y: 525),  // 16
            CGPoint(x:  75, y: 575),  // 17
            CGPoint(x:  25, y: 575),  // 18
            CGPoint(x:  25, y: 675),  // 19
            CGPoint(x: 175, y: 675),  // 20
            CGPoint(x: 175, y: 575),  // 21
            CGPoint(x: 225, y: 575),  // 22
            CGPoint(x: 225, y: 675),  // 23
            CGPoint(x: 375, y: 675),  // 24
            CGPoint(x: 375, y: 575),  // 25
            CGPoint(x: 325, y: 575),  // 26
            CGPoint(x: 325, y: 525),  // 27
            CGPoint(x: 375, y: 525),  // 28
            CGPoint(x: 375, y: 475),  // 29
            CGPoint(x: 275, y: 475),  // 30
            CGPoint(x: 275, y: 375),  // 31
            CGPoint(x: 375, y: 375),  // 32
            CGPoint(x: 375, y: 275),  // 33
            CGPoint(x: 225, y: 275),  // 34
            CGPoint(x: 225, y: 225),  // 35
            CGPoint(x: 275, y: 225),  // 36
            CGPoint(x: 275, y:  75),  // 37
            CGPoint(x: 225, y:  75),  // 38
            CGPoint(x: 225, y:  25),  // 39
            CGPoint(x: 375, y:  25),  // 40
            CGPoint(x: 375, y: 225),  // 41
            CGPoint(x: 325, y: 225),  // 42
            CGPoint(x: 325, y: 175)   // 43
    ],
    wavesId: 2
)
