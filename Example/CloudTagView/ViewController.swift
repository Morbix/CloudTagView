//
//  ViewController.swift
//  CloudTagView
//
//  Created by Henrique Morbin on 01/27/2016.
//  Copyright (c) 2016 Henrique Morbin. All rights reserved.
//

import UIKit
import CloudTagView

class ViewController: UIViewController {

    let cloudView = CloudTagView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cloudView.frame = CGRectMake(0, 20, view.frame.width, 10)
        cloudView.delegate = self
        view.addSubview(cloudView)
        
        addingNormalTags()
        addingSpecialTags()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    
    func addingNormalTags() {
        let normalTags = ["This", "is", "a", "example", "of", "Cloud", "Tag", "View"]
        
        for s in normalTags {
            cloudView.tags.append(TagView(text: s))
        }
    }
    
    func addingSpecialTags() {
        let normalTag = TagView(text: "normal tag")
        cloudView.tags.append(normalTag)
        
        let fatTag = TagView(text: "fat tag")
        fatTag.marginTop = 20
        cloudView.tags.append(fatTag)
        
        let longTag = TagView(text: "stretched tag")
        longTag.marginLeft = 40
        cloudView.tags.append(longTag)
        
        let trimmedTag = TagView(text: "This tag is a example of tag with a huge text.")
        trimmedTag.maxLength = 10
        cloudView.tags.append(trimmedTag)
        
        let otherNormalTag = TagView(text: "other normal tag")
        cloudView.tags.append(otherNormalTag)
    }
}

extension ViewController : TagViewDelegate {
    func tagDismissed(tag: TagView) {
        print("tag dismissed: " + tag.text)
    }
    
    func tagTouched(tag: TagView) {
        print("tag touched: " + tag.text)
    }
}

