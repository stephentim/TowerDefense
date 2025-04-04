//
//  ContentView.swift
//  TowerDefense9
//
//  Created by Stephen Tim on 2025/2/15.
//

import SwiftUI
import Combine
import AudioToolbox
import CoreGraphics

// MARK: - 数据模型
// 怪兽类型
enum MonsterType: String {
    case snail = "🐌"      // 蜗牛
    case spider = "🕷️"     // 蜘蛛
    case crab = "🦀"       // 螃蟹
    case alien = "👽"      // 外星人
    case ghost = "👻"      // 鬼
    case pumpkin = "🎃"    // 南瓜灯
    case dung = "💩"       // 屎
    case eyes = "👀"       // 眼睛
    case pig = "🐖"        // 猪
    case elephant = "🦣"   // 大象
    case devil = "😈"      // 小恶魔
    
    var health: Double {
        switch self {
        case .snail:    return 50          // 蜗牛
        case .spider:   return 10          // 蜘蛛
        case .crab:     return 100         // 螃蟹
        case .alien:    return 200         // 外星人
        case .ghost:    return 20          // 鬼
        case .pumpkin:  return 300         // 南瓜灯
        case .dung:     return 400         // 屎
        case .eyes:     return 500         // 眼睛
        case .pig:      return 600         // 猪
        case .elephant: return 800         // 大象
        case .devil:    return 1200        // 小恶魔
        }
    }
    var speed: CGFloat {
        switch self {
        case .snail:    return 1         // 蜗牛
        case .spider:   return 8         // 蜘蛛
        case .crab:     return 2         // 螃蟹
        case .alien:    return 9         // 外星人
        case .ghost:    return 10        // 鬼
        case .pumpkin:  return 7         // 南瓜灯
        case .dung:     return 3         // 屎
        case .eyes:     return 4         // 眼睛
        case .pig:      return 5         // 猪
        case .elephant: return 6         // 大象
        case .devil:    return 5         // 小恶魔
        }
    }
//    var description: String {
//        switch self {
//        case .snail:    return "🐌"         // 蜗牛
//        case .spider:   return "🕷️"         // 蜘蛛
//        case .crab:     return "🦀"         // 螃蟹
//        case .alien:    return "👽"         // 外星人
//        case .ghost:    return "👻"         // 鬼
//        case .pumpkin:  return "🎃"         // 南瓜灯
//        case .dung:     return "💩"         // 屎
//        case .eyes:     return "👀"         // 眼睛
//        case .pig:      return "🐖"         // 猪
//        case .elephant: return "🦣"         // 大象
//        case .devil:    return "😈"         // 小恶魔
//        }
//    }
}

// 炮塔类型
enum TowerType: String, CaseIterable {
    case blaster = "爆能枪"
    case freezer = "寒冰塔"
    case laser = "激爆塔"
    case magnetic = "磁爆塔"
    case magic = "魔法塔"
    case bank = "银保证"
    
    var description: String {
        return rawValue
    }
    var cost: Int {
        switch self {
        case .blaster:
            return 100
        case .freezer:
            return 200
        case .laser:
            return 300
        case .magnetic:
            return 400
        case .magic:
            return 500
        case .bank:
            return 1000
        }
    }
    var color: Color {
        switch self {
        case .blaster:
            return .green
        case .freezer:
            return .cyan
        case .laser:
            return .orange
        case .magnetic:
            return .purple
        case .magic:
            return .brown
        case .bank:
            return .pink
        }
    }
}

// 地形
enum CellState {
    case empty       // 空地
    case tower       // 已建有炮塔
    case departure   // 出发地
    case road        // 路
    case destination // 目的地
    case barricade   // 路障
}

// 游戏状态
enum GameState {
    case waitingToStart  // 等待开始
    case running         // 游戏中
    case pause           // 暂停
    case gameOver        // 游戏结束
}

struct Position {
    let row: Int
    let col: Int
}

struct Wave {
    let MonsterCode: [MonsterCode]    // 类型, 级别
}

struct Waves {
    let waves: [Wave]                 // 敌人的波次配置
}
struct MonsterCode {
    let type: MonsterType      // 类型
    let level: Int             // 级别
}

// MARK: - 这里更改用哪个地图
let sampleScene = [levelScene00, levelScene01, levelScene02, levelScene03, levelScene04, levelScene05, levelScene06, levelScene07, levelScene08, levelScene09, levelScene10, levelScene11, levelScene12, levelScene13]
let sampleWaves = [waves00, waves01, waves02]

struct GamePackage: Identifiable {
    let id: Int
    let name: String
    var isUnlocked: Bool
    let levelScenes: Int
}

// 关卡场景，包含地图，路径，每波的怪兽种类和级别，初始金额，可能还有初始预设的炮塔
struct LevelScene: Identifiable {
    let id: Int
    let packageId: Int                // 属于哪个游戏包
    let name: String                  // 关卡名字
    let designer: String              // 设计者名字
    var isUnlocked: Bool              // 锁定状态
    let difficulty: String            // 难度
    let startCoins: Int               // 初始金币
    let startLives: Int               // 初始血量
    let wavecount: Int                // 波数
    let isFixedRoad: Bool             // 怪兽是否按固定路线走
    let cells: [[CellState]]          // 二维地图数据（0=路径，1=可建造区域，2=障碍）14行8列
    let pathPoints: [CGPoint]         // 敌人移动路径的关键点
    let wavesId: Int
}

// 菜单数据模型
class GameInfoForMenuViewModel: ObservableObject {
    @Published var packages: [GamePackage] = [
        GamePackage(id: 0, name: "经典", isUnlocked: true, levelScenes: 16),
        GamePackage(id: 1, name: "黑暗森林", isUnlocked: false, levelScenes: 20),
        GamePackage(id: 2, name: "死亡沙漠", isUnlocked: false, levelScenes: 15),
        GamePackage(id: 3, name: "巨龙巢穴", isUnlocked: false, levelScenes: 50)
    ]

    @Published var selectedPackage: GamePackage?
}

// MARK: - 怪兽基类
struct Monster: Identifiable {
    let id = UUID()
    var position: CGPoint
    var type: MonsterType
    let level: Int
    var health: Double
    let fullHealth: Double
    var speed: CGFloat
    var slowdownFactor: Double = 1.0     // 一枪使目标速度下降的比例，多枪累积
    var pathIndex = 0

    init(position: CGPoint, type: MonsterType, level: Int) {
        self.position = position
        self.type = type
        self.level = level
        self.health = type.health * Double(level)
        self.fullHealth = type.health * Double(level)
        self.speed = type.speed * CGFloat(level)
    }

    mutating func move(along path: [CGPoint]) {
        guard pathIndex < path.count else { return }
        
        let target = path[pathIndex]
        let dx = target.x - position.x
        let dy = target.y - position.y
        let distance = sqrt(dx*dx + dy*dy)
        
        if distance < speed * slowdownFactor {
            position = target
            pathIndex += 1
        } else {
            position.x += dx / distance * speed * slowdownFactor
            position.y += dy / distance * speed * slowdownFactor
        }
    }
}

