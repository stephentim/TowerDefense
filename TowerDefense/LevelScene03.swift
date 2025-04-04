//
//  LevelScene14.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/2/19.
//


import Foundation

let levelScene03 = LevelScene(
    id: 3,
    packageId: 0,
    name: "人生无常，大肠包小肠",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "容易",
    startCoins: 20000,
    startLives: 10,
    wavecount: 60,
    isFixedRoad: true,
    cells: [
        [.road, .road, .road, .road, .road, .road, .road, .road],
        [.road, .empty, .empty, .empty, .empty, .empty, .empty, .road],
        [.road, .empty, .departure, .empty, .empty, .empty, .empty, .road],
        [.road, .empty, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .empty, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .road, .empty, .empty, .empty, .empty, .road],
        [.road, .empty, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .empty, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .road, .empty, .empty, .empty, .empty, .road],
        [.road, .road, .road, .empty, .road, .road, .road, .road],
        [.empty, .empty, .empty, .empty, .road, .empty, .empty, .empty],
        [.empty, .empty, .empty, .empty, .destination, .empty, .empty, .empty]
    ],
    pathPoints: [
        CGPoint(x: 125, y: 125),
        CGPoint(x: 125, y: 175),
        CGPoint(x: 275, y: 175),
        CGPoint(x: 275, y: 275),
        CGPoint(x: 125, y: 275),
        CGPoint(x: 125, y: 375),
        CGPoint(x: 275, y: 375),
        CGPoint(x: 275, y: 475),
        CGPoint(x: 125, y: 475),
        CGPoint(x: 125, y: 575),
        CGPoint(x: 25, y: 575),
        CGPoint(x: 25, y: 25),
        CGPoint(x: 375, y: 25),
        CGPoint(x: 375, y: 575),
        CGPoint(x: 225, y: 575),
        CGPoint(x: 225, y: 675)
    ],
    wavesId: 1
)
