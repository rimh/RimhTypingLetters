//
// TypingLetterUITextView.swift
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

open class TypingLetterUITextView: UITextView {
    
    open var typingTask:DispatchWorkItem?
    open var isTyping:Bool = false
    
    open func updateTypingTextView(_ character:Character){
        self.text = self.text! + String(character)
    }
    
    open func cleanupAfterFinishedTyping(){
        self.typingTask = nil
        isTyping = false
    }
    
    open func typeText(_ content: String, delimiter:String? = nil, typingSpeedPerChar: TimeInterval = 0.04, didResetContent:Bool = true, completeCallback:(()->Void)?) {
        
        let content = breakToLines(content,delimiter)

        if isTyping {
            self.typingTask?.cancel()
            self.typingTask = nil
            isTyping = false
        }
        
        if (didResetContent){
            self.text = ""
        }
        
        if content.count == 0{
            completeCallback?()
        }
        
        self.typingTask = DispatchWorkItem { [weak self] in
            self?.isTyping = true
            for character in content {
                if self?.isTyping == false{
                    break
                }
                DispatchQueue.main.async {
                    self?.updateTypingTextView(character)
                }
                Thread.sleep(forTimeInterval: typingSpeedPerChar)
            }
            completeCallback?()
            self?.cleanupAfterFinishedTyping()
        }
        if let task = self.typingTask {
            let queue = DispatchQueue(label: "rimhTypingLetter", qos: DispatchQoS.userInteractive)
            queue.asyncAfter(deadline: .now() + 0.1, execute: task)
        }
    }

    open func breakToLines (_ message:String, _ delimiter:String? = " ") ->String {
        var wordLength:CGFloat = 0.0
        let limit = self.bounds.size.width - (self.textContainer.lineFragmentPadding * 2) // roughly calculate the available text-area
        let words = delimiter != nil ? message.components(separatedBy: delimiter!) : message.map { String($0) }
        var copyone = Array<String>()
        var lineLength:CGFloat = 0.0
        let space:CGFloat = delimiter != nil ? (delimiter?.size(withAttributes: [.font: font!]).width)! : 0.0
        for word in words
        {
            wordLength = word.size(withAttributes: [.font: font!]).width
            let nextLength = lineLength + wordLength + space
            if nextLength > limit
            {
                copyone.append("\n")
                lineLength = wordLength + space
            }
            else
            {
                lineLength = nextLength
            }
            copyone.append(word)
        }
        let joined = copyone.joined(separator: delimiter != nil ? delimiter! : "")
        return delimiter != nil ? joined.replacingOccurrences(of: "\n"+delimiter!, with: "\n") : joined // remove extra delimiter in \n
    }
}
