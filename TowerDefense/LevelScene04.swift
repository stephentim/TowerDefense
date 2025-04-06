//
//  LevelScene.swift
//  TowerDefense
//
//  Created by Stephen Tim on 2025/2/16.
//

import Foundation

let levelScene04 = LevelScene(
    id: 4,
    packageId: 0,
    name: "人生无常，宰相肚子跑高速",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "**",
    startCoins: 20000,
    startLives: 20,
    wavecount: 70,
    isFixedRoad: true,
    cells: [
        [.road, .road, .road, .road, .road, .road, .road, .road],
        [.road, .empty, .empty, .empty, .empty, .empty, .empty, .road],
        [.road, .empty, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .empty, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .road, .empty, .empty, .empty, .empty, .road],
        [.road, .empty, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .empty, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .road, .empty, .empty, .empty, .empty, .road],
        [.road, .empty, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .empty, .empty, .empty, .road, .empty, .road],
        [.road, .road, .road, .road, .road, .road, .empty, .road],
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .road]
    ],
    pathPoints: [
        CGPoint(x: 125, y: 125),
        CGPoint(x: 275, y: 125),
        CGPoint(x: 275, y: 225),
        CGPoint(x: 125, y: 225),
        CGPoint(x: 125, y: 325),
        CGPoint(x: 275, y: 325),
        CGPoint(x: 275, y: 425),
        CGPoint(x: 125, y: 425),
        CGPoint(x: 125, y: 525),
        CGPoint(x: 275, y: 525),
        CGPoint(x: 275, y: 625),
        CGPoint(x: 25, y: 625),
        CGPoint(x: 25, y: 25),
        CGPoint(x: 375, y: 25),
        CGPoint(x: 375, y: 675)
    ]
)
