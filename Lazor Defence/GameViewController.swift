//
//  GameViewController.swift
//  Lazor Defence
//
//  Created by YesAbhi Lab on 09/05/17.
//  Copyright © 2017 YesAbhi Lab. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

import AVFoundation

class GameViewController: UIViewController {

    lazy var backgroundMusic: AVAudioPlayer? = {
        guard let url = Bundle.main.url(forResource: backgroundMusicName, withExtension: backgroundMusicExtension) else {
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            return player
        } catch {
            return nil
        }
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.mkStoreKitProductPurchased,
                                               object: nil, queue: OperationQueue.main) { (note) -> Void in
                                                print ("Purchased product: \(note.object)")
                                                
                                                switch note.object as! String {
                                                case InAppPurchaseID1:
                                                    print("IAP bought with ID: \(InAppPurchaseID1)")
                                                default:
                                                    print("Ooops, no such IAP!")
                                                }
                                                
                                                
                                                
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.mkStoreKitDownloadCompleted,
                                               object: nil, queue: OperationQueue.main) { (note) -> Void in
                                                print ("Downloaded product: \((note as NSNotification).userInfo)")
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.mkStoreKitDownloadProgress,
                                               object: nil, queue: OperationQueue.main) { (note) -> Void in
                                                print ("Downloading product: \((note as NSNotification).userInfo)")
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.mkStoreKitRestoredPurchases,
                                               object: nil, queue: OperationQueue.main) { (note) -> Void in
                                                print ("Restored Purchases.")
                                                self.showRestoredPurchasesAlert()
                                                MenuScene().updateUI()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.mkStoreKitRestoringPurchasesFailed,
                                               object: nil, queue: OperationQueue.main) { (note) -> Void in
                                                print ("Failed restoring purchases with error: \((note as NSNotification).userInfo)")
                                                self.showRestorePurchasesFailedAlert()
        }

        
        
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "MenuScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! MenuScene? {
                
//                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = false
                    view.showsNodeCount = false
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func showRestoredPurchasesAlert() {
        let alertController = UIAlertController(title: "Success", message: "Your purchases have been restored.", preferredStyle: .alert)
        
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
        }
        
    }
    
    func showRestorePurchasesFailedAlert() {
        let alertController = UIAlertController(title: "Sorry", message: "Your purchases could not be restored. Try again later.", preferredStyle: .alert)
        
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
        }
    }
}
