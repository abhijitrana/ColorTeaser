//
//  GameOver.swift
//  Lazor Defence
//
//  Created by YesAbhi Lab on 10/05/17.
//  Copyright © 2017 YesAbhi Lab. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

enum NodesZPosition: CGFloat {
    case background = 0, title = 1, button = 2
}

class GameOver: SKScene {

    var score = Int()
    var scoreLabel = SKLabelNode()
    var bestScore = Int()
    var bestScoreLabel = SKLabelNode()
    
    
    var menuButton: RBButton!
    var retryButton: RBButton!
    var gcButton: RBButton!
    var shareButton: RBButton!
    
    
    var shareImage: UIImage!
    
    
    override func didMove(to view: SKView) {
        showAds()
    }
    
    
     override func sceneDidLoad() {
    
        showAds()
        
        scoreLabel = childNode(withName: "score") as! SKLabelNode
        bestScoreLabel = childNode(withName: "bestscore") as! SKLabelNode
        
        score = PlayerStats.shared.getCurrentValue(.CurrentScore)
        scoreLabel.text = "Score : \(score)"
        
        bestScore = PlayerStats.shared.getCurrentValue(.BestScore)
        bestScoreLabel.text = "Best : \(bestScore)"
        
        retryButton = RBButton(buttonImage: "retry", buttonAction: {
            self.didTap(button: .TryAgain)
        })
        retryButton.setScale(0.5)
        retryButton.position = CGPoint(x: 0, y: 0)
        retryButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(retryButton)
        
        
        
        menuButton = RBButton(buttonImage: "menu", buttonAction: {
            self.didTap(button: .BackHome)
        })
        menuButton.setScale(0.5)
        menuButton.position = CGPoint(x: -self.frame.width * 0.2, y: -self.frame.height * 0.2)
        menuButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(menuButton)
        
        
        
        gcButton = RBButton(buttonImage: "gc", buttonAction: {
            self.didTap(button: .GameCenter)
        })
        gcButton.setScale(0.5)
        gcButton.position = CGPoint(x: self.frame.width * 0.0, y: -self.frame.height * 0.2)
        gcButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(gcButton)
        
        shareButton = RBButton(buttonImage: "share", buttonAction: {
            self.didTap(button: .Share)
        })
        shareButton.setScale(0.5)
        shareButton.position = CGPoint(x: self.frame.width * 0.2, y: -self.frame.height * 0.2)
        shareButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(shareButton)
        
        
    }
    
    func didTap(button: RBGameOverButtonType) {
        switch button {
        case .BackHome:
            goToMainMenu()
            break
            
        case .TryAgain:
            goToGameplay()
            break
            
        case .GameCenter:
            goToGameCenter()
            break
            
        case .Share:
            shareScore()
            break
        }
     }
    
    
    func goToGameplay() {
        
        let scene = GameScene(fileNamed: "GameScene")
        let transition = SKTransition.moveIn(with: SKTransitionDirection.up, duration: 0.5)
        //let skView = self.view as SKView!
        scene?.scaleMode = .aspectFill
        self.view?.presentScene(scene!, transition: transition)
    }
    
    func goToMainMenu() {
        
        let scene = MenuScene(fileNamed: "MenuScene")
        let transition = SKTransition.moveIn(with: SKTransitionDirection.up, duration: 0.5)
        //let skView = self.view as SKView!
        scene?.scaleMode = .aspectFill
        self.view?.presentScene(scene!, transition: transition)
    }
    
    func goToGameCenter() {
        GCHelper.sharedInstance.showGameCenter((self.view?.window?.rootViewController)!, viewState: .leaderboards)
    }
    
    func shareScore()
    {
        //loadImageForScoreShare(String(describing: Bundle.main.url(forResource: LocalNotificationAttachmentName, withExtension: LocalNotificationAttachmentExtention)))
        openShareScoreController()
    }
    
    func openShareScoreController() {
        let vc = self.view?.window?.rootViewController
        
        let myText = ShareScoreTextFirstPart + String(PlayerStats.shared.getCurrentValue(.CurrentScore)) + ShareScoreTextSecondPart
        
        let shareImage = UIImage(named: "ShareImage")
        
        let activityVC:UIActivityViewController = UIActivityViewController(activityItems: [shareImage!, myText], applicationActivities: nil)
        
        // added for iPad
        activityVC.popoverPresentationController?.sourceView = self.view
        
        vc?.present(activityVC, animated: true, completion: nil)
    }
    
    func loadImageForScoreShare(_ urlString:String)
    {
        let imgURL: URL = URL(string: urlString)!
        let request: URLRequest = URLRequest(url: imgURL)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            if (error == nil && data != nil)
            {
                func display_image()
                {
                    self.shareImage = UIImage(data: data!)
                    self.openShareScoreController()
                }
                
                DispatchQueue.main.async(execute: display_image)
            } else {
                // alert no image
            }
            
        })
        
        task.resume()
    }
    
    func showAds() {
//        if !MKStoreKit.shared().isProductPurchased(InAppPurchaseID1) {
            //      if !Chartboost.hasInterstitial(CBLocationGameOver) {
            //        Chartboost.cacheInterstitial(CBLocationGameOver)
            //      }
            //      Chartboost.showInterstitial(CBLocationGameOver)
            //      Chartboost.cacheInterstitial(CBLocationGameOver)
            
            if let viewController = view?.window?.rootViewController {
                SwiftyAds.shared.showInterstitial(withInterval: 2, from: viewController)
            }
            
//        }
    }
    
    
}

