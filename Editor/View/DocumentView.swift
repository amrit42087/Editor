//
//  DocumentView.swift
//  Editor
//
//  Created by Niklas Wallerstedt on 2020-06-18.
//  Copyright © 2020 Applikatur AB. All rights reserved.
//

import SwiftUI

struct DocumentView: View {
    var document: UIDocument
    var dismiss: () -> Void

    var body: some View {
        VStack {
            HStack {
                Text("File Name")
                    .foregroundColor(.secondary)

                Text(document.fileURL.lastPathComponent)
            }

            Button("Done", action: dismiss)
        }
    }
}
