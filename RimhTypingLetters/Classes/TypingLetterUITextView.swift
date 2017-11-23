//
//  TypingLetterUITextView.swift
//  RimhTypingLetters
//
//  Created by ming on 2017/11/20.
//

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
