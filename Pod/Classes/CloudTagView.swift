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
    public var resizeToFit = true
    
    public var tags = [TagView]() {
        didSet {
            layoutSubviews()
        }
    }
    public var padding = 5 {
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
        
        isUserInteractionEnabled = true
        clipsToBounds = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        isUserInteractionEnabled = true
        clipsToBounds = true
    }
    
    public override func layoutSubviews() {
        for tag in subviews {
            tag.removeFromSuperview()
        }
        
        var xAxis = padding
        var yAxis = padding
        var maxHeight = 0
        
        for (index, tag) in tags.enumerated() {
            
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
        
        if resizeToFit {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: CGFloat(yAxis+maxHeight+padding))
        }
    }
    
    // MARK: Methods
    
    private func setMaxLengthIfNeededIn(tag: TagView) {
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
    public var iconImage = UIImage(named: "close_tag_2", in: Bundle(for: CloudTagView.self), compatibleWith: nil) {
        didSet {
            layoutSubviews()
        }
    }
    public var maxLength = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    override public var backgroundColor: UIColor? {
        didSet {
            layoutSubviews()
        }
    }
    
    override public var tintColor: UIColor? {
        didSet {
            layoutSubviews()
        }
    }
    
    public var font: UIFont = UIFont.systemFont(ofSize: 12) {
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
        
        isUserInteractionEnabled = true
        
        addSubview(textLabel)
        addSubview(icon)
        addSubview(dismissView)
        
        dismissView.isUserInteractionEnabled = true
        textLabel.isUserInteractionEnabled = true
        
        dismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TagView.iconTapped)))
        textLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TagView.labelTapped)))
        
        backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        tintColor = UIColor.white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(text: String) {
        dismissView = UIView()
        icon = UIImageView()
        textLabel = UILabel()
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        isUserInteractionEnabled = true
        
        addSubview(textLabel)
        addSubview(icon)
        addSubview(dismissView)
        
        dismissView.isUserInteractionEnabled = true
        textLabel.isUserInteractionEnabled = true
        
        dismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TagView.iconTapped)))
        textLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TagView.labelTapped)))
        
        self.text = text
        
        backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        tintColor = UIColor.white
    }
    
    public override func layoutSubviews() {
        icon.frame = CGRect(x: marginLeft, y: marginTop+4, width: 8, height: 8)
        icon.image = iconImage?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = tintColor
        
        let textLeft: Int
        
        if let _ = icon.image {
            dismissView.isUserInteractionEnabled = true
            textLeft = marginLeft + Int(icon.frame.width ) + marginLeft/2
        } else {
            dismissView.isUserInteractionEnabled = false
            textLeft = marginLeft
        }
        
        textLabel.frame = CGRect(x: textLeft, y: marginTop, width: 100, height: 20)
        textLabel.backgroundColor = UIColor(white: 0, alpha: 0.0)
        if maxLength > 0 && text.characters.count > maxLength {
            textLabel.text = (text as NSString).substring(to: maxLength)+"..."
        }else{
            textLabel.text = text
        }
        textLabel.textAlignment = .center
        textLabel.font = font
        textLabel.textColor = tintColor
        textLabel.sizeToFit()
        
        let tagHeight = Int(max(textLabel.frame.height,14)) + marginTop*2
        let tagWidth = textLeft + Int(max(textLabel.frame.width,14)) + marginLeft
        
        let dismissLeft = Int(icon.frame.origin.x) + Int(icon.frame.width) + marginLeft/2
        dismissView.frame = CGRect(x: 0, y: 0, width: dismissLeft, height: tagHeight)
        
        frame = CGRect(x: Int(frame.origin.x), y: Int(frame.origin.y), width: tagWidth, height: tagHeight)
        layer.cornerRadius = bounds.height/2
    }
    
    // MARK: Actions
    
    func iconTapped(){
        delegate?.tagDismissed?(tag: self)
    }
    
    func labelTapped(){
        delegate?.tagTouched?(tag: self)
    }
    
}

// MARK: TagViewDelegate

@objc public protocol TagViewDelegate {
    
    @objc optional func tagTouched(tag : TagView)
    
    @objc optional func tagDismissed(tag: TagView)
    
}

extension CloudTagView : TagViewDelegate {
    
    public func tagDismissed(tag: TagView) {
        delegate?.tagDismissed?(tag: tag)
        
        if removeOnDismiss {
            if let index = tags.index(of: tag) {
                tags.remove(at: index)
            }
        }
    }
    
    public func tagTouched(tag: TagView) {
        delegate?.tagTouched?(tag: tag)
    }
    
}
