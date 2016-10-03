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

    @IBOutlet weak var addTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        cloudView.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 10)
        cloudView.delegate = self

        view.addSubview(cloudView)

        addingNormalTags()
        addingSpecialTags()
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

        let trimmedTag = TagView(text: "Trimmed: This tag is a example of tag with a huge text.")
        trimmedTag.maxLength = 15
        cloudView.tags.append(trimmedTag)

        let noIconTag = TagView(text: "tag without dismiss icon")
        noIconTag.iconImage = nil
        cloudView.tags.append(noIconTag)

        let otherNormalTag = TagView(text: "other normal tag")
        cloudView.tags.append(otherNormalTag)

        let differentFontTag = TagView(text: "different font tag")
        differentFontTag.font = UIFont(name: "Baskerville", size: 12)!
        cloudView.tags.append(differentFontTag)
        
        let coloredTag = TagView(text: "colored tag")
        coloredTag.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        cloudView.tags.append(coloredTag)

        let tintColorTag = TagView(text: "tint color tag")
        tintColorTag.tintColor = UIColor.yellow
        cloudView.tags.append(tintColorTag)
    }

    // MARK: Actions

    @IBAction func clearAllTouched(_ sender: AnyObject) {
        cloudView.tags.removeAll()
    }

    @IBAction func addTouched(_ sender: AnyObject) {
        cloudView.tags.append(TagView(text: addTextField.text!))
    }
}

extension ViewController : TagViewDelegate {
    func tagDismissed(_ tag: TagView) {
        print("tag dismissed: " + tag.text)
    }

    func tagTouched(_ tag: TagView) {
        print("tag touched: " + tag.text)
    }
}