// MARK: - 炮塔基类模型
class Tower: ObservableObject, Identifiable {
    let id = UUID()
    var level: Int                          // 炮塔的级别，起始为1
    var type: TowerType                     // 类型
    var position: Position                  // 位置所在行列
    var center: CGPoint                     // 中心点点位置， 由初始化程序自动算出
    var rotationAngle: Double               // 炮弹的破坏能力， 起始为1
//    var topLevel: Int                       // 炮塔的最大级别，起始为5
    var damage: Double                      // 炮弹的破坏能力， 起始为1.0
    var range: CGFloat                      // 射程范围， 起始为50.0
    var upgradeIncreaseCost: Int            // 每升一级需要增加的金币， 根据不同的炮塔不同
    var value: Int                          // 身价，对这个炮塔的总支出
    var fireRate: Double                    // 开火的频率，先用两次开火的最小时间来定，级别越高，数值越低 0.25
    var lastFireTime = Date.distantPast     // 上次开会的时间
    var velocityOfBullet: Double            // 炮弹的速度，单位时间划过屏幕的长度 3.0
    var sizeOfBullet: CGFloat               // 炮弹的口径大小， 1.0
    
    init(type: TowerType, position: Position, damage: Double, range: CGFloat, fireRate: Double, velocityOfBullet: Double, sizeOfBullet: CGFloat) {
        self.level = 1
        self.type = type
        self.position = position
        self.center = CGPoint(x: position.col * 50 + 25, y: position.row * 50 + 25)
        self.rotationAngle = 0.0
//        self.topLevel = topLevel
        self.damage = damage
        self.range = range
        self.upgradeIncreaseCost = type.cost
        self.value = upgradeIncreaseCost
        self.fireRate = fireRate
        self.lastFireTime = Date()
        self.velocityOfBullet = velocityOfBullet
        self.sizeOfBullet = sizeOfBullet
    }
    
    func rotate(to target: CGPoint) {
        // TODO: 计算目标方向的角度
        let deltaX = target.x - center.x
        let deltaY = target.y - center.y
        rotationAngle = atan2(deltaY, deltaX)
    }

    // 开火
    func fire(at monsters: [Monster], bullets: inout [Bullet]) {
        // 如果间隔的时间不够 不能开火
        guard Date().timeIntervalSince(lastFireTime) > fireRate else { return }

        // 向射程内的 最残的 怪兽开火
        let targets = monsters.filter({ hypot($0.position.x - self.center.x, $0.position.y - self.center.y) < self.range })
        if targets.count >= 1 {
            if let target = targets.sorted(by: { $0.health < $1.health }).first {
                // 取得炮塔离怪兽在横坐标和纵坐标的两个分量
                let dx = target.position.x - center.x
                let dy = target.position.y - center.y
                // 子弹的速度是根据炮塔的级别定的
                // 因此在单位时间上走的距离是定的
                // 但是在横纵方向的分量是不同的
                let velocity = CGVector(dx: velocityOfBullet * dx / sqrt(dx*dx+dy*dy), dy: velocityOfBullet * dy / sqrt(dx*dx+dy*dy))

                bullets.append(Bullet(
                    position: center,
                    velocity: velocity,
                    damage: damage,  // 使用当前伤害值
                    size: sizeOfBullet,
                    color: .red
                ))
                lastFireTime = Date() // 记录这次开火的时间
            }
        }
    }
}

// 炮塔子类：爆能枪
class Blaster: Tower {
    init(position: Position) {
        // 每个种类多防御塔，基本属性在这里设置
        super.init(type: .blaster, position: position, damage: 5.0, range: 100.0, fireRate: 1.0, velocityOfBullet: 10.0, sizeOfBullet: 4.0)
    }
}

// 炮塔子类：冰冻塔
class Freezer: Tower {
    var slowdownFactor: Double     // 一枪使目标速度下降的比例，多枪累积
    var maxSlowdownFactor: Double  // 最大降速，不能把怪兽定住走不动，不同级别的能力不同，最高级别的不宜低于0.2, 0.8->0.5->0.2
    
    init(position: Position) {
        // 每个种类多防御塔，基本属性在这里设置
        self.slowdownFactor = 0.95
        self.maxSlowdownFactor = 0.85
        
        super.init(type: .freezer, position: position, damage: 1.0, range: 100.0, fireRate: 1.0, velocityOfBullet: 10.0, sizeOfBullet: 4.0)
    }
    
    override func fire(at monsters: [Monster], bullets: inout [Bullet]) {
        // 如果间隔的时间不够 不能开火
        guard Date().timeIntervalSince(lastFireTime) > fireRate else { return }

        // 向射程内的 速度最快的 怪兽开火
        let targets = monsters.filter({ hypot($0.position.x - self.center.x, $0.position.y - self.center.y) < self.range })
        if targets.count >= 1 {
            if let target = targets.sorted(by: { $0.slowdownFactor > $1.slowdownFactor }).first {
                // 找到射程内速度最快的
                // 取得炮塔离怪兽在横坐标和纵坐标的两个分量
                let dx = target.position.x - center.x
                let dy = target.position.y - center.y
                // 子弹的速度是根据炮塔的级别定的
                // 因此在单位时间上走的距离是定的
                // 但是在横纵方向的分量是不同的
                let velocity = CGVector(dx: velocityOfBullet * dx / sqrt(dx*dx+dy*dy), dy: velocityOfBullet * dy / sqrt(dx*dx+dy*dy))

                bullets.append(IceBullet(
                    position: center,
                    velocity: velocity,
                    damage: damage,  // 使用当前伤害值
                    size: sizeOfBullet,
                    slowdownFactor: slowdownFactor,
                    maxSlowdownFactor: maxSlowdownFactor
                ))
                lastFireTime = Date() // 记录这次开火的时间
            }
        }
    }
}

// 炮塔子类：激光塔
class Laser: Tower {
    init(position: Position) {
        // 每个种类多防御塔，基本属性在这里设置
        super.init(type: .laser, position: position, damage: 5.0, range: 100.0, fireRate: 1.0, velocityOfBullet: 20.0, sizeOfBullet: 4.0)
    }

