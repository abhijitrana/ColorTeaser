//
//  GameScene.swift
//  Lazor Defence
//
//  Created by YesAbhi Lab on 09/05/17.
//  Copyright © 2017 YesAbhi Lab. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let Enemy : UInt32 = 0x1 << 1
    static let Defender : UInt32 = 0x1 << 2
}


class GameScene: SKScene,SKPhysicsContactDelegate {
    
    let hitSound = SKAction.playSoundFileNamed(hitSoundFile, waitForCompletion: false)
    let scoreSound = SKAction.playSoundFileNamed(scoreSoundFile, waitForCompletion: false)
    let woshSound = SKAction.playSoundFileNamed(woshSoundFile, waitForCompletion: false)
    let tapSound = SKAction.playSoundFileNamed(tapSoundFile, waitForCompletion: false)
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
 
    private var scoreLabel : SKLabelNode?
 
     var redButton: RBButton!
     var greenButton: RBButton!
     var blueButton: RBButton!
     var yellowButton: RBButton!
    
    var score : Int = 0
    var current_color :String!
    
    var defenderNode : SKSpriteNode!
    
    enum NodesZPosition: CGFloat {
        case background = 0, title = 1, button = 2
    }
    
    override func sceneDidLoad() {
 
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = childNode(withName: "scoreLbl") as! SKLabelNode
        defenderNode = childNode(withName: "defender") as! SKSpriteNode

        defenderNode.physicsBody = SKPhysicsBody(rectangleOf: defenderNode.size)
        defenderNode.physicsBody?.categoryBitMask = PhysicsCategory.Defender
        defenderNode.physicsBody!.collisionBitMask = PhysicsCategory.Enemy
        defenderNode.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        defenderNode.physicsBody?.affectedByGravity = false
        defenderNode.physicsBody?.isDynamic = false
        
        
        current_color = "red"

        
        redButton = RBButton(buttonImage: "red", buttonAction: {
            self.didTap(button: .Red)
        })
        redButton.setScale(0.5)
        redButton.position = CGPoint(x: -self.frame.width * 0.3, y: -self.frame.height * 0.4)
        redButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(redButton)
        
        greenButton = RBButton(buttonImage: "green", buttonAction: {
            self.didTap(button: .Green)
        })
        greenButton.setScale(0.5)
        greenButton.position = CGPoint(x: -self.frame.width * 0.1, y: -self.frame.height * 0.4)
        greenButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(greenButton)
        
        blueButton = RBButton(buttonImage: "blue", buttonAction: {
            self.didTap(button: .Blue)
        })
        blueButton.setScale(0.5)
        blueButton.position = CGPoint(x: self.frame.width * 0.1, y: -self.frame.height * 0.4)
        blueButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(blueButton)

        
        yellowButton = RBButton(buttonImage: "yellow", buttonAction: {
            self.didTap(button: .Yellow)
        })
        yellowButton.setScale(0.5)
        yellowButton.position = CGPoint(x: self.frame.width * 0.3, y: -self.frame.height * 0.4)
        yellowButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(yellowButton)

        
        let wait = SKAction.wait(forDuration: 2)
        let spawnNode = SKAction.run {
            self.spawnEnemy()
        }
 
        let sequence = SKAction.sequence([wait, spawnNode])
        
        
        self.run(SKAction.repeatForever(sequence) , withKey: "spawning") // run action with key so you can remove it later
        
 
    }
 
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
    }
    
    func  spawnEnemy()
    {
         print("spawn enemy")
        
        
        var imagename = ""
        var enemyName = ""
        let randomColor = arc4random()%4;
        switch randomColor {
        case 0:
            enemyName="red"
            imagename = "enemy_red.png"
             break
        case 1:
            enemyName="green"
            imagename = "enemy_green.png"
             break
        case 2:
            enemyName="blue"
            imagename = "enemy_blue.png"
             break
        case 3:
            enemyName="yellow"
            imagename = "enemy_yellow.png"
             break
        default: break
            
        }
        
        
       let pos_x: CGFloat = CGFloat.random(-4, max: 4)
        
        let enemy = SKSpriteNode(imageNamed: imagename)
        enemy.setScale(1)
        enemy.zPosition = -1
        enemy.name = enemyName;
        
        enemy.position = CGPoint(x: self.frame.width * pos_x/10, y: self.frame.height*0.6)
        
        var moving_time = 0.0;
        if(score<5){
            moving_time=8.0
        }else if (score >= 5 && score<10){
            moving_time=7.0
        }else if (score >= 10 && score<20){
            moving_time=6.0
        }else if (score >= 20 && score<25){
            moving_time=5.0
        }else{
            moving_time=3.0
        }
        
        let action = SKAction.moveTo(y: -self.frame.height*0.5, duration: moving_time)
        let actionDone = SKAction.removeFromParent()
        enemy.run(SKAction.sequence([action, actionDone]))
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategory.Defender
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.Defender
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.isDynamic = true
        self.addChild(enemy)
        
        
    }
    
    func didTap(button: RBGamePlayButtonType) {
        switch button {
        case .Red:
            current_color = "red"
            print("red tapped")
            let colorize = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.2)
            defenderNode.run(colorize)
        case .Green:
            current_color = "green"
            print("green tapped")
            let colorize = SKAction.colorize(with: .green, colorBlendFactor: 1, duration: 0.2)
            defenderNode.run(colorize)

        case .Blue:
            current_color = "blue"
            print("blue tapped")
            let colorize = SKAction.colorize(with: .blue, colorBlendFactor: 1, duration: 0.2)
            defenderNode.run(colorize)
        case .Yellow:
            current_color = "yellow"
            print("yellow tapped")
            let colorize = SKAction.colorize(with: .yellow, colorBlendFactor: 1, duration: 0.2)
            defenderNode.run(colorize)
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
            let firstBody = contact.bodyA
            let secondBody = contact.bodyB
            
            if firstBody.categoryBitMask == PhysicsCategory.Defender && secondBody.categoryBitMask == PhysicsCategory.Enemy || firstBody.categoryBitMask == PhysicsCategory.Enemy && secondBody.categoryBitMask == PhysicsCategory.Defender {
                
                if(firstBody.categoryBitMask == PhysicsCategory.Enemy){
                    let spritenode : SKSpriteNode! =   firstBody.node as! SKSpriteNode;
                    print("A \(spritenode.name!) ")
                    if(spritenode.name! == current_color){
                        spritenode.removeFromParent();
                        if PlayerStats.shared.getCurrentBoolValue(.Sound) {
                            self.run(self.scoreSound)
                        }
                        score+=1
                        scoreLabel?.text = "\(score)"
                        blast(pos: spritenode.position)
                    }else{
                        //game over
                        barBlast(pos: defenderNode.position)
                        gameOver()
                    }
                }
                
                if(secondBody.categoryBitMask == PhysicsCategory.Enemy){
                    let spritenode : SKSpriteNode! =   secondBody.node as! SKSpriteNode;
                    print("B \(spritenode.name!) ")
                    if(spritenode.name! == current_color){
                        spritenode.removeFromParent();
                        if PlayerStats.shared.getCurrentBoolValue(.Sound) {
                            self.run(self.scoreSound)
                        }
                        score+=1
                        scoreLabel?.text = "\(score)"
                        blast(pos: spritenode.position)
                    }else{
                        //game over
                         barBlast(pos: defenderNode.position)
                        gameOver()
                    }
                }
 
//                score += 1
//                scoreLabel.text = "\(score)"
//                
//                if PlayerStats.shared.getCurrentBoolValue(.Sound) {
//                    self.run(self.scoreSound)
//                }
                
            }
            
//            if firstBody.categoryBitMask == PhysicsCategory.Ground && secondBody.categoryBitMask == PhysicsCategory.Hero || firstBody.categoryBitMask == PhysicsCategory.Hero && secondBody.categoryBitMask == PhysicsCategory.Ground {
//                runHeroRunAnimation()
//            }
//            
//            if firstBody.categoryBitMask == PhysicsCategory.Pipe && secondBody.categoryBitMask == PhysicsCategory.Hero || firstBody.categoryBitMask == PhysicsCategory.Hero && secondBody.categoryBitMask == PhysicsCategory.Pipe {
//                runHeroRunAnimation()
//            }
// 
    }

    func gameOver(){
        
        if PlayerStats.shared.getCurrentBoolValue(.Sound) {
            self.run(self.hitSound)
        }
        
        if PlayerStats.shared.getCurrentBoolValue(.Sound) {
            self.run(self.hitSound)
        }
        
        // save score
        PlayerStats.shared.changeTo(score, forStat: .CurrentScore)
        GCHelper.sharedInstance.reportLeaderboardIdentifier(leaderboardID, score: score)
        
        
        let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.5)
        
