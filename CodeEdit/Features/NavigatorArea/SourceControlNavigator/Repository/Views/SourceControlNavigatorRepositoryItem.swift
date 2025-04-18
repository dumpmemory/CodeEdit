//
//  SourceControlNavigatorRepositoriesItem.swift
//  CodeEdit
//
//  Created by Austin Condiff on 11/29/23.
//

import SwiftUI

struct SourceControlNavigatorRepositoryItem: View {
    @AppSettings(\.general.fileIconStyle)
    var fileIconStyle

    let item: RepoOutlineGroupItem

    @Environment(\.controlActiveState)
    var controlActiveState

    var body: some View {
        Label(title: {
            Text(item.label)
                .lineLimit(1)
                .truncationMode(.middle)
            if let description = item.description {
                Text(description)
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                    .font(.system(size: 11))
                    .layoutPriority(-1)
            }
            Spacer()
            HStack(spacing: 5) {
                if let behind = item.branch?.behind, behind > 0 {
                    HStack(spacing: 0) {
                        Image(systemName: "arrow.down")
                            .imageScale(.small)
                        Text("\(behind)")
                            .font(.system(size: 11))
                    }
                }
                if let ahead = item.branch?.ahead, ahead > 0 {
                    HStack(spacing: 0) {
                        Image(systemName: "arrow.up")
                            .imageScale(.small)
                        Text("\(ahead)")
                            .font(.system(size: 11))
                    }
                }
            }
        }, icon: {
            Group {
                switch item.image {
                case .system(let name):
                    Image(systemName: name)
                case .symbol(let name):
                    Image(symbol: name)
                }
            }
            .opacity(controlActiveState == .inactive ? 0.5 : 1)
            .foregroundStyle(fileIconStyle == .color ? item.imageColor : Color.coolGray)
        })
        .padding(.leading, 1)
        .padding(.vertical, -1)
    }
}