    // 开火
    override func fire(at monsters: [Monster], bullets: inout [Bullet]) {
        // 如果间隔的时间不够 不能开火
        guard Date().timeIntervalSince(lastFireTime) > fireRate else { return }

        // 向射程内的第一只怪兽开火
        if let target = monsters.first(where: { hypot($0.position.x - center.x, $0.position.y - center.y) < range }) {
            // 取得炮塔离怪兽在横坐标和纵坐标的两个分量
            let dx = target.position.x - center.x
            let dy = target.position.y - center.y
            // 子弹的速度是根据炮塔的级别定的
            // 因此在单位时间上走的距离是定的
            // 但是在横纵方向的分量是不同的
            let velocity = CGVector(dx: velocityOfBullet * dx / sqrt(dx*dx+dy*dy), dy: velocityOfBullet * dy / sqrt(dx*dx+dy*dy))

            bullets.append(LaserBullet(
                position: center,
                velocity: velocity,
                damage: damage,  // 使用当前伤害值
                size: sizeOfBullet
            ))
            lastFireTime = Date() // 记录这次开火的时间
        }
    }
}

// 炮塔子类：磁能塔
class Magnetic: Tower {
    var strengthenFactor: Double     // 在攻击敌人的同时自身的攻击能力在不断增强
    var minStrengthenFactor: Double     // 在攻击敌人的同时自身的攻击能力在不断增强
//    var currentMonsterIndex: Int = -1
//    var currentMonster: Monster
    var currentMonsterId = UUID()

    init(position: Position) {
        self.strengthenFactor = 1
        self.minStrengthenFactor = 1
//        self.currentMonsterId = UUID()
        // 每个种类多防御塔，基本属性在这里设置
        super.init(type: .magnetic, position: position, damage: 1.0, range: 100.0, fireRate: 0.250, velocityOfBullet: 10.0, sizeOfBullet: 4.0)
    }

    // 攻击
    func attack(at monsters: inout [Monster], lightningBolts: inout [LightningBolt]) {
        guard Date().timeIntervalSince(lastFireTime) > fireRate else { return }

        // 逮住一个不放，直到血量为1
        if let previousMonster = monsters.filter({ hypot($0.position.x - self.center.x, $0.position.y - self.center.y) < self.range && $0.id == self.currentMonsterId && $0.health > 1 }).first {
            // 增强攻击能力且继续攻击previousMonster
            self.strengthenFactor *= 1.02
            attackAMonster(in: &monsters, at: previousMonster, lightningBolts: &lightningBolts)
        } else {
            // 换一个攻击
            // 找出射程内活跃的怪兽 选择health最高的进行攻击
            let targets = monsters.filter({ hypot($0.position.x - self.center.x, $0.position.y - self.center.y) < self.range && $0.health > 1 })
            if targets.count >= 1 {
                if let newMonster = targets.sorted(by: { $0.health > $1.health }).first {
                    self.currentMonsterId = newMonster.id
                    // 攻击newMonster
                    self.strengthenFactor = minStrengthenFactor
                    attackAMonster(in: &monsters, at: newMonster, lightningBolts: &lightningBolts)
                }
            }
        }
    }
    
    func attackAMonster(in monsters: inout [Monster], at monster: Monster, lightningBolts: inout [LightningBolt]) {
        lightningBolts.append(LightningBolt(startPoint: self.center, endPoint: monster.position, strength: self.damage * 4))
        
        for index in 0..<monsters.count {
            if monsters[index].id == monster.id {
                monsters[index].health -= self.damage * self.strengthenFactor
                if monsters[index].health <= 0 {
                    monsters[index].health = 1
                }
            }
        }
        lastFireTime = Date() // 记录这次开火的时间
    }
    // 重置开火方法
    override func fire(at monsters: [Monster], bullets: inout [Bullet]) {
        // 什么也不做
    }
}
// 炮塔子类：魔法塔
class Magic: Tower {
    var slowdownFactor: Double     // 一枪使目标速度下降的比例，多枪累积
    var maxSlowdownFactor: Double  // 最大降速，不能把怪兽定住走不动，不同级别的能力不同，最高级别的不宜低于0.2, 0.8->0.5->0.2

    init(position: Position) {
        // 每个种类多防御塔，基本属性在这里设置
        self.slowdownFactor = 0.95
        self.maxSlowdownFactor = 0.85

        // 每个种类多防御塔，基本属性在这里设置
        super.init(type: .magic, position: position, damage: 0.5, range: 75.0, fireRate: 2.0, velocityOfBullet: 1.0, sizeOfBullet: 1.0)
    }

    // 用魔法攻击
    func attack(at monsters: inout [Monster], coins: inout Int, lightningRings: inout [LightningRing], floatingTexts: inout [FloatingText]) {
        // 攻击逻辑
        // 如果间隔的时间不够 不能开火
        guard Date().timeIntervalSince(lastFireTime) > fireRate else { return }

        // 向射程内的所有怪兽开火
        for index in 0..<monsters.count {
            if hypot(monsters[index].position.x - center.x, monsters[index].position.y - center.y) < range {
                // 动画
                lightningRings.append(LightningRing(position: self.center, radius: self.range))
                // 减速
                if monsters[index].slowdownFactor > self.maxSlowdownFactor {
                    monsters[index].slowdownFactor *= self.slowdownFactor
                }
                // 掉血
                monsters[index].health -= self.damage
                // 目标死亡？ 不能打死，只能打到没血，再由其他防御塔打死
                if monsters[index].health <= 0 {
                    monsters[index].health = 1
                }
                // 增收
                // 添加金币 增加一个增减动画
                floatingTexts.append(
                    FloatingText(
                        position: monsters[index].position,
                        increment: 1
                    )
                )
                coins += 1
                AudioServicesPlaySystemSound(1004) // 音效  中磨
            }
        }
        lastFireTime = Date() // 记录这次开火的时间
    }
    // 重置开火方法
    override func fire(at monsters: [Monster], bullets: inout [Bullet]) {
        // 什么也不做
    }
}

// 炮塔子类：银行
class Bank: Tower {
    var interestRate: Double   // 利率
    init(position: Position) {
        self.interestRate = 3.0  // 每期起始3%利率
        // 每个种类多防御塔，基本属性在这里设置
        super.init(type: .bank, position: position, damage: 0.0, range: 0.0, fireRate: 1000.0, velocityOfBullet: 1.0, sizeOfBullet: 1.0)
    }

    // 重置开火方法
    override func fire(at monsters: [Monster], bullets: inout [Bullet]) {
        // 什么也不做
    }
    
    func settleInterest() {
        self.value = Int(Double(self.value) * (self.interestRate + 100) / 100)
    }
}

// 爆能枪子弹模型
class Bullet: Identifiable {
    let id = UUID()
    var position: CGPoint
    let velocity: CGVector
    let damage: Double
    let size: CGFloat
    var color: Color
    
    init(position: CGPoint, velocity: CGVector, damage: Double, size: CGFloat, color: Color) {
        self.position = position
        self.velocity = velocity
        self.damage = damage
        self.size = size
        self.color = color
    }
}

// 寒冰子弹模型
class IceBullet: Bullet {
    let slowdownFactor: Double
    let maxSlowdownFactor: Double  // 最大降速，不能把怪兽定住走不动，不同级别的能力不同，最高级别的不宜低于0.2, 0.8->0.5->0.2

