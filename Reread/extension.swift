//
//  extension.swift
//  Reread
//
//  Created by 近藤大翔 on 2018/07/12.
//  Copyright © 2018年 近藤大翔. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    func mask(image: UIImage?) -> UIImage {
        if let maskRef = image?.cgImage,
            let ref = cgImage,
            let mask = CGImage(maskWidth: maskRef.width,
                               height: maskRef.height,
                               bitsPerComponent: maskRef.bitsPerComponent,
                               bitsPerPixel: maskRef.bitsPerPixel,
                               bytesPerRow: maskRef.bytesPerRow,
                               provider: maskRef.dataProvider!,
                               decode: nil,
                               shouldInterpolate: false),
            let output = ref.masking(mask) {
            return UIImage(cgImage: output)
        }
        return self
    }
    
//    func blacked(inverse: Bool = false) -> UIImage? {
//        if inverse {
//            guard let mask = UIImage.empty(size: size, color: .white)?.masked(with: self)?.withSettingBackground(color: .black) else {
//                return nil
//            }
//            return UIImage.empty(size: size, color: .black)?.masked(with: mask)
//        } else {
//            return UIImage.empty(size: size, color: .black)?.masked(with: self)
//        }
//    }
}
