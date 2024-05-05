//
//  AnimatedTextView.swift
//  BlockbusterVault
//
//  Created by Dev on 15/03/2024.
//

import SwiftUI
import MarqueeText


struct AnimatedTextView: View {
    let text: String
    @State var foregroundColor: Color = .black
    var body: some View {
        MarqueeText(
            text: text,
            font: UIFont.preferredFont(forTextStyle: .title3),
            leftFade: 16,
            rightFade: 16,
            startDelay: 3,
            alignment: .center
        )
        .foregroundColor(foregroundColor)
    }
}

struct AnimatedTextView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTextView(text: "")
    }
}