    init(position: CGPoint, velocity: CGVector, damage: Double, size: CGFloat, slowdownFactor: Double, maxSlowdownFactor: Double) {
        self.slowdownFactor = slowdownFactor
        self.maxSlowdownFactor = maxSlowdownFactor
        super.init(position: position, velocity: velocity, damage: damage, size: size, color: .blue)
    }
}
// 激光子弹模型
class LaserBullet: Bullet {
    init(position: CGPoint, velocity: CGVector, damage: Double, size: CGFloat) {
        super.init(position: position, velocity: velocity, damage: damage, size: size, color: .white)
    }
}

// 金币增减动画类
class FloatingText: ObservableObject, Identifiable {
    let id = UUID()
    @Published var position: CGPoint
    let appearanceTime = Date()     // 出现的时间
    let increment: Int
    
    init(position: CGPoint, increment: Int) {
        self.position = position
        self.increment = increment
    }
}

// 闪电环效果类
class LightningRing: ObservableObject, Identifiable {
    let id = UUID()
    @Published var position: CGPoint
    @Published var radius: CGFloat

    let appearanceTime = Date()     // 出现的时间
    
    init(position: CGPoint, radius: CGFloat) {
        self.position = position
        self.radius = radius
    }
}

// 闪电效果类
class LightningBolt: ObservableObject, Identifiable {
    let id = UUID()
    @Published var startPoint: CGPoint
    @Published var endPoint: CGPoint
    @Published var strength: CGFloat

    let appearanceTime = Date()     // 出现的时间
    
    init(startPoint: CGPoint, endPoint: CGPoint, strength: CGFloat) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.strength = strength
    }
}

// MARK: - 游戏数据模型
class GameManager: ObservableObject {
    @Published var gameOverMessage                    = ""               //
    @Published var cells: [[CellState]]                                  // 地图组
    @Published var monsters: [Monster]                = []               // 怪兽组
    @Published var towers: [Tower]                    = []               // 炮塔组
    @Published var bullets: [Bullet]                  = []               // 子弹组 应用于普通炮塔的攻击
    @Published var lightningRings: [LightningRing]    = []               // 光环组 应用于魔法炮塔的攻击
    @Published var lightningBolts: [LightningBolt]    = []               // 闪电组 应用于磁能炮塔的攻击
    @Published var floatingTexts: [FloatingText]      = []               // 用动画显示增减数
    @Published var coins                              = 5000             // 起始金币
    @Published var lives                              = 10               // 命
    @Published var acceleration: Double               = 1.0              // 速度因子
    @Published var gameState: GameState               = .waitingToStart  // 游戏状态
    @Published var currentWave                        = 0                // 当前波次
    @Published var remainingMonstersOfCurrentWave     = 0                // 当前波次的未死亡怪兽数
    var pathPoints: [CGPoint]                         = []               // 路径点（简单直线路径）
    var topLevelOfTower: Int                          = 5                // 炮塔的最大级别，起始为5

    var gameTimer: Timer?
    
    private var cancellables = Set<AnyCancellable>()

    let levelScene: LevelScene
    
    init(levelScene: LevelScene) {
        self.levelScene = levelScene
        self.coins = levelScene.startCoins
        self.lives = levelScene.startLives
        self.pathPoints = levelScene.pathPoints
        self.cells = levelScene.cells

        if levelScene.isFixedRoad {
            // 按固定路线走
        } else {
            // 只有出发地和目的地
        }
    }
    
    func startWave() {
//        guard currentWave < levelScene.waves.count else { return }
        guard currentWave < sampleWaves[levelScene.wavesId].waves.count else { return }
        
//        let wave = levelScene.waves[currentWave]
        let wave = sampleWaves[levelScene.wavesId].waves[currentWave]
        
        remainingMonstersOfCurrentWave = wave.MonsterCode.count
        
        wave.MonsterCode.enumerated().forEach { index, monster in
            // 每1秒生产1个怪兽，如果想改变间隔时间在这里
            Timer.publish(every: Double(index), on: .main, in: .common)
                .autoconnect()
                .first()
                .sink { [weak self] _ in
                    self?.spawnMonster(type: monster.type, level: monster.level)
                }
                .store(in: &cancellables)
        }
        
        currentWave += 1
        
        if currentWave == 21 {
            topLevelOfTower += 1
        } else if currentWave == 41 {
            topLevelOfTower += 1
        } else if currentWave == 61 {
            topLevelOfTower += 1
        }
        
        // 看看有没有Bank
        guard towers.count > 0 else { return }
        for index in 0..<towers.count {
            if let bankTower = towers[index] as? Bank {
                // 结息
                bankTower.settleInterest()
            }
        }
    }
    
