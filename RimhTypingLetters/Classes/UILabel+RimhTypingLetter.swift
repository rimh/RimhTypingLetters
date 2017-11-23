//
//  UILabel+RimhTypingLetter.swift
//  RimhTypingLetters
//
//  Created by ming on 2017/11/20.
//

import UIKit
public extension UILabel{
    public func typeText(_ content: String, typingSpeedPerChar: TimeInterval = 0.04, didResetContent:Bool = true, completeCallback:(()->Void)?) {
        if (didResetContent){
            self.text = ""
        }
        
        if content.count == 0{
            completeCallback?()
        }
        DispatchQueue.global(qos: .userInteractive).async {
            for character in content {
                DispatchQueue.main.async {
                    self.text = self.text! + String(character)
                }
                Thread.sleep(forTimeInterval: typingSpeedPerChar)
            }
            completeCallback?()
        }
    }
}
