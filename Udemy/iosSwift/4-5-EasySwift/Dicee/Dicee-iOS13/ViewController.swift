//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //IBOutlets go in (send code controls to screen)
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    @IBOutlet weak var diceImageView3: UIImageView!
    @IBOutlet weak var diceImageView4: UIImageView!
    @IBOutlet weak var rollButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diceImageView1.image = #imageLiteral(resourceName: "DiceSix")
        diceImageView2.image = #imageLiteral(resourceName: "DiceFour")
        diceImageView3.image = #imageLiteral(resourceName: "DiceFive")
        diceImageView4.image = #imageLiteral(resourceName: "DiceFive")
    }
    
    //IBActiions go out (send info to code)
    @IBAction func UIButton(_ sender: UIButton) {
        let diceArray = [#imageLiteral(resourceName: "DiceOne"),#imageLiteral(resourceName: "DiceTwo"),#imageLiteral(resourceName: "DiceThree"),#imageLiteral(resourceName: "DiceFour"),#imageLiteral(resourceName: "DiceFive"),#imageLiteral(resourceName: "DiceSix")]
        var randRoll = Int.random(in: 0..<6)
        diceImageView1.image = diceArray[randRoll]
        randRoll = Int.random(in: 0..<6)
        diceImageView2.image = diceArray[randRoll]
        
        diceImageView3.image = diceArray.randomElement()
        diceImageView4.image = diceArray.randomElement()
    }
}