//        let nextScene = GameOver(fileNamed: "GameOver")
//        gameOverScene?.scaleMode = .aspectFill
//        
//        self.scene?.view?.presentScene(nextScene, transition: transition)
        
        let gameOverScene = GameOver(fileNamed: "GameOver")
        let skView = self.view as SKView!
        gameOverScene?.scaleMode = .aspectFill
        skView?.presentScene(gameOverScene!,transition: transition)
        
    }
    
    func blast(pos :CGPoint){
        
        print("blast_\(current_color).sks");
        
        if let particles = SKEmitterNode(fileNamed: "blast_\(current_color!).sks") {
            
            particles.position = pos
            addChild(particles)
            
             let pRemoveNode = SKAction.removeFromParent()
             let pWaitForSecsN = SKAction.wait(forDuration: 0.5)
            
 
            particles.run(SKAction.sequence([pWaitForSecsN, pRemoveNode]))
 
            
        }
    }
    
    func barBlast(pos :CGPoint){
        
        print("bar_blast_\(current_color!).sks");
        
        if let particles = SKEmitterNode(fileNamed: "bar_blast_\(current_color!).sks") {
            
            particles.position = pos
            addChild(particles)
            
            let pRemoveNode = SKAction.removeFromParent()
            let pWaitForSecsN = SKAction.wait(forDuration: 0.5)
            
            
            particles.run(SKAction.sequence([pWaitForSecsN, pRemoveNode]))
            
            
        }
    }
    
    
}
