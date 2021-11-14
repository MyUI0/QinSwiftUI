//
//  NEUButtonStyle.swift
//  Qin
//
//  Created by 林少龙 on 2021/11/10.
//

import SwiftUI

public protocol NEUButtonStyle: ButtonStyle, NEUStyle {
    
}

public struct NEUDefaultButtonStyle<S: Shape>: NEUButtonStyle {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let shape: S
    let toggle: Bool
    
    init (shape: S, toggle: Bool = false) {
        self.shape = shape
        self.toggle = toggle
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed || toggle ? 0.9 : 1.0)
            .contentShape(shape)
            .background(
                GeometryReader { geometry in
                    let backgroundColors: [Color] = neuBacgroundColors(colorScheme)
                    let pressedBackgroundColors: [Color] = neuPressedBacgroundColors(colorScheme)
                    
                    if configuration.isPressed || toggle {
                        shape.fill(                            LinearGradient(gradient: Gradient(colors: pressedBackgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                    }else {
                        shape.fill(LinearGradient(gradient: Gradient(colors: backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .modifier(NEUShadowModifier())
                    }
                }
            )
    }
}

public struct NEUBorderButtonStyle<S: Shape>: NEUButtonStyle {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let shape: S
    let toggle: Bool
    
    init (shape: S, toggle: Bool = false) {
        self.shape = shape
        self.toggle = toggle
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed || toggle ? 0.9 : 1.0)
            .contentShape(shape)
            .background(
                GeometryReader { geometry in
                    
                    let backgroundColors: [Color] = colorScheme == .light ? Color.lightBackgroundColors : Color.darkBackgroundColors
                    let pressedBackgroundColors: [Color] = backgroundColors.reversed()
                    
                    if !configuration.isPressed && !toggle {
                        LinearGradient(gradient: Gradient(colors: backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .modifier(NEUBorderModifier(shape: shape))
                    } else {
                        LinearGradient(gradient: Gradient(colors: pressedBackgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(shape)

                    }
                }
            )
    }
}

public struct NEUConvexBorderButtonStyle<S: Shape>: NEUButtonStyle {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let shape: S
    let toggle: Bool
    
    init (shape: S, toggle: Bool = false) {
        self.shape = shape
        self.toggle = toggle
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed || toggle ? 0.9 : 1.0)
            .contentShape(shape)
            .background(
                GeometryReader { geometry in
                    let minLength: CGFloat = min(geometry.size.width, geometry.size.height)
                    
                    let backgroundColors: [Color] = colorScheme == .light ? Color.lightBackgroundColors : Color.darkBackgroundColors
                    
                    let borderColors: [Color] = neuBorderColors(colorScheme)
                    let borderStrokeWidth: CGFloat = minLength / 15
                    
                    let strokeWidth: CGFloat = minLength / 20
                    let topLeftStrokeColor: Color = colorScheme == .light ? .white : .white.opacity(0.11)
                    
                    shape.fill(LinearGradient(colors: backgroundColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                        .modifier(NEUShadowModifier())
                    shape.stroke(LinearGradient(colors: borderColors, startPoint: .topLeading, endPoint: .bottomTrailing),
                                 lineWidth: borderStrokeWidth)
                    
                    if !configuration.isPressed && !toggle {
                        shape.stroke(topLeftStrokeColor, lineWidth: strokeWidth)
                            .blur(radius: 1)
                            .offset(x: strokeWidth, y: strokeWidth)
                            .mask(shape.padding(borderStrokeWidth / 2))
                    }
                }
            )
    }
}

#if DEBUG
fileprivate struct NEUButtonStyleDebugView: View {
    @State private var onOff = false
    
    var body: some View {
        ZStack {
            NEUBackgroundView()
            VStack(spacing: 50.0) {
                HStack(spacing: 20) {
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUDefaultButtonStyle(shape: Circle(), toggle: onOff))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUDefaultButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous)))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUDefaultButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous), toggle: onOff))

                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUBorderButtonStyle(shape: Circle()))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUBorderButtonStyle(shape: Circle(), toggle: onOff))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUBorderButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous)))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUBorderButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous), toggle: onOff))

                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUConvexBorderButtonStyle(shape: Circle()))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUConvexBorderButtonStyle(shape: Circle(), toggle: onOff))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUConvexBorderButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous)))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        QinSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUConvexBorderButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous), toggle: onOff))

                }
            }
        }
    }
}

struct NEUButtonStyle_Previews: PreviewProvider {
    
    static var previews: some View {
        NEUButtonStyleDebugView()
            .preferredColorScheme(.light)
        NEUButtonStyleDebugView()
            .preferredColorScheme(.dark)
    }
}
#endif
