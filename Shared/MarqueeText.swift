//
//  MarqueeText.swift
//  AdaptrDemo
//
//  Created by Arveen kumar on 01/02/2021.
//

import SwiftUI


extension String {

   func widthOfString(usingFont font: UIFont) -> CGFloat {
       let fontAttributes = [NSAttributedString.Key.font: font]
       let size = self.size(withAttributes: fontAttributes)
       return size.width
   }

   func heightOfString(usingFont font: UIFont) -> CGFloat {
       let fontAttributes = [NSAttributedString.Key.font: font]
       let size = self.size(withAttributes: fontAttributes)
       return size.height
   }

   func sizeOfString(usingFont font: UIFont) -> CGSize {
       let fontAttributes = [NSAttributedString.Key.font: font]
       return self.size(withAttributes: fontAttributes)
   }
}

struct MarqueeText : View {
    
var text = ""
public init(text: String) {
    self.text = text
}
@State private var animate = false
    
    private let animationOne = Animation.linear(duration: 5).delay(1.0).repeatCount(2, autoreverses: false)
    var body : some View {
        let stringWidth = text.widthOfString(usingFont: UIFont.systemFont(ofSize: 15))
        return ZStack {
                GeometryReader { geometry in
                    Text(self.text).lineLimit(1)
                        .font(.subheadline)
                        .offset(x: self.animate ? -stringWidth * 2 : 0)
                        .animation(self.animationOne)
                        .onAppear() {
                            if geometry.size.width < stringWidth {
                                 self.animate = true
                            }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0 , maxHeight: .infinity, alignment: .topLeading)

                    Text(self.text).lineLimit(1)
                        .font(.subheadline)
                        .offset(x: self.animate ? 0 : stringWidth * 3)
                        .animation(self.animationOne)
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(minWidth: 0, maxWidth: .infinity,minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            }
        }.padding().clipped().clipShape(Rectangle())
    }
    
}


struct MarqueeText_Previews: PreviewProvider {
    static var previews: some View {
        MarqueeText(text:"")
    }
}
