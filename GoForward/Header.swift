//
//  GeneralHeader.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct Header: View {
    @EnvironmentObject var pageMV: PageViewModel
    let title: String
    
    var body: some View {
        ZStack {
            HStack {
                GoBack(action: pageMV.visitMenu)
                Spacer()
            }
            
            Text(title).font(.headline)
        }
        .padding()
        .background(.bar)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(title: "Title")
    }
}
