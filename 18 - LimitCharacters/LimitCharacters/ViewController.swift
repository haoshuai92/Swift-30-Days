//
//  ViewController.swift
//  LimitCharacters
//
//  Created by Shuai Hao on 2019/9/23.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var bottomUIView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width * 0.5
        tweetTextView.backgroundColor = .clear
        
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.keyBoardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.keyBoardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyBoardWillShow(_ note:NSNotification) {
        let userInfo  = note.userInfo
        let keyBoardBounds = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        let animations = {
            self.bottomUIView.transform = CGAffineTransform(translationX: 0, y: -deltaY)
        }
        
        if duration > 0 {
            UIView.animate(withDuration: duration, delay: 0, options:[.beginFromCurrentState, .curveLinear], animations: animations, completion: nil)
        }else {
            animations()
        }
    }
    
    
    @objc func keyBoardWillHide(_ note: NSNotification) {
        let userInfo  = note.userInfo
        let duration = (userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations = {
            self.bottomUIView.transform = .identity
        }
        
        if duration > 0 {
            UIView.animate(withDuration: duration, delay: 0, options:[.beginFromCurrentState, .curveLinear], animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
    


}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputTextLength = text.count - range.length + tweetTextView.text.count
        if inputTextLength > 140 {
            return false
        }
        characterCountLabel.text = "\(140 - inputTextLength)"
        return true
    }
}

