//
//  LevelScene12.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/2/18.
//

import Foundation

let levelScene01 = LevelScene(
    id: 1,
    packageId: 0,
    name: "转转转，菊花圆",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "有点难",
    startCoins: 20000,
    startLives: 20,
    wavecount: 60,
    isFixedRoad: true,
    cells: [
        [.departure, .road, .road, .road, .road, .road, .road, .road],
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .road],
        [.road, .road, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .empty, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .destination, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .empty, .empty, .road, .empty, .road],
        [.road, .empty, .road, .road, .road, .road, .empty, .road],
        [.road, .empty, .empty, .empty, .empty, .empty, .empty, .road],
        [.road, .road, .road, .road, .road, .road, .road, .road]
    ],
    pathPoints: [
        CGPoint(x: 25, y: 25),
        CGPoint(x: 375, y: 25),
        CGPoint(x: 375, y: 675),
        CGPoint(x: 25, y: 675),
        CGPoint(x: 25, y: 125),
        CGPoint(x: 275, y: 125),
        CGPoint(x: 275, y: 575),
        CGPoint(x: 125, y: 575),
        CGPoint(x: 125, y: 225)
    ],
    wavesId: 0
)
