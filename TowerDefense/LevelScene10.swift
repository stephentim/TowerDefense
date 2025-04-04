//
//  LevelScene10.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/3/17.
//
import Foundation

let levelScene10 = LevelScene(
    id: 10,
    packageId: 0,
    name: "近在咫尺",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "容易",
    startCoins: 20000,
    startLives: 10,
    wavecount: 60,
    isFixedRoad: true,
    cells: [
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],      // 1
        [.empty, .empty, .road, .road, .road, .road, .empty, .empty],      // 2
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 3
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 4
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 5
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 6
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 7
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 8
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 9
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 10
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 11
        [.empty, .empty, .road, .empty, .empty, .road, .empty, .empty],      // 12
        [.empty, .empty, .road, .road, .road, .road, .empty, .empty],      // 13
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]      // 14
        ],
        pathPoints: [
            CGPoint(x: 175, y: 75),  // 0
            CGPoint(x: 125, y: 75),  // 1
            CGPoint(x: 125, y: 625),  // 2
            CGPoint(x: 275, y: 625),  // 3
            CGPoint(x: 275, y:  75),  // 4
            CGPoint(x: 225, y:  75)],  // 5
    wavesId: 0
)
