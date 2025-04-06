//
//  LevelScene14.swift
//  TowerDefense
//
//  Created by Stephen Tim on 2025/4/6.
//

import Foundation

let levelScene14 = LevelScene(
    id: 14,
    packageId: 0,
    name: "凯旋门",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "***",
    startCoins: 20000,
    startLives: 20,
    wavecount: 70,
    isFixedRoad: true,
    cells: [
        [.departure, .road, .road, .road, .road, .road, .road, .destination],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road],
        [.road, .road, .empty, .empty, .empty, .empty, .road, .road]],
    pathPoints: [
        CGPoint(x:  25, y: 25),
        CGPoint(x:  25, y: 675),
        CGPoint(x:  75, y: 675),
        CGPoint(x:  75, y:  25),
        CGPoint(x: 325, y:  25),
        CGPoint(x: 325, y: 675),
        CGPoint(x: 375, y: 675),
        CGPoint(x: 375, y:  25)]
)
