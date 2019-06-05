//
//  ViewController.swift
//  Dice
//
//  Created by mun on 6/5/19.
//  Copyright © 2019 mun. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {
  let diceArr = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
  
  var randomDiceIndex1: Int = 0
  var randomDiceIndex2: Int = 0

  @IBOutlet weak var diceImageView1: UIImageView!
  @IBOutlet weak var diceImageView2: UIImageView!
  @IBOutlet weak var totalLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    updateDiceImage()
  }
  
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    updateDiceImage()
  }

  @IBAction func rollPressed(_ sender: Any) {
   updateDiceImage()
  }
  
  func updateDiceImage() {
    randomDiceIndex1 = Int.random(in: 0...5)
    randomDiceIndex2 = Int.random(in: 0...5)
    
    diceImageView1.image = UIImage(named: diceArr[randomDiceIndex1])
    diceImageView2.image = UIImage(named: diceArr[randomDiceIndex2])
    
    let total = randomDiceIndex1 + randomDiceIndex2 + 2
    totalLabel.text = "Total score: \(total)"
    totalLabel.sizeToFit()
    
    //Add shaking
    diceImageView1.shake(duration: 1.0)
    diceImageView2.shake(duration: 1.0)
  }
  
}

extension UIImageView {
  func shake(duration: CFTimeInterval) {
    let shakeValues = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
    
    let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
    translation.timingFunction = CAMediaTimingFunction(name: .linear)
    translation.values = shakeValues
    
    let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
      ( degrees: Double) -> Double in
      let radians: Double = (.pi * degrees) / 180.0
      return radians
    }
    
    
    let shakeGroup = CAAnimationGroup()
    shakeGroup.animations = [translation, rotation]
    shakeGroup.duration = duration
    layer.add(shakeGroup, forKey: "shakeIt")
  }
}


