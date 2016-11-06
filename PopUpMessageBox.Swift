//
//  Created by K&
//  kenanatmaca.com
//  Copyright © 2016 Kenan Atmaca. All rights reserved.
//

import UIKit


class PopUpMessageBox:NSObject,UITextViewDelegate {
    
    fileprivate var contentView:UIView!
    fileprivate var msgView:UIView!
    fileprivate var msgViewImage:UIImageView!
    fileprivate var msgViewNoticeLabel:UILabel!
    fileprivate var backgroundView:CAShapeLayer!
    fileprivate var msgTextView:UITextView!
    fileprivate var msgSendButton:UIButton!
    fileprivate var msgCancelButton:UIButton!
    fileprivate var layoutConstContent:LayoutConstraints!
    
    fileprivate var msgImg:UIImage!
    fileprivate var msgTitleText:String?
    fileprivate var sendButtonTitle:String?
    fileprivate var cancelButtonTitle:String?
    fileprivate var sendButtonColor:UIColor?
    fileprivate var cancelButtonColor:UIColor?
    
    var msgText:String? {
        get {
            return msgTextView.text ?? ""
        }
    }
    
    init(to view:UIView,icon:UIImage,title:String) {
        
        self.contentView = view
        self.msgImg = icon
        self.msgTitleText = title
        
    }
    
    init(to view:UIView,icon:UIImage,title:String,sendTitle:String,cancelTitle:String) {
        
        self.contentView = view
        self.msgImg = icon
        self.msgTitleText = title
        self.sendButtonTitle = sendTitle
        self.cancelButtonTitle = cancelTitle
        
    }
    
    init(to view:UIView,icon:UIImage,title:String,sendTitle:String,cancelTitle:String,sendColor:UIColor,cancelColor:UIColor) {
        
        self.contentView = view
        self.msgImg = icon
        self.msgTitleText = title
        self.sendButtonTitle = sendTitle
        self.cancelButtonTitle = cancelTitle
        self.sendButtonColor = sendColor
        self.cancelButtonColor = cancelColor
        
    }
    
