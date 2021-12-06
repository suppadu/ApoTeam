//
//  Extensions.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 06.12.2021.
//

import UIKit

extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
