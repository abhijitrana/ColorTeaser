//
//  RBButton.swift
//  ImpossibleMaze
//
//  Created by SANDOR NAGY on 17/03/16.
//  Copyright © 2016 Rebeloper. All rights reserved.
//

import SpriteKit

class RBButton: SKNode {
  var button: SKSpriteNode
  var mask: SKSpriteNode
  var cropNode: SKCropNode
  var action: () -> Void
  var buttonIsEnabled = true
  
  init(buttonImage: String, buttonAction: @escaping () -> Void) {
    button = SKSpriteNode(imageNamed: buttonImage)
    button.zPosition = 0
    
    mask = SKSpriteNode(color: SKColor.black, size: button.size)
    mask.alpha = 0
    
    cropNode = SKCropNode()
    cropNode.maskNode = button
    cropNode.zPosition = 1
    cropNode.addChild(mask)
    
    action = buttonAction
    
    super.init()
    
    isUserInteractionEnabled = true
    addChild(button)
    addChild(cropNode)
  }
  
  /**
   Required so XCode doesn't throw warnings
   */
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if buttonIsEnabled {
      if PlayerStats.shared.getCurrentBoolValue(.Sound) {
        run(SKAction.playSoundFileNamed(tapSoundFile, waitForCompletion: false))
      }
      mask.alpha = 0.5
      run(SKAction.scale(to: 0.55, duration: 0.05))
    }
    
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if buttonIsEnabled {
      for touch in touches {
        let location: CGPoint = touch.location(in: self)
        
        if button.contains(location) {
          mask.alpha = 0.5
          run(SKAction.scale(to: 0.55, duration: 0.05))
        } else {
          mask.alpha = 0
        }
      }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if buttonIsEnabled {
      for touch in touches {
        let location: CGPoint = touch.location(in: self)
        
        if button.contains(location) {
          disableButton()
          action()
          run(SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.run({
            self.enableButton()
          })]))
        }
        
        mask.alpha = 0
        run(SKAction.scale(to: 0.50, duration: 0.05))
      }
    }
  }
  
  func disableButton() {
    buttonIsEnabled = false
    mask.alpha = 0.7
  }
  
  func enableButton() {
    buttonIsEnabled = true
    mask.alpha = 0
  }
  
}
