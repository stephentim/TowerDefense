//
//  LevelScene13.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/2/19.
//

import Foundation

let levelScene02 = LevelScene(
    id: 2,
    packageId: 0,
    name: "人生无常，先玩小肠",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "*",
    startCoins: 20000,
    startLives: 20,
    wavecount: 70,
    isFixedRoad: true,
    cells: [
        [.departure, .road, .road, .road, .road, .road, .road, .road],
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .road],
        [.road, .road, .road, .road, .road, .road, .road, .road],
        [.road, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
        [.road, .road, .road, .road, .road, .road, .road, .road],
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .road],
        [.road, .road, .road, .road, .road, .road, .road, .road],
        [.road, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
        [.road, .road, .road, .road, .road, .road, .road, .road],
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .road],
        [.road, .road, .road, .road, .road, .road, .road, .road],
        [.road, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
        [.road, .road, .road, .road, .road, .road, .road, .road],
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .destination]
    ],
    pathPoints: [
        CGPoint(x: 25, y: 25),
        CGPoint(x: 375, y: 25),
        CGPoint(x: 375, y: 125),
        CGPoint(x: 25, y: 125),
        CGPoint(x: 25, y: 225),
        CGPoint(x: 375, y: 225),
        CGPoint(x: 375, y: 325),
        CGPoint(x: 25, y: 325),
        CGPoint(x: 25, y: 425),
        CGPoint(x: 375, y: 425),
        CGPoint(x: 375, y: 525),
        CGPoint(x: 25, y: 525),
        CGPoint(x: 25, y: 625),
        CGPoint(x: 375, y: 625),
        CGPoint(x: 375, y: 675)
    ]
)
