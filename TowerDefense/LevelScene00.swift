//
//  LevelScene.swift
//  TowerDefense
//
//  Created by Stephen Tim on 2025/2/16.
//

import Foundation

let levelScene00 = LevelScene(
    id: 0,
    packageId: 0,
    name: "八爪鱼？两爪鱼！",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "*",
    startCoins: 20000,
    startLives: 20,
    wavecount: 70,
    isFixedRoad: true,
    cells: [
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
        [.empty, .departure, .road, .road, .road, .road, .road, .empty],
        [.empty, .empty, .empty, .empty, .empty, .empty, .road, .empty],
        [.empty, .road, .road, .road, .road, .empty, .road, .empty],
        [.empty, .road, .empty, .empty, .road, .empty, .road, .empty],
        [.empty, .road, .empty, .empty, .road, .empty, .road, .empty],
        [.empty, .road, .empty, .empty, .road, .road, .road, .empty],
        [.empty, .road, .empty, .empty, .empty, .empty, .empty, .empty],
        [.empty, .road, .empty, .empty, .road, .road, .road, .empty],
        [.empty, .road, .empty, .empty, .road, .empty, .road, .empty],
        [.empty, .road, .empty, .empty, .road, .empty, .road, .empty],
        [.empty, .road, .road, .road, .road, .empty, .road, .empty],
        [.empty, .empty, .empty, .empty, .empty, .empty, .road, .empty],
        [.empty, .destination, .road, .road, .road, .road, .road, .empty]
    ],
    pathPoints: [
        CGPoint(x: 75, y: 75),
        CGPoint(x: 325, y: 75),
        CGPoint(x: 325, y: 325),
        CGPoint(x: 225, y: 325),
        CGPoint(x: 225, y: 175),
        CGPoint(x: 75, y: 175),
        CGPoint(x: 75, y: 575),
        CGPoint(x: 225, y: 575),
        CGPoint(x: 225, y: 425),
        CGPoint(x: 325, y: 425),
        CGPoint(x: 325, y: 675),
        CGPoint(x: 75, y: 675)
    ]
)
