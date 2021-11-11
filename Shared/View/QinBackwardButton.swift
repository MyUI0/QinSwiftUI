//
//  QinBackwardButton.swift
//  Qin
//
//  Created by 林少龙 on 2021/11/12.
//

import SwiftUI

public struct QinBackwardButton: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    public var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            QinSFView(systemName: "chevron.backward" ,size: .medium)
        }
        .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
    }
}

#if DEBUG
struct QinBackwardButton_Previews: PreviewProvider {
    static var previews: some View {
        QinBackwardButton()
    }
}
#endif
