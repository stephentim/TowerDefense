//
//  LevelScene12.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/3/19.
//

import Foundation

let levelScene12 = LevelScene(
    id: 12,
    packageId: 0,
    name: "我C",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "***",
    startCoins: 20000,
    startLives: 20,
    wavecount: 70,
    isFixedRoad: true,
    cells: [
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
        [.empty, .empty, .road, .road, .road, .road, .empty, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .empty, .empty, .empty, .empty, .road, .empty],
        [.empty, .road, .empty, .empty, .empty, .empty, .road, .empty],
        [.empty, .road, .empty, .empty, .empty, .empty, .road, .empty],
        [.empty, .road, .empty, .empty, .empty, .empty, .departure, .empty],
        [.empty, .road, .empty, .empty, .empty, .empty, .destination, .empty],
        [.empty, .road, .empty, .empty, .empty, .empty, .road, .empty],
        [.empty, .road, .empty, .empty, .empty, .empty, .road, .empty],
        [.empty, .road, .empty, .empty, .empty, .empty, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .empty, .road, .road, .road, .road, .empty, .empty],
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]],
    pathPoints: [
        CGPoint(x: 325, y:325),
        CGPoint(x: 325, y: 125),
        CGPoint(x: 275, y: 125),
        CGPoint(x: 275, y:  75),
        CGPoint(x: 125, y:  75),
        CGPoint(x: 125, y: 125),
        CGPoint(x:  75, y: 125),
        CGPoint(x:  75, y: 575),
        CGPoint(x: 125, y: 575),
        CGPoint(x: 125, y: 625),
        CGPoint(x: 275, y: 625),
        CGPoint(x: 275, y: 575),
        CGPoint(x: 325, y: 575),
        CGPoint(x: 325, y: 375)]
)
