//
//  ViewController.swift
//  RimhTypingLetters
//
//  Created by ming on 11/20/2017.
//  Copyright (c) 2017 ming. All rights reserved.
//

import UIKit
import RimhTypingLetters

class ViewController: UIViewController {
    
    @IBOutlet weak var textview:TypingLetterUITextView!
    
    @IBOutlet weak var textLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startTyping(_ button:UIButton){
        // typing without any wrapping
        let message = "おはようございます。今日はお元気ですか？どうぞよろしくお願いいたします。"
        self.textview.typeText(message) {
            print("finished")
        }
    }
    
    @IBAction func startTypingWithDelimiter(_ button:UIButton){
        // typing with wrapping words by " "
        let message = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
        self.textview.typeText(message, delimiter: " ", typingSpeedPerChar: 0.01, didResetContent: true) {
            print("finished")
        }
    }
    
    @IBAction func startTypingLabel(_ button:UIButton){
        self.textLabel.typeText("hello world") {
            print("finished-label")
        }
    }
}
