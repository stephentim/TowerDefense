//
//  LevelScene15.swift
//  TowerDefense
//
//  Created by Stephen Tim on 2025/4/6.
//
import Foundation

let levelScene15 = LevelScene(
    id: 15,
    packageId: 0,
    name: "天空小门",
    designer: "史提芬",
    isUnlocked: true,
    difficulty: "***",
    startCoins: 20000,
    startLives: 20,
    wavecount: 70,
    isFixedRoad: true,
    cells: [
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
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
        [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]],
    pathPoints: [
        CGPoint(x: 75, y: 75),
        CGPoint(x: 75, y: 625),
        CGPoint(x: 125, y: 625),
        CGPoint(x: 125, y: 75),
        CGPoint(x: 275, y: 75),
        CGPoint(x: 275, y: 625),
        CGPoint(x: 325, y: 625),
        CGPoint(x: 325, y: 75)]
)
