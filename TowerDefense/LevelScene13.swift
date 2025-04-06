//
//  LevelScene13.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/3/19.
//

import Foundation

let levelScene13 = LevelScene(
    id: 13,
    packageId: 0,
    name: "德宝U",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "***",
    startCoins: 20000,
    startLives: 20,
    wavecount: 70,
    isFixedRoad: true,
    cells: [
        [.departure, .empty, .empty, .road, .road, .empty, .empty, .destination],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .empty, .empty, .road, .road, .empty, .empty, .road],
        [.road, .road, .road, .road, .road, .road, .road, .road]],
    pathPoints: [
        CGPoint(x:  25, y: 25),
        CGPoint(x:  25, y: 675),
        CGPoint(x: 175, y: 675),
        CGPoint(x: 175, y:  25),
        CGPoint(x: 225, y:  25),
        CGPoint(x: 225, y: 675),
        CGPoint(x: 375, y: 675),
        CGPoint(x: 375, y: 25)]
)
