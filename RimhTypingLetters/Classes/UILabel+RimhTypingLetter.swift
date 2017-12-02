//
// UILabel+RimhTypingLetter.swift
// RimhTypingLetters
//
// Created by ming on 2017/11/20.
//
// The MIT License (MIT)
//
// Copyright (c) 2017 Rimh(Ming) To (https://github.com/rimh/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
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
