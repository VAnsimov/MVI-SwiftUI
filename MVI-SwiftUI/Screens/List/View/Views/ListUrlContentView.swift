//
//  ListUrlContentView.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

struct ListUrlContentView: View {

    struct StateViewModel: Hashable {
        let id: String
        let title: String
    }

    @State var state: StateViewModel
    var didTap: (_ id: String) -> Void

    var body: some View {
        Button(action: { self.didTap(self.state.id) }, label: {
            ZStack {
                Color(.sRGB, red: 250/255, green: 250/255, blue: 254/255, opacity: 1)
                    .cornerRadius(14)
                    .shadow(color: Color(.sRGB, white: 0, opacity: 0.15),
                            radius: 4, x: 1, y: 1)

                Text(state.title)
                    .foregroundColor(.black)
                    .padding()
            }
        })
    }
}

#if DEBUG
// MARK: - Previews

struct ListUrlContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListUrlContentView(state: .init(id: "ListUrlContentView_Previews",
                                        title: "Demystify SwiftUI"),
                           didTap: { _ in })
    }
}
#endif
