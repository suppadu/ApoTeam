//
//  CustomTextField.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 04.12.2021.
//

import UIKit
import SnapKit

class GroupedTextFields: UIView {
    
    private let title = UILabel()
    var arrayTF: [UITextField] = []
    var height: Int = 50
    
    init(_ title: String, placeholders: [String], delegate: UITextFieldDelegate) {
        height = placeholders.count * 35 + height
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        self.title.text = title
        self.title.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
        self.title.textColor = .blue
        self.addSubview(self.title)
        self.title.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.width.equalToSuperview()
        }
        
        var offset = 10
        var i = 0
        for placeholder in placeholders {
            let tf = UITextField()
            tf.placeholder = placeholder
            tf.delegate = delegate
            tf.tag = i
            i += 1
            self.addSubview(tf)
            tf.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(10)
                make.top.equalTo(self.title.snp.bottom).offset(offset)
                make.width.equalToSuperview().multipliedBy(0.95)
            }
            offset += 32
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