    private func addBlackScreen() {
        
        let bPath = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size))
        
        backgroundView = CAShapeLayer()
        backgroundView.path = bPath.cgPath
        backgroundView.fillColor = UIColor.black.withAlphaComponent(0.5).cgColor
        
        contentView.layer.addSublayer(backgroundView)
        
    }
    
    func setup() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboardState), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        addBlackScreen()
        
        setupMsgView()
        setupMsgViewImage()
        setupMsgViewLabel()
        setupMsgTextView()
        setupMsgButtons()
        
        addAnimation()
        
        // Content View Const
        
        layoutConstContent = LayoutConstraints(to: contentView)
        
        layoutConstContent.width(item: msgView, value: 300)
        layoutConstContent.height(item: msgView, value: 300)
        layoutConstContent.centerX(item: msgView, toItem: contentView)
        layoutConstContent.centerY(item: msgView, toItem: contentView)
        
        // MsgBox Image
        layoutConstContent.width(item: msgViewImage, value: 64)
        layoutConstContent.height(item: msgViewImage, value: 64)
        layoutConstContent.top(item: msgViewImage, toItem: msgView, value: 30)
        layoutConstContent.centerX(item: msgViewImage, toItem: msgView)
        
        
        //MsgBox Label
        layoutConstContent.width(item: msgViewNoticeLabel, value: 200)
        layoutConstContent.height(item: msgViewNoticeLabel, value: 40)
        layoutConstContent.top(item: msgViewNoticeLabel, toItem: msgViewImage, value: 65)
        layoutConstContent.centerX(item: msgViewNoticeLabel, toItem: msgViewImage)
        
        //MsgBox TextView
        layoutConstContent.width(item: msgTextView, value: 260)
        layoutConstContent.height(item: msgTextView, value: 70)
        layoutConstContent.top(item: msgTextView, toItem: msgViewNoticeLabel, value: 50)
        layoutConstContent.centerX(item: msgTextView, toItem: msgViewNoticeLabel)
        
        //MsgButtons
        
        layoutConstContent.width(item: msgSendButton, value: 130)
        layoutConstContent.height(item: msgSendButton, value: 40)
        layoutConstContent.top(item: msgSendButton, toItem: msgTextView, value: 90)
        layoutConstContent.left(item: msgSendButton, toItem: msgView, value: 15)
        
        layoutConstContent.width(item: msgCancelButton, value: 130)
        layoutConstContent.height(item: msgCancelButton, value: 40)
        layoutConstContent.top(item: msgCancelButton, toItem: msgTextView, value: 90)
        layoutConstContent.right(item: msgCancelButton, toItem: msgView, value: -15)
        
        
        layoutConstContent.final()
        
    }
    
    private func setupMsgView() {
        
        msgView = UIView()
        msgView.backgroundColor = UIColor.RGBcolor(red: 240, green: 240, blue: 236, alpha: 1.0)
        msgView.layer.masksToBounds = false
        msgView.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        msgView.layer.shadowRadius = 2
        msgView.layer.shadowOffset = CGSize(width: 1, height: 2)
        msgView.layer.shadowOpacity = 1.5
        
        msgView.layer.cornerRadius = 7
        msgView.layer.zPosition = 1
        
        contentView.addSubview(msgView)
        
        self.msgView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        
    }
    
    private func setupMsgViewImage() {
        
        msgViewImage = UIImageView()
        msgViewImage.image = self.msgImg
        msgViewImage.contentMode = .scaleAspectFill
        msgViewImage.layer.zPosition = 1
        
        contentView.addSubview(msgViewImage)
    }
    
    private func setupMsgViewLabel() {
        
        msgViewNoticeLabel = UILabel()
        msgViewNoticeLabel.text = self.msgTitleText ?? "Message Send"
        msgViewNoticeLabel.layer.zPosition = 1
        msgViewNoticeLabel.font = UIFont(name: "Avenir-Medium", size: 17)
        msgViewNoticeLabel.textColor = UIColor.gray
        msgViewNoticeLabel.textAlignment = .center
        
        contentView.addSubview(msgViewNoticeLabel)
        
    }
    
    
    private func setupMsgTextView() {
        
        msgTextView = UITextView()
        msgTextView.delegate = self
        msgTextView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        msgTextView.font = UIFont.boldSystemFont(ofSize: 16)
        msgTextView.textColor = UIColor.darkGray
        msgTextView.alpha = 0.8
        msgTextView.layer.zPosition = 1
        msgTextView.layer.cornerRadius = 10
        
        msgTextView.layer.masksToBounds = false
        msgTextView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        msgTextView.layer.shadowRadius = 10
        msgTextView.layer.shadowOffset = CGSize.zero
        msgTextView.layer.shadowOpacity = 1
        
        contentView.addSubview(msgTextView)
        
    }
    
    
    private func setupMsgButtons() {
        
        msgSendButton = UIButton()
        msgSendButton.backgroundColor = self.sendButtonColor ?? UIColor.RGBcolor(red: 32, green: 175, blue: 173, alpha: 1)
        msgSendButton.setTitle(self.sendButtonTitle ?? "Send", for: .normal)
        msgSendButton.setTitleColor(UIColor.white, for: .normal)
        msgSendButton.titleLabel?.font = UIFont(name: "Avenir-Next", size: 17)
        msgSendButton.layer.zPosition = 2
        msgSendButton.layer.cornerRadius = 7
        
        contentView.addSubview(msgSendButton)
        
        msgCancelButton = UIButton()
        msgCancelButton.backgroundColor = self.cancelButtonColor ?? UIColor.RGBcolor(red: 175, green: 32, blue: 72, alpha: 1)
        msgCancelButton.setTitle(self.cancelButtonTitle ?? "Cancel", for: .normal)
        msgCancelButton.setTitleColor(UIColor.white, for: .normal)
        msgCancelButton.titleLabel?.font = UIFont(name: "Avenir-Next", size: 17)
        msgCancelButton.layer.zPosition = 2
        msgCancelButton.layer.cornerRadius = 7
        
        contentView.addSubview(msgCancelButton)
        
    }
    
    private func addAnimation() {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {() in
            
            self.msgView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
        }, completion: nil)
        
    }
    
    func addSendHandle(target:Any?,selector:Selector) {
        
        msgSendButton.addTarget(target, action: selector, for: .touchUpInside)
        
    }
    
    func addCancelHandle(target:Any?,selector:Selector) {
        
        msgCancelButton.addTarget(target, action: selector, for: .touchUpInside)
        
    }
    
    func remove() {
        
        layoutConstContent.clearConstraints()
        msgView.removeFromSuperview()
        msgViewImage.removeFromSuperview()
        msgViewNoticeLabel.removeFromSuperview()
        backgroundView.removeFromSuperlayer()
        msgTextView.removeFromSuperview()
        msgSendButton.removeFromSuperview()
        msgCancelButton.removeFromSuperview()
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n") {
            
            textView.resignFirstResponder()
            layoutConstContent.clearLastConstraints()
            return false
        }
        
        return true
        
    }
    
    
    func showKeyboardState(notification: Notification) {
        
        layoutConstContent.top(item: msgView, toItem: contentView, value: 60)
        layoutConstContent.final()
        
    }
    
    
}//

extension UIColor {
    
    static func RGBcolor(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
        
    }
    
}