    func aMonsterDie() {
        remainingMonstersOfCurrentWave -= 1
        if remainingMonstersOfCurrentWave <= 0 {
            // 全部怪兽死光了
            if currentWave >= sampleWaves[levelScene.wavesId].waves.count {
                // 如果最后一波
                gameOverMessage = "恭喜你\n顺利通关！"
                gameState = .gameOver
            } else {
                // 开始下一波
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // 等待3秒
                    if self.monsters.count <= 0 {
                        self.startWave()
                    }
                }
            }
        }
    }

    func startGame() {
        if gameState == .waitingToStart {
            startWave()
            gameTimer = Timer.scheduledTimer(withTimeInterval: 0.064 / acceleration, repeats: true) { _ in self.updateGame() }
            gameState = .running
        } else if gameState == .pause {
            // 继续
            gameTimer = Timer.scheduledTimer(withTimeInterval: 0.064 / acceleration, repeats: true) { _ in self.updateGame() }
            gameState = .running
        } else if gameState == .gameOver {
            cells = Array(repeating: Array(repeating: .empty, count: 8), count: 14)
            
            gameTimer = Timer.scheduledTimer(withTimeInterval: 0.064 / acceleration, repeats: true) { _ in self.updateGame() }
            gameState = .running
        } else if gameState == .running {
            // 暂停
            gameTimer?.invalidate()
            gameTimer = nil
            gameState = .pause
        }
    }
    
    // 速度切换器
    func accelerator() {
        if acceleration == 1.0 {
            // 切换至2速
            acceleration = 2.0
        } else if acceleration == 2.0 {
            // 切换至4速
            acceleration = 4.0
        } else if acceleration == 4.0 {
            // 切换至0.5速
            acceleration = 0.5
        } else {
            // 切换至1速
            acceleration = 1.0
        }
        gameTimer?.invalidate()
        gameTimer = nil
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.064 / acceleration, repeats: true) { _ in self.updateGame() }
    }

    // 产生怪兽
    func spawnMonster(type: MonsterType, level: Int) {
        monsters.append(Monster(position: pathPoints[0], type: type, level: level))
        AudioServicesPlaySystemSound(1001) // 音效
    }
    
    // 不断更新游戏
    func updateGame() {
        guard self.gameState != .gameOver else { return }

        // 移动怪兽
        moveMonsters()
        
        // 炮塔开火
        for index in towers.indices {
            // 普通炮塔
            towers[index].fire(at: monsters, bullets: &bullets)
            // 魔法塔
            if let magicTower = towers[index] as? Magic {
                magicTower.attack(at: &monsters, coins: &coins, lightningRings: &lightningRings, floatingTexts: &floatingTexts)
            }
            // 磁能塔
            if let magneticTower = towers[index] as? Magnetic {
                magneticTower.attack(at: &monsters, lightningBolts: &lightningBolts)
            }
        }
        // 移动炮弹
        moveBullets()

        // 移除过时的（超过4秒）动画文字
        floatingTexts = floatingTexts.filter { Date().timeIntervalSince($0.appearanceTime) < 4.0 }
        // 移除过时的（超过4秒）闪电环
        lightningRings = lightningRings.filter { Date().timeIntervalSince($0.appearanceTime) < 4.0 }
        // 移除过时的（超过4秒）闪电链
        lightningBolts = lightningBolts.filter { Date().timeIntervalSince($0.appearanceTime) < 4.0 }
    }
    
    // 移动怪兽
    func moveMonsters() {
        // 更新怪兽位置
        // 创建临时数组进行修改
        var newMonsters = monsters
        var monsterIndexToRemove: [Int] = []
        for i in 0..<newMonsters.count {
            newMonsters[i].move(along: pathPoints)
            // 检查是否到达终点
            if newMonsters[i].pathIndex >= pathPoints.count {
                AudioServicesPlaySystemSound(1003) // 音效
                lives -= 1
                if lives <= 0 {
                    gameState = .gameOver
                    gameTimer?.invalidate()
                    gameOverMessage = "冲关失败\n游戏结束"
                } else {
                    // 移除怪兽
                    monsterIndexToRemove.append(i)
                    aMonsterDie()
                }
            }
        }
        while (monsterIndexToRemove.count > 0) {
            newMonsters.remove(at: monsterIndexToRemove.removeLast())
        }
        monsters = newMonsters // 触发 @Published 更新
    }

    // 移动炮弹
    func moveBullets() {
        for (index, bullet) in bullets.enumerated().reversed() {
            bullets[index].position.x += bullet.velocity.dx
            bullets[index].position.y += bullet.velocity.dy

            // 清除超出屏幕的子弹
            if abs(bullets[index].position.x) > 1000 {
                bullets.remove(at: index)
            } else if abs(bullets[index].position.y) > 1000 {
                bullets.remove(at: index)
            } else {
                // 与怪兽碰撞检测
                if let monsterIndex = monsters.firstIndex(where: {
                    hypot($0.position.x - bullet.position.x,
                          $0.position.y - bullet.position.y) < 20
                }) {
                    monsters[monsterIndex].health -= bullet.damage
                    if let iceBullet = bullets[index] as? IceBullet {
                        if monsters[monsterIndex].slowdownFactor > iceBullet.maxSlowdownFactor {
                            monsters[monsterIndex].slowdownFactor *= iceBullet.slowdownFactor
                        }
                    }
                    if monsters[monsterIndex].health <= 0 {
                        // 添加金币 增加一个增减动画
                        floatingTexts.append(
                            FloatingText(
                                position: monsters[monsterIndex].position,
                                increment: Int(monsters[monsterIndex].fullHealth * 1.0)
                            )
                        )
                        coins += Int(monsters[monsterIndex].fullHealth * 1.0)
                        
                        monsters.remove(at: monsterIndex)
                        AudioServicesPlaySystemSound(1016) // 音效  死亡
                        aMonsterDie()
                    } else {
                        AudioServicesPlaySystemSound(1104) // 音效  中弹
                    }
                    if bullets[index] is LaserBullet {
                        // 激光子弹有穿透作用，不用移除
                    } else {
                        bullets.remove(at: index)
                    }
                }
            }
        }
    }
    
    func placeATower(ofType type: TowerType, at position: Position) {
        switch type {
        case .blaster:
            towers.append(Blaster(position: position))
        case .freezer:
            towers.append(Freezer(position: position))
        case .laser:
            towers.append(Laser(position: position))
        case .magnetic:
            towers.append(Magnetic(position: position))
        case .magic:
            towers.append(Magic(position: position))
        case .bank:
            towers.append(Bank(position: position))
        }
        cells[position.row][position.col] = .tower
        // 添加金币 增加一个增减动画
        floatingTexts.append(
            FloatingText(
                position: CGPoint(x: position.col * 50 + 25, y: position.row * 50 + 25),
                increment: -type.cost
            )
        )
        coins -= type.cost
    }

    // 炮塔升级方法
    func upgradeTower(_ tower: Tower) {
        guard let index = towers.firstIndex(where: { $0.id == tower.id }) else { return }
        guard towers[index].level < topLevelOfTower else { return }
        guard coins >= towers[index].upgradeIncreaseCost * (towers[index].level + 1) else { return }

        // 添加金币 增加一个增减动画
        floatingTexts.append(
            FloatingText(
                position: tower.center,
                increment: -towers[index].upgradeIncreaseCost * (towers[index].level + 1)
            )
        )
        coins -= towers[index].upgradeIncreaseCost * (towers[index].level + 1)
        towers[index].level += 1
        towers[index].damage *= 1.2
        towers[index].range *= 1.2
        towers[index].velocityOfBullet *= 1.2
        towers[index].fireRate *= 0.8
        towers[index].value += towers[index].upgradeIncreaseCost * towers[index].level
        towers[index].sizeOfBullet *= 1.2
        if let freezerTower = towers[index] as? Freezer {
            freezerTower.slowdownFactor *= 0.9
            freezerTower.maxSlowdownFactor *= 0.8
        }
        if let magneticTower = towers[index] as? Magnetic {
            magneticTower.minStrengthenFactor *= 1.02
        }
        if let magicTower = towers[index] as? Magic {
            magicTower.slowdownFactor *= 0.9
            magicTower.maxSlowdownFactor *= 0.8
        }
        if let bankTower = towers[index] as? Bank {
            bankTower.interestRate *= 1.1
        }
    }
    
    // 炮塔连续升级方法 直到不够钱或达到封顶的级别
    func upgradeTower(_ tower: Tower, toTheFull: Bool) {
        guard let index = towers.firstIndex(where: { $0.id == tower.id }) else { return }

        while coins >= towers[index].upgradeIncreaseCost * (towers[index].level + 1) {
            if towers[index].level >= topLevelOfTower { return }
            upgradeTower(tower)
        }
    }

    // 炮塔降级方法
    func relegateTower(_ tower: Tower) {
        guard let index = towers.firstIndex(where: { $0.id == tower.id }) else { return }
        
        let reduceValue = tower.upgradeIncreaseCost * tower.level
        // 添加金币 增加一个增减动画
        floatingTexts.append(
            FloatingText(
                position: tower.center,
                increment: reduceValue * 8 / 10
            )
        )
        coins += reduceValue * 8 / 10
        towers[index].level -= 1
        towers[index].damage /= 0.9
        towers[index].range /= 1.5
        towers[index].velocityOfBullet /= 1.5
        towers[index].fireRate /= 0.9
        towers[index].value -= reduceValue
        towers[index].sizeOfBullet /= 1.1
        if let freezerTower = towers[index] as? Freezer {
            freezerTower.slowdownFactor /= 0.9
            freezerTower.maxSlowdownFactor /= 0.8
        }
        if let magneticTower = towers[index] as? Magnetic {
            magneticTower.minStrengthenFactor /= 1.02
        }
        if let magicTower = towers[index] as? Magic {
            magicTower.slowdownFactor /= 0.9
            magicTower.maxSlowdownFactor /= 0.8
        }
        if let bankTower = towers[index] as? Bank {
            bankTower.interestRate /= 1.1
        }
    }

    // 炮塔拆除方法
    func selloffTower(_ tower: Tower) {
        guard let index = towers.firstIndex(where: { $0.id == tower.id }) else { return }
        
        // 添加金币 增加一个增减动画
        floatingTexts.append(
            FloatingText(
                position: tower.center,
                increment: tower.value * 8 / 10
            )
        )
        coins += tower.value * 8 / 10
        cells[tower.position.row][tower.position.col] = .empty
        towers.remove(at: index)
    }
}

