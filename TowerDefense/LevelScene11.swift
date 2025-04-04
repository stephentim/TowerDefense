//
//  LevelScene11.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/3/19.
//


import Foundation

let levelScene11 = LevelScene(
    id: 11,
    packageId: 0,
    name: "天空之门",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "地狱级",
    startCoins: 20000,
    startLives: 20,
    wavecount: 70,
    isFixedRoad: true,
    cells: [
        [.empty, .departure, .road, .road, .road, .road, .destination, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty],
        [.empty, .road, .road, .empty, .empty, .road, .road, .empty]],
    pathPoints: [
        CGPoint(x: 75, y: 25),
        CGPoint(x: 75, y: 675),
        CGPoint(x: 125, y: 675),
        CGPoint(x: 125, y: 25),
        CGPoint(x: 275, y: 25),
        CGPoint(x: 275, y: 675),
        CGPoint(x: 325, y: 675),
        CGPoint(x: 325, y: 25)],
    wavesId: 2
)
