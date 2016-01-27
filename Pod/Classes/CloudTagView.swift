//
//  FilterTagView.swift
//  Experian
//
//  Created by Henrique Morbin on 30/12/15.
//  Copyright © 2015 ilegra. All rights reserved.
//

import UIKit

public class CloudTagView: UIView {
    
    public weak var delegate : TagViewDelegate?
    
    public var removeOnDismiss = true
    
    public var tags = [TagView](){
        didSet {
            layoutSubviews()
        }
    }
    public var padding = 5{
        didSet {
            layoutSubviews()
        }
    }
    public var maxLengthPerTag = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        for tag in subviews {
            tag.removeFromSuperview()
        }
        
        var xAxis = padding
        var yAxis = padding
        var maxHeight = 0
        
        for (index, tag) in tags.enumerate() {
            
            setMaxLengthIfNeededIn(tag: tag)
            
            tag.delegate = self
            
            
            if index == 0 {
                maxHeight = Int(tag.frame.height)
            }else{
                let expectedWidth = xAxis + Int(tag.frame.width) + padding
                
                if expectedWidth > Int(frame.width) {
                    yAxis += maxHeight + padding
                    xAxis = padding
                    maxHeight = Int(tag.frame.height)
                }
                
                if Int(tag.frame.height) > maxHeight {
                    maxHeight = Int(tag.frame.height)
                }
            }
            
            tag.frame = CGRect(x: xAxis, y: yAxis, width: Int(tag.frame.size.width), height: Int(tag.frame.size.height))
            addSubview(tag)
            tag.layoutIfNeeded()
            xAxis += Int(tag.frame.width) + padding
        }
    }
    
    // MARK: Methods
    
    private func setMaxLengthIfNeededIn(tag tag: TagView){
        if maxLengthPerTag > 0 && tag.maxLength != maxLengthPerTag {
            tag.maxLength = maxLengthPerTag
        }
    }
}

public class TagView: UIView {
    
    public weak var delegate : TagViewDelegate?
    
    public var text = "" {
        didSet {
            layoutSubviews()
        }
    }
    public var marginTop = 5 {
        didSet {
            layoutSubviews()
        }
    }
    public var marginLeft = 10 {
        didSet {
            layoutSubviews()
        }
    }
    public var iconImage = UIImage(named: "close_tag_2") {
        didSet {
            layoutSubviews()
        }
    }
    public var maxLength = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    private let dismissView : UIView
    private let icon : UIImageView
    private let textLabel : UILabel
    
    public override init(frame: CGRect) {
        
        dismissView = UIView()
        icon = UIImageView()
        textLabel = UILabel()
        
        super.init(frame: frame)
        
        addSubview(textLabel)
        addSubview(icon)
        addSubview(dismissView)
        
        dismissView.userInteractionEnabled = true
        textLabel.userInteractionEnabled = true
        
        dismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "iconTapped"))
        textLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "labelTapped"))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(text: String){
        
        dismissView = UIView()
        icon = UIImageView()
        textLabel = UILabel()
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        addSubview(textLabel)
        addSubview(icon)
        addSubview(dismissView)
        
        dismissView.userInteractionEnabled = true
        textLabel.userInteractionEnabled = true
        
        dismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "iconTapped"))
        textLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "labelTapped"))
        
        self.text = text
    }
    
    public override func layoutSubviews() {
        icon.frame = CGRect(x: marginLeft, y: marginTop+4, width: 8, height: 8)
        icon.image = iconImage?.imageWithRenderingMode(.AlwaysTemplate)
        icon.tintColor = UIColor.whiteColor()
        
        let textLeft = marginLeft + Int(icon.frame.width ?? 0) + marginLeft/2
        
        textLabel.frame = CGRect(x: textLeft, y: marginTop, width: 100, height: 20)
        textLabel.backgroundColor = UIColor(white: 0, alpha: 0.0)
        if maxLength > 0 && text.characters.count > maxLength {
            textLabel.text = (text as NSString).substringToIndex(maxLength)+"..."
        }else{
            textLabel.text = text
        }
        textLabel.textAlignment = .Center
        textLabel.font = UIFont.systemFontOfSize(12)
        textLabel.textColor = UIColor.whiteColor()
        textLabel.sizeToFit()
        
        let tagHeight = Int(max(textLabel.frame.height,14)) + marginTop*2
        let tagWidth = textLeft + Int(max(textLabel.frame.width,14)) + marginLeft
        
        let dismissLeft = Int(icon.frame.origin.x) + Int(icon.frame.width) + marginLeft/2
        dismissView.frame = CGRect(x: 0, y: 0, width: dismissLeft, height: tagHeight)
        
        frame = CGRect(x: Int(frame.origin.x), y: Int(frame.origin.y), width: tagWidth, height: tagHeight)
        backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        layer.cornerRadius = bounds.height/2
    }
    
    // MARK: Actions 
    
    private func iconTapped(){
        delegate?.tagDismissed?(self)
    }
    
    private func labelTapped(){
        delegate?.tagTouched?(self)
    }
}

// MARK: TagViewDelegate

@objc public protocol TagViewDelegate {
    optional func tagTouched(tag : TagView)
    optional func tagDismissed(tag: TagView)
}

extension CloudTagView : TagViewDelegate {
    public func tagDismissed(tag: TagView) {
        delegate?.tagDismissed?(tag)
        
        if removeOnDismiss {
            if let index = tags.indexOf(tag) {
                tags.removeAtIndex(index)
            }
        }
    }
    
    public func tagTouched(tag: TagView) {
        delegate?.tagTouched?(tag)
    }
}