// 主界面
struct MainMenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // 背景
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                             startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 30) {
                    Spacer()
                    // 游戏标题
                    Text("疯狂塔防")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                    Spacer()
                    
                    NavigationLink(destination: PackageSelectionView()) { GameButton(label: "开始游戏") }
                    NavigationLink(destination: TutorialView()) { GameButton(label: "游戏介绍") }
                    NavigationLink(destination: SettingsView()) { GameButton(label: "设置") }
                    
                    GameButton(label: "排行榜")
                    Spacer()
                }
                .padding()
            }
        }
    }
}

// 选游戏包界面
struct PackageSelectionView: View {
//    @StateObject var viewModel = GameInfoForMenuViewModel()
    
    var packages: [GamePackage] = [
        GamePackage(id: 0, name: "经典", isUnlocked: true, levelScenes: 16),
        GamePackage(id: 1, name: "黑暗森林", isUnlocked: true, levelScenes: 20),
        GamePackage(id: 2, name: "死亡沙漠", isUnlocked: false, levelScenes: 15),
        GamePackage(id: 3, name: "巨龙巢穴", isUnlocked: false, levelScenes: 50)
    ]

    let columns = [
        GridItem(.adaptive(minimum: 160)),
        GridItem(.adaptive(minimum: 160))
    ]
    
    var body: some View {
        ZStack {
            // 背景
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                         startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(packages) { package in
                        NavigationLink(destination: LevelSelectionView(packageId: package.id)) {
                            PackageCard(package: package)
                        }
                        .disabled(!package.isUnlocked)
                    }
                }
                .padding()
            }
            .navigationTitle("选择游戏包")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// 选关卡界面
struct LevelSelectionView: View {
    var levelScenes: [LevelScene] = []
    
    init(packageId: Int) {
        levelScenes = sampleScene.filter { $0.packageId == packageId }
    }

    var body: some View {
        ZStack {
            // 背景
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                         startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 320), spacing: 0)], spacing: 0) {
                    ForEach(levelScenes) { levelScene in
                        NavigationLink(destination: TDGameView(game: GameManager(levelScene: sampleScene[levelScene.id]))) {
                            LevelCard(level: levelScene)
                                .padding()
                        }
                        .disabled(!levelScene.isUnlocked)
                    }
                }
                .padding()
            }
            .navigationTitle("选择关卡")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// 游戏按钮组件
struct GameButton: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.title2)
            .foregroundColor(.white)
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.3), radius: 5, y: 5)
    }
}

// 关卡包卡片组件
struct PackageCard: View {
    let package: GamePackage
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(package.isUnlocked ? Color.green : Color.gray)
                .frame(height: 180)
                .shadow(radius: 5)
            
            VStack {
                Text(package.name)
                    .font(.title2)
                    .foregroundColor(.white)
                
                Image(systemName: package.isUnlocked ? "lock.open" : "lock")
                    .font(.largeTitle)
                    .padding()
                
                Text("关数: \(package.levelScenes)")
                    .foregroundColor(.white)
            }
        }
        .opacity(package.isUnlocked ? 1 : 0.6)
    }
}

// 关卡卡片组件
struct LevelCard: View {
    let level: LevelScene
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(level.isUnlocked ? Color.green : Color.gray)
                .frame(height: 180)
                .shadow(radius: 5)
            
            VStack {
                Spacer()
                Text(level.name)
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Spacer()
                    Text("\(level.wavecount)波\n\(level.startLives)血")
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.black)
                    Spacer()
                    Text((level.isFixedRoad ? "路线：固定" : "路线：灵活") + "\n难度：\(level.difficulty)\n设计：\(level.designer)")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    Spacer()
                }
                Spacer()
            }
            if !level.isUnlocked {
                Image(systemName: level.isUnlocked ? "lock.open" : "lock")
                    .font(.largeTitle)
                    .padding()
            }
        }
        .opacity(level.isUnlocked ? 1 : 0.6)
    }
}

