//
//  GameViewController.swift
//  swiftris
//
//  Created by Suha Baobaid on 27/07/2017.
//  Copyright © 2017 Suha Baobaid. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import ReSwift

class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate {

    var scene: GameScene!
    var swiftris: Swiftris!
    var panPointReference: CGPoint?
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet var SubMenuView: UIView!
    @IBOutlet weak var VisualEffectView: UIVisualEffectView!
    
    @IBOutlet weak var MenuButton: UIButton!
    var effect: UIVisualEffect!
    
    let window = UIApplication.shared.keyWindow!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimationForNavigationBar(caseOfFunction: false, view: self)
        
        MenuButton.layer.cornerRadius = 6
        
    }
    
    // creates the button that's going to be used
    func addButton(){
        // replacing the navigation bar back button with the new button that was created
        let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.backAction(_:)))
        self.navigationItem.leftBarButtonItem = back
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating a back button
        addButton()
        
        
        //store the effect (blurring) and remove the effect in the beginning
        effect = VisualEffectView.effect
        VisualEffectView.effect = nil
        
        // set the radius of the view of the popup
        SubMenuView.layer.cornerRadius = 5
        
        //configure the view - as! is a downcaster
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        //create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        //aspectFill to cover the whole thing opposite to aspectFit
        scene.scaleMode = .aspectFill
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.delegate = self
        swiftris.beginGame()
        
        //present the screen
        skView.presentScene(scene)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        swiftris.endGame()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let currentPoint = sender.translation(in: self.view)
        if let originalPoint = panPointReference {
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                if sender.velocity(in: self.view).x > CGFloat(0) {
                    swiftris.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .began {
            panPointReference = currentPoint
        }
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        swiftris.rotateShape()
    }
    
    
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        swiftris.dropShape()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UISwipeGestureRecognizer {
            if otherGestureRecognizer is UIPanGestureRecognizer {
                return true
            }
        } else if gestureRecognizer is UIPanGestureRecognizer {
            if otherGestureRecognizer is UITapGestureRecognizer {
                return true
            }
        }
        return false
    }
    
    func didTick() {
        swiftris.letShapeFall()
    }
    
    func nextShape() {
        let newShapes = swiftris.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        
        self.scene.addPreviewShapeToScene(shape: newShapes.nextShape!) {}
        self.scene.movePreviewShape(shape: fallingShape) {
            self.view.isUserInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(swiftris: Swiftris) {
        
        levelLabel.text = "\(swiftris.level)"
        scoreLabel.text = "\(swiftris.score)"
        scene.tickLengthMillis = TickLengthLevelOne
        
        // The following is false when restarting a new game
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(shape: swiftris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: Swiftris) {
        view.isUserInteractionEnabled = false
        scene.stopTicking()
        scene.playSound(sound: "gameover.mp3")
        scene.animateCollapsingLines(linesToRemove: swiftris.removeAllBlocks(), fallenBlocks: swiftris.removeAllBlocks()) {
            swiftris.beginGame()
        }
    }
    
    func gameDidLevelUp(swiftris: Swiftris) {
        levelLabel.text = "\(swiftris.level)"
        if scene.tickLengthMillis >= 100 {
            scene.tickLengthMillis -= 100
        } else if scene.tickLengthMillis > 50 {
            scene.tickLengthMillis -= 50
        }
        scene.playSound(sound: "levelup.mp3")
    }
    
    func gameShapeDidDrop(swiftris: Swiftris) {
        scene.stopTicking()
        scene.redrawShape(shape: swiftris.fallingShape!) {
            swiftris.letShapeFall()
        }
        scene.playSound(sound: "drop.mp3")
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        self.view.isUserInteractionEnabled = false
        let removedLines = swiftris.removeCompleteLines()
        if removedLines.linesRemoved.count > 0 {
            self.scoreLabel.text = "\(swiftris.score)"
            scene.animateCollapsingLines(linesToRemove: removedLines.linesRemoved, fallenBlocks: removedLines.fallenBlocks){
                // #11
                self.gameShapeDidLand(swiftris: swiftris)
            }
            scene.playSound(sound: "bomb.mp3")
        } else {
            nextShape()
        }
    }
    
    // #17
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(shape: swiftris.fallingShape!) {}
    }
    
    func animateIn() {
        window.addSubview(SubMenuView)
        SubMenuView.center = self.view.center
        
        SubMenuView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        SubMenuView.alpha = 0
        
        UIView.animate(withDuration: 0.4, animations: {
            self.VisualEffectView.effect = self.effect
            self.SubMenuView.alpha = 1
            self.SubMenuView.transform = CGAffineTransform.identity
        })
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.SubMenuView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.SubMenuView.alpha = 0
            self.MenuButton.alpha = 1
            self.VisualEffectView.effect = nil
            }, completion: { (success: Bool) in
                self.SubMenuView.removeFromSuperview()
                })
    }
    
    @IBAction func showMenu(_ sender: Any) {
        self.view.isUserInteractionEnabled = false
        MenuButton.alpha = 0
        swiftris.pauseGame()
        scene.stopTicking()
        animateIn()
    }
    
    @IBAction func cancelMenu(_ sender: UIButton) {
        animateOut()
        self.view.isUserInteractionEnabled = true
        scene.startTicking()
    }
    
    
    // function to go back to the main view controller
    @IBAction func backAction(_ sender: UIButton){
        animateOut()
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToMainMenu(_ sender: UIButton) {
        animateOut()
        let routeDestination: RoutingDestination = .start
        store.dispatch(RoutingAction(destination: routeDestination))
    }
    
}

