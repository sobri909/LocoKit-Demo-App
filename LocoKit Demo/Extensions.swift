//
//  Extensions.swift
//  LocoKit Demo
//
//  Created by Matt Greenfield on 5/8/22.
//

import SwiftUI

extension View {
    func alignVerticalCentre() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }

    func alignTop() -> some View {
        self.frame(maxHeight: .infinity, alignment: .top)
    }

    func alignBottom() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }

    func alignHorizontalCentre() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }

    func alignLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }

    func alignTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
}
