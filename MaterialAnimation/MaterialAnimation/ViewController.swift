//
//  ViewController.swift
//  MaterialAnimation
//
//  Created by minsang on 4/26/16.
//  Copyright © 2016 minsang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let container = CALayer()
    let rect = CALayer()
    
    //    Material Animation Curves, Check the commented ones as well.
    let curveMove = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
    //        let curveIn = CAMediaTimingFunction(controlPoints: 0.0, 0.0, 0.2, 1.0)
    //        let curveOut = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 1.0, 1.0)
    
    
    //    Some global values
    
    var initX:CGFloat = 320
    var initY:CGFloat = 60
    let containerInitX = -40
    let containerInitY = 240
    let scaleFactor = 20
    let angle = CGFloat(M_PI)
    
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //  Get screensize to automatically align it center
        let screenSize = UIScreen.mainScreen().bounds
        let deviceWidth = Int(screenSize.width)
        
        
        //  Create container that holds ink
        container.name = "container"
        container.frame = CGRect(x: 0, y: 0, width: deviceWidth, height: 240)
        container.position.y = CGFloat(containerInitY)
        container.transform = CATransform3DMakeRotation(angle, 0, 0, 1.0)
        //        container.backgroundColor = UIColor.blueColor().CGColor
        
        // Clips ink into bounds
        container.masksToBounds = true
        
        rect.name = "rect"
        rect.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        rect.backgroundColor = UIColor(red: 249/255, green: 178/255, blue: 79/255, alpha: 1).CGColor
        rect.cornerRadius = 50
        
        // Position it to familiar values
        rect.position = CGPoint(x:initX,y:initY)
        
        container.addSublayer(rect)
        self.view.layer.addSublayer(container)
        
        self.view.backgroundColor = UIColor(red: 225/255, green: 23/255, blue: 114/255, alpha: 1)
        
    }
    
    
    func moveRect() {
        
        let moveX = CABasicAnimation(keyPath:"position")
        
        moveX.keyPath = "position.x"
        moveX.fromValue = initX
        moveX.toValue = initX-120
        moveX.timingFunction = curveMove
        
        let moveY = CABasicAnimation(keyPath:"position")
        
        moveY.keyPath = "position.y"
        moveY.fromValue = initY
        moveY.toValue = initY+40
        moveY.timingFunction = curveMove
        
        let materialScale: CABasicAnimation = CABasicAnimation(keyPath: "transform")
        
        materialScale.keyPath = "transform.scale"
        materialScale.fromValue = 1
        materialScale.toValue = scaleFactor
        materialScale.beginTime = 0.6
        materialScale.duration = 0.4
        materialScale.timingFunction = curveMove
        
        let animationGroup = CAAnimationGroup()
        
        animationGroup.animations = [moveX,moveY,materialScale]
        animationGroup.duration = 1
        animationGroup.repeatCount = 1
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.autoreverses = false
        animationGroup.removedOnCompletion = false
        
        rect.addAnimation(animationGroup, forKey: nil)
        
    }
    
    func moveContainer(){
        
        let materialRotate = CABasicAnimation(keyPath: "transform.rotation")
        
        materialRotate.keyPath = "transform.rotation.z"
        materialRotate.fromValue = angle
        materialRotate.toValue = 0
        materialRotate.repeatCount = 1
        materialRotate.timingFunction = curveMove
//        container.transform = CATransform3DMakeRotation(0, 0, 0, 1.0)
        
        
        let materialMove = CABasicAnimation(keyPath: "position")
        materialMove.keyPath = "position.y"
        materialMove.fromValue = containerInitY
        materialMove.toValue = container.frame.height/2
        materialMove.repeatCount = 1
        materialMove.timingFunction = curveMove
        
//        container.position.y = container.frame.height/2
        
        let containerAnimations = CAAnimationGroup()
        containerAnimations.animations = [materialRotate,materialMove]
        containerAnimations.duration = 0.6
        containerAnimations.repeatCount = 1
        containerAnimations.fillMode = kCAFillModeForwards
        containerAnimations.autoreverses = false
        containerAnimations.removedOnCompletion = false
        container.addAnimation(containerAnimations, forKey: nil)
        
        
    }
    
    
    func revertRect() {
        
        let moveX2 = CABasicAnimation(keyPath:"position")
        moveX2.keyPath = "position.x"
        moveX2.fromValue = initX-120
        moveX2.toValue = initX
        moveX2.timingFunction = curveMove
        moveX2.fillMode = kCAFillModeForwards
        moveX2.beginTime = 0.4
        moveX2.duration = 0.6
    
        
        let moveY2 = CABasicAnimation(keyPath:"position")
        moveY2.keyPath = "position.y"
        moveY2.fromValue = initY+40
        moveY2.toValue = initY
        moveY2.timingFunction = curveMove
        moveY2.beginTime = 0.4
        moveY2.duration = 0.6
        moveY2.fillMode = kCAFillModeForwards
        
        rect.position.y = initY
        
        let materialScale2 = CABasicAnimation(keyPath: "transform")
        materialScale2.keyPath = "transform.scale"
        materialScale2.fromValue = scaleFactor
        materialScale2.toValue = 1
        materialScale2.fillMode = kCAFillModeForwards
        materialScale2.timingFunction = curveMove
        materialScale2.duration = 0.4
        
        let animationGroup2 = CAAnimationGroup()
        animationGroup2.animations = [moveX2,moveY2,materialScale2]
        animationGroup2.duration = 1
        animationGroup2.autoreverses = false
        animationGroup2.fillMode = kCAFillModeForwards
        animationGroup2.repeatCount = 1
        animationGroup2.removedOnCompletion = false
        
        rect.addAnimation(animationGroup2, forKey: nil)
        
    }
    
    func revertContainer(){
        let materialMove2 = CABasicAnimation(keyPath: "position")
        materialMove2.keyPath = "position.y"
        materialMove2.fromValue = container.frame.height/2
        materialMove2.toValue = containerInitY
        materialMove2.beginTime = 0.4
        materialMove2.duration = 0.6
        materialMove2.timingFunction = curveMove
        
        
        let materialRotate2 = CABasicAnimation(keyPath: "transform.rotation")
        materialRotate2.keyPath = "transform.rotation.z"
        materialRotate2.fromValue = 0
        materialRotate2.toValue = angle
        materialRotate2.beginTime = 0.4
        materialRotate2.duration = 0.6
        materialRotate2.timingFunction = curveMove
        

        
        let containerAnimations2 = CAAnimationGroup()
        containerAnimations2.animations = [materialMove2,materialRotate2]
        containerAnimations2.duration = 1
        containerAnimations2.repeatCount = 1
        containerAnimations2.fillMode = kCAFillModeForwards
        containerAnimations2.autoreverses = false
        containerAnimations2.removedOnCompletion = false
        container.addAnimation(containerAnimations2, forKey: nil)
        
        
    }
    
    
    //    Handling Touch Event of CALayer
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //        Get the coordinates of touchpoint
        let touchPoint: CGPoint = (touches.first!).locationInView(self.view)
        print(touchPoint)
        //        Find a layer based on it
        let touchedLayer: CALayer = self.view.layer.presentationLayer()!.hitTest(touchPoint)!
        print(touchedLayer)
        //        Get the actual Layer to manipulate
        let actualLayer: CALayer = touchedLayer.modelLayer() as! CALayer
        
        if actualLayer.name == "rect"{
            print(actualLayer.name)
            if isExpanded == false {
                moveRect()
                moveContainer()
                isExpanded = true
            } else {
                revertRect()
                revertContainer()
                isExpanded = false
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

