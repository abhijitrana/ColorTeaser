//
//  MenuScene.swift
//  Lazor Defence
//
//  Created by YesAbhi Lab on 10/05/17.
//  Copyright © 2017 YesAbhi Lab. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class MenuScene: SKScene {

    var playButton: RBButton!
    var soundButton:RBButton!
    var noadButton: RBButton!
    var gcButton: RBButton!
    var restorePurchaseButton: RBButton!
    
    
    override func didMove(to view: SKView) {
        showBannerAd()
        
        let ad_show: CGFloat = CGFloat.random(0, max: 10)
        if(ad_show < 3){
            showAds()
        }
    }
     override func sceneDidLoad() {
        
        
        playButton = RBButton(buttonImage: "play", buttonAction: {
            self.didTap(button: .Play)
        })
        playButton.setScale(0.5)
        playButton.position = CGPoint(x: 0, y: 0)
        playButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(playButton)
        
        if PlayerStats.shared.getCurrentBoolValue(.Sound) {
            soundButton = RBButton(buttonImage: "sound_on", buttonAction: {
                self.didTap(button: .SoundOnOff)
            })
        } else {
            soundButton = RBButton(buttonImage: "sound_off", buttonAction: {
                self.didTap(button: .SoundOnOff)
            })
        }

        soundButton.setScale(0.5)
        soundButton.position = CGPoint(x: -self.frame.width * 0.15, y: -self.frame.height * 0.3)
        soundButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(soundButton)
        
        
        noadButton = RBButton(buttonImage: "no_ad", buttonAction: {
            self.didTap(button: .NoAds)
        })
        noadButton.setScale(0.5)
        noadButton.position = CGPoint(x: -self.frame.width * 0.075, y: -self.frame.height * 0.3)
        noadButton.zPosition = NodesZPosition.button.rawValue
       // self.addChild(noadButton)
        
        
        gcButton = RBButton(buttonImage: "gc", buttonAction: {
            self.didTap(button: .GameCenter)
        })
        gcButton.setScale(0.5)
        gcButton.position = CGPoint(x: self.frame.width * 0.15, y: -self.frame.height * 0.3)
        gcButton.zPosition = NodesZPosition.button.rawValue
        self.addChild(gcButton)
        
        restorePurchaseButton = RBButton(buttonImage: "restore", buttonAction: {
            self.didTap(button: .RestorePurchases)
        })
        restorePurchaseButton.setScale(0.5)
        restorePurchaseButton.position = CGPoint(x: self.frame.width * 0.225, y: -self.frame.height * 0.3)
        restorePurchaseButton.zPosition = NodesZPosition.button.rawValue
       // self.addChild(restorePurchaseButton)
        
        
    }
    
    func didTap(button: RBMainMenuButtonType) {
        switch button {
        case .Play:
            goToGameplay()
            break
            
        case .SoundOnOff:
            soundOnOffTapped()
            break
            
        case .NoAds:
            noAds()
            break
            
        case .GameCenter:
            goToGameCenter()
            break
            
        case .RestorePurchases:
            restorePurchases()
            break
            
        default:
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
    func goToGameCenter() {
        GCHelper.sharedInstance.showGameCenter((self.view?.window?.rootViewController)!, viewState: .leaderboards)
    }
    func soundOnOffTapped() {
        if PlayerStats.shared.getCurrentBoolValue(.Sound) {
            PlayerStats.shared.changeTo(false, forStat: .Sound)
            soundButton.button.texture = SKTexture(imageNamed: "sound_on")
            let gameViewController = self.view?.window?.rootViewController as! GameViewController
            gameViewController.backgroundMusic?.stop()
        } else {
            PlayerStats.shared.changeTo(true, forStat: .Sound)
            soundButton.button.texture = SKTexture(imageNamed: "sound_off")
            let gameViewController = self.view?.window?.rootViewController as! GameViewController
            gameViewController.backgroundMusic?.play()
        }
    }
    func noAds() {
        print("Started buying IAP with ID: \(InAppPurchaseID1)")
        MKStoreKit.shared().initiatePaymentRequestForProduct(withIdentifier: InAppPurchaseID1)
    }
    
    func restorePurchases() {
        print("Started restoring purchases")
        MKStoreKit.shared().restorePurchases()
    }
    
    func showBannerAd() {
//        if !MKStoreKit.shared().isProductPurchased(InAppPurchaseID1) {
//            //      if !Chartboost.hasInterstitial(CBLocationGameOver) {
//            //        Chartboost.cacheInterstitial(CBLocationGameOver)
//            //      }
//            //      Chartboost.showInterstitial(CBLocationGameOver)
//            //      Chartboost.cacheInterstitial(CBLocationGameOver)
//            
            if let viewController = view?.window?.rootViewController {
                SwiftyAds.shared.showBanner(from: viewController);
            }
            
//        }
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
    
    func updateUI() {
 
//        if MKStoreKit.shared().isProductPurchased(InAppPurchaseID1) {
//            noadButton.disableButton()
//        }
    }
}
