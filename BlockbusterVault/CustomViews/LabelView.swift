//
//  LabelView.swift
//  BlockbusterVault
//
//  Created by Dev on 15/03/2024.
//

import SwiftUI
import MarqueeText

struct LabelView: View {
    let text: String
    let font: Font
    @State var isBold: Bool = false
    @State var foregroundColor: Color = .black
    var body: some View {
        Text(text)
            .font(font)
            .bold(isBold)
            .foregroundColor(foregroundColor)
    }
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(text: "", font: .callout)
    }
}