// MARK: - 介绍页面
struct TutorialView: View {
    var body: some View {
        ZStack {
            // 背景
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                         startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("游戏玩法")
                        .font(.title)
                    Text("1. 点击路径附近的空白地图选择建造炮塔")
                    Text("2. 炮塔会自动攻击敌人，阻止敌人到达终点")
                    Text("3. 尽量升级防御塔，级别越高性能越好")
                    
                    Image(systemName: "gamecontroller")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                }
                .padding()
                VStack(alignment: .leading, spacing: 20) {
                    Text("炮塔")
                        .font(.title)
                    Text("爆能枪")
                        .font(.headline)
                    Text("源在《星球大战》中，用凝聚光基能量脉冲替代传统实体弹丸，可以根据改变粒子种类而改变颜色。被银河系各个联邦或者集体批量生产从而适应各个行星的环境以便于战斗。其价格低廉，威力巨大，深受士兵喜爱。爆能枪打大Boss有点吃力，所以爆能枪喜欢一枪致命，专挑弱小的怪兽。")
                    Image(.爆能枪)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400)
                    Text("寒冰塔")
                        .font(.headline)
                    Text("改自《植物大战僵尸》，威力比爆能枪小一点点，但因能发出能让目标胆寒的寒光，会导致目标移动缓慢。唔好急，最紧要快，是寒冰塔的口头禅。但是，他要的是不敌人的快，他要的是快的敌人！寒冰塔，最看不惯跑得快的家伙，哪个跑的最快就打哪个！")
                    Image(.寒冰塔)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400)
                    Text("激爆塔")
                        .font(.headline)
                    Text("改自爆能枪，用更高能量的高凝聚光基高能量脉冲，能贯穿任何目标身体。枪枪见洞！")
                    Image(.激光塔)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400)
                    Text("磁暴塔")
                        .font(.headline)
                    Text("改造于特斯拉线圈，可以强迫电弧在远距离打击一个特定的目标，比如坦克或者士兵。本游戏对磁暴技术进行了升级改造，可以对特定目标进行长时间电弧打击，且其产生的伤害随着时间的增加而增长，适合打击高价值目标！所以磁暴塔，遇强越强，专啃硬骨头！再硬的怪兽在磁暴塔面前，很快就蔫了！")
                    Image(.磁暴塔)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400)
                    Text("魔法塔")
                        .font(.headline)
                    Text("虽然魔法塔的攻击速度并不快，但其结合了寒冰塔+爆能枪+银行的效果，且能对射程范围内所有目标进行无差别攻击！当面对众多敌人时，魔法塔能够展现出强大的效果，给予敌人无差别的魔法打击。魔法塔下，众生平等！")
                    Text("诡异的是，磁暴塔和魔法塔对残兵极度仁慈。从不对他们下死手。")
                    Image(.魔法塔)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400)
                    Text("银行保险证券")
                        .font(.headline)
                    Text("为你投资理财的综合机构，每波带来一定的投资收益，需要钱的时候把他卖掉换钱。")
                }
                .padding()
            }
            .navigationTitle("游戏介绍")
        }
    }
}
 
// MARK: - 设置页面
struct SettingsView: View {
    @AppStorage("soundEnabled") private var soundEnabled = true
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    
    var body: some View {
        Form {
            Section("游戏设置") {
                Toggle("音效", isOn: $soundEnabled)
                Toggle("通知", isOn: $notificationsEnabled)
            }
            
            Section("关于") {
                Text("版本 1.0")
                Text("开发者: Tim")
            }
        }
        .navigationTitle("设置")
    }
}

// 添加闪电环效果视图
struct LightningRingEffectView: View {
    let position: CGPoint
    let radius: CGFloat

    @State private var isVisible = false
    var body: some View {
        Circle()
            .fill(RadialGradient(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple], center: .center, startRadius: 50, endRadius: radius))
            .frame(width: radius*2, height: radius*2)
            .position(position)
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.linear(duration: 0.05).repeatCount(1, autoreverses: true)) {
                    isVisible = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isVisible = false
                }
            }
    }
}

// 添加闪链电效果视图
struct LightningBoltEffectView: View {
    let startPoint: CGPoint
    let endPoint: CGPoint
    let strength: CGFloat
    
    @State private var isVisible = false
    
    var body: some View {
        Path { path in
            path.move(to: startPoint)
            generateLightningPath(start: startPoint, end: endPoint, path: &path)
        }
        .stroke(LinearGradient(gradient: Gradient(colors: [.purple, .blue, .white, .blue, .purple]),
                               startPoint: .leading,
                               endPoint: .trailing),
                style: StrokeStyle(lineWidth: strength, lineCap: .round, lineJoin: .round))
        .opacity(isVisible ? 1 : 0)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.02).repeatCount(1, autoreverses: true)) {
                isVisible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                isVisible = false
            }
        }
    }
    
    // 生成随机闪电路径
    private func generateLightningPath(start: CGPoint, end: CGPoint, path: inout Path) {
        let displacement: CGFloat = 10
        
        let midPoint = CGPoint(
            x: (start.x + end.x)/2 + CGFloat.random(in: -displacement...displacement),
            y: (start.y + end.y)/2 + CGFloat.random(in: -displacement...displacement)
        )
        
        if distance(start, midPoint) > 12 {
            generateLightningPath(start: start, end: midPoint, path: &path)
        }
        
        path.addLine(to: midPoint)
        
        if distance(midPoint, end) > 12 {
            generateLightningPath(start: midPoint, end: end, path: &path)
        }
        
        path.addLine(to: end)
    }
    
    private func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2))
    }
}

// MARK: -  游戏视图
struct TDGameView: View {
    @StateObject var game: GameManager
    @State private var selectedTower: Tower? = nil
    @State private var selectedPosition: Position?
    @State private var isPresented = false

    var body: some View {
        ZStack {
            // 背景
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                         startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    // 地图
                    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                        ForEach(0..<14, id: \.self) { row in
                            GridRow {
                                ForEach(0..<8, id: \.self) { column in
                                    let position = Position(row: row, col: column)
                                    CellView(cellState: game.cells[row][column])
                                        .frame(width: 50, height: 50)
                                        .onTapGesture {
                                            if selectedTower != nil {
                                                selectedTower = nil
                                            } else if isPresented {
                                                isPresented = false
                                            } else {
                                                // 建炮弹窗
                                                if game.gameState != .gameOver {
                                                    if game.cells[row][column] == .empty {
                                                        selectedPosition = position
                                                        isPresented = true
                                                    }
                                                }
                                            }
                                        }
                                }
                            }
                            .border(Color.gray, width: 0.2)
                        }
                    }

                    // 路径
                    Path { path in
                        path.move(to: game.pathPoints[0])
                        game.pathPoints.forEach { path.addLine(to: $0) }
                    }
                    .stroke(Color.gray, lineWidth: 48)
                    
                    // 出发地
                    Text("🚪")
                        .foregroundColor(.red)
                        .font(.system(size: 50))
                        .position(x: game.pathPoints[0].x, y: game.pathPoints[0].y)
                    // 目的地
                    Text("🏁")
                        .foregroundColor(.red)
                        .font(.system(size: 50))
                        .position(x: game.pathPoints[game.pathPoints.count - 1].x, y: game.pathPoints[game.pathPoints.count - 1].y)

                    // 怪兽
                    ForEach(game.monsters) { monster in
                        MonsterView(monster)
                            .position(monster.position)
                    }

                    // 显示被选择炮塔的射程
                    if let tower = selectedTower {
                        Circle()
                            .foregroundColor(.blue.opacity(0.2))
                            .frame(width: tower.range*2, height: tower.range*2)
                            .position(tower.center)
                    }
                    // 炮塔
                    ForEach(game.towers) { tower in
                        TowerView(tower)
                            .position(tower.center)
                            .onTapGesture {
                                selectedTower = tower
                        }
                        Text("\(tower.level)")
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 5)
                            .position(tower.center)
                    }
                    // 被选择炮塔的升级/降级/拆除弹窗
                    if let tower = selectedTower {
                        VStack {
                            Button("升级\(tower.upgradeIncreaseCost * (tower.level + 1))") {
                                game.upgradeTower(tower)
                                selectedTower = nil
                            }
                            .foregroundColor(game.coins < tower.upgradeIncreaseCost * (tower.level + 1) || tower.level >= game.topLevelOfTower ? .black : .red)
                            .disabled(game.coins < tower.upgradeIncreaseCost * (tower.level + 1) || tower.level >= game.topLevelOfTower)
                            Rectangle()
                                .frame(height: 10)
                                .foregroundColor(.clear)
                            Button("尽升") {
                                game.upgradeTower(tower, toTheFull: true)
                                selectedTower = nil
                            }
                            .foregroundColor(game.coins < tower.upgradeIncreaseCost * (tower.level + 1) || tower.level >= game.topLevelOfTower ? .black : .red)
                            .disabled(game.coins < tower.upgradeIncreaseCost * (tower.level + 1) || tower.level >= game.topLevelOfTower)
                            Rectangle()
                                .frame(height: 10)
                                .foregroundColor(.clear)
                            Button("取消") {
                                selectedTower = nil
                            }
                            .foregroundColor(.red)
                            Rectangle()
                                .frame(height: 10)
                                .foregroundColor(.clear)
                            Button("降级\(tower.upgradeIncreaseCost * tower.level * 8 / 10)") {
                                game.relegateTower(tower)
                                selectedTower = nil
                            }
                            .foregroundColor(tower.level <= 1 ? .black : .red)
                            .disabled(tower.level <= 1)
                            Rectangle()
                                .frame(height: 10)
                                .foregroundColor(.clear)
                            Button("回收\(tower.value*8/10)") {
                                game.selloffTower(tower)
                                selectedTower = nil
                            }
                        }
                        .padding()
                        .foregroundColor(.red)
                        .shadow(radius: 5)
                        .position(x: tower.center.x < 75 ? 75 : tower.center.x > 325 ? 325 : tower.center.x, y: tower.center.y < 125 ? 125 : tower.center.y > 575 ? 575 : tower.center.y)
                    }

