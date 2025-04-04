//
//  LevelScene13.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/2/19.
//

import Foundation

let levelScene06 = LevelScene(
    id: 6,
    packageId: 0,
    name: "OHH，NO，你应该走",
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
            [.road, .departure, .empty, .road, .road, .empty, .destination, .road],      // 3
            [.empty, .empty, .empty, .road, .road, .empty, .empty, .empty],      // 4
            [.road, .road, .road, .road, .road, .road, .road, .road],      // 5
            [.road, .empty, .empty, .empty, .empty, .empty, .empty, .road],      // 6
            [.road, .road, .road, .road, .road, .road, .road, .road],      // 7
            [.empty, .empty, .empty, .road, .road, .empty, .empty, .empty],      // 8
            [.road, .road, .road, .road, .road, .road, .road, .road],      // 9
            [.road, .empty, .empty, .empty, .empty, .empty, .empty, .road],      // 10
            [.road, .empty, .road, .road, .road, .road, .empty, .road],      // 11
            [.road, .empty, .road, .road, .road, .road, .empty, .road],      // 12
            [.road, .empty, .empty, .road, .road, .empty, .empty, .road],      // 13
            [.road, .road, .road, .road, .road, .road, .road, .road]      // 14
        ],
        pathPoints: [
            CGPoint(x:  75, y: 125),  // 0
            CGPoint(x:  25, y: 125),  // 1
            CGPoint(x:  25, y:  25),  // 2
            CGPoint(x: 175, y:  25),  // 3
            CGPoint(x: 175, y: 225),  // 4
            CGPoint(x:  25, y: 225),  // 5
            CGPoint(x:  25, y: 325),  // 6
            CGPoint(x: 175, y: 325),  // 7
            CGPoint(x: 175, y: 425),  // 8
            CGPoint(x:  25, y: 425),  // 9
            CGPoint(x:  25, y: 675),  // 10
            CGPoint(x: 175, y: 675),  // 11
            CGPoint(x: 175, y: 575),  // 12
            CGPoint(x: 125, y: 575),  // 13
            CGPoint(x: 125, y: 525),  // 14
            CGPoint(x: 275, y: 525),  // 15
            CGPoint(x: 275, y: 575),  // 16
            CGPoint(x: 225, y: 575),  // 17
            CGPoint(x: 225, y: 675),  // 18
            CGPoint(x: 375, y: 675),  // 19
            CGPoint(x: 375, y: 425),  // 20
            CGPoint(x: 225, y: 425),  // 21
            CGPoint(x: 225, y: 325),  // 22
            CGPoint(x: 375, y: 325),  // 23
            CGPoint(x: 375, y: 225),  // 24
            CGPoint(x: 225, y: 225),  // 25
            CGPoint(x: 225, y:  25),  // 26
            CGPoint(x: 375, y:  25),  // 27
            CGPoint(x: 375, y: 125),  // 28
            CGPoint(x: 325, y: 125)   // 29
    ],
    wavesId: 2
)
