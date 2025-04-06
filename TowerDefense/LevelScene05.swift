//
//  LevelScene12.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/2/18.
//

import Foundation

let levelScene05 = LevelScene(
    id: 5,
    packageId: 0,
    name: "北京保卫战",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "***",
    startCoins: 20000,
    startLives: 20,
    wavecount: 70,
    isFixedRoad: true,
    cells: [
        [.departure, .empty, .road, .road, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .empty, .road, .road],
        [.road, .empty, .road, .empty, .road, .destination, .road, .road],
        [.road, .road, .road, .empty, .road, .road, .road, .road]],
    pathPoints: [
        CGPoint(x: 25, y: 25),
        CGPoint(x: 25, y: 675),
        CGPoint(x: 125, y: 675),
        CGPoint(x: 125, y: 25),
        CGPoint(x: 225, y: 25),
        CGPoint(x: 225, y: 675),
        CGPoint(x: 375, y: 675),
        CGPoint(x: 375, y: 25),
        CGPoint(x: 325, y: 25),
        CGPoint(x: 325, y: 625),
        CGPoint(x: 275, y: 625)]
)