                    // 子弹
                    ForEach(game.bullets) { bullet in
                        Circle()
                            .frame(width: bullet.size, height: bullet.size)
                            .position(bullet.position)
                            .foregroundColor(bullet.color)
                    }
                    
                    // 闪电环
                    ForEach(game.lightningRings) { lightningRing in
                        LightningRingEffectView(position: lightningRing.position, radius: lightningRing.radius).opacity(0.1)
                    }

                    // 闪电链
                    ForEach(game.lightningBolts) { lightningBolt in
                        LightningBoltEffectView(startPoint: lightningBolt.startPoint, endPoint: lightningBolt.endPoint, strength: lightningBolt.strength)
                    }

                    // 增减值动画
                    ForEach(game.floatingTexts) { floatingText in
                        FlyingNumber(number: floatingText.increment)
                            .position(floatingText.position)
                    }

                    // 选择炮塔
                    if isPresented {
                        TowerSelectionView(isPresented: $isPresented, coins: $game.coins) { type in
                            game.placeATower(ofType: type, at: selectedPosition!)
                        }
                    }

                    // 游戏结束提示
                    Text("\(game.gameOverMessage)")
                        .foregroundColor(.red)
                        .font(.system(size: 50))
                        .multilineTextAlignment(.center)
                        .shadow(color: .black, radius: 15)

                }
                .frame(width: 400, height: 700)
                .contentShape(Rectangle())
            }
            // 控制面板
            VStack {
                HStack {
                    Spacer()
                    Text("\(game.coins)金\n\(game.lives)血")
                        .multilineTextAlignment(.trailing)
                    Spacer()
                    Text("\(game.currentWave)/\(sampleWaves[game.levelScene.wavesId].waves.count)波\n\(game.monsters.count)/\(game.remainingMonstersOfCurrentWave)怪")
                        .multilineTextAlignment(.trailing)
                    Spacer()
                    VStack {
                        let displayText: String = game.acceleration == 4.0 ? "4速" : game.acceleration == 2.0 ? "2速" : game.acceleration == 1.0 ? "1速" : "半速"
                        Button(displayText) { game.accelerator() }.disabled(game.gameState != .running)
                        let startString: String = game.gameState == .waitingToStart ? "开始" : game.gameState == .gameOver ? "重开" : game.gameState == .pause ? "继续" : "暂停"
                        Button(startString) { game.startGame() }
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

// MARK: - 怪兽视图
struct MonsterView: View {
    let monster: Monster
    
    init(_ monster: Monster) {
        self.monster = monster
    }

    var body: some View {
        ZStack {
            TimelineView(.animation) { timeline in
                Pie(endAngle: .degrees(monster.health / monster.fullHealth * 360))
                    .foregroundColor(monster.health > 800 ? .purple : monster.health > 400 ? .cyan : monster.health > 200 ? .blue : monster.health > 100 ? .green : monster.health > 50 ? .yellow : .red)
                    .frame(width: 40, height: 40)
                    .transition(.scale)
            }
            Circle()
                .overlay(Text("\(monster.type.rawValue)").font(.system(size: 35)))
                .frame(width: 35, height: 35)
            Text("\(monster.level)")
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5)
        }
    }
}

// MARK: - 炮塔视图
struct TowerView: View {
    let tower: Tower
    
    init(_ tower: Tower) {
        self.tower = tower
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(tower.type.color)
                .frame(width: 40, height: 40)
                .shadow(radius: 5)
                .overlay(Text("\(tower.type.rawValue.prefix(1))").foregroundColor(.gray))
        }
    }
}
 
// MARK: - 地图视图
struct CellView: View {
    let cellState: CellState
    
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.3)
            
            if cellState != .empty {
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

// MARK: - 血条形状
struct Pie: Shape {
    var startAngle: Angle = Angle.zero
    let endAngle: Angle
    var clockwise = true
    
    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians), y: center.y + radius * sin(startAngle.radians)
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise)
        p.addLine(to: center)
        
        return p
    }
}

// MARK: - 炮塔选择视图
struct TowerSelectionView: View {
    @Binding var isPresented: Bool
    @Binding var coins: Int
    
    let onTowerSelected: (TowerType) -> Void
    
    var body: some View {
        VStack {
            ForEach(TowerType.allCases, id: \.self) { type in
                Button {
                    onTowerSelected(type)
                    isPresented = false
                } label: {
                    Text(type.description + "\(type.cost)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(type.cost > coins ? .black : .red)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .background(Color.white)
                }
                .disabled(type.cost > coins ? true : false)
            }
        }
        .frame(width: 200)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ContentView: View {
    var body: some View {
        TDGameView(game: GameManager(levelScene: sampleScene[0]))
    }
}

struct FlyingNumber: View {
    let number: Int
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.headline)
                .foregroundColor(number < 0 ? .red : .green)
                .shadow(color: .black, radius: 1.5, x: 1, y: 1)
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0 : 1)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        offset = number < 0 ? 50 : -50
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
    }
}
