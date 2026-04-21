import SwiftUI

// MARK: - Oregon Trail Color Palette (from app icon)

enum TrailColor {
    static let desertSand     = Color(red: 0.831, green: 0.647, blue: 0.455)  // #D4A574
    static let coral          = Color(red: 0.910, green: 0.455, blue: 0.380)  // #E87461
    static let mountainBlue   = Color(red: 0.290, green: 0.565, blue: 0.643)  // #4A90A4
    static let darkEarth      = Color(red: 0.239, green: 0.169, blue: 0.122)  // #3D2B1F
    static let forestGreen    = Color(red: 0.357, green: 0.549, blue: 0.353)  // #5B8C5A
    static let sky            = Color(red: 0.529, green: 0.808, blue: 0.922)  // #87CEEB
    static let parchment      = Color(red: 0.961, green: 0.902, blue: 0.827)  // #F5E6D3
    static let deepBrown      = Color(red: 0.173, green: 0.094, blue: 0.063)  // #2C1810

    // Semantic aliases
    static let background     = parchment
    static let text           = deepBrown
    static let accent         = coral
    static let success        = forestGreen
    static let info           = mountainBlue
    static let warm           = desertSand
    static let border         = darkEarth
}

// MARK: - Retro Font Modifiers

struct RetroTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold, design: .monospaced))
            .foregroundStyle(TrailColor.text)
    }
}

struct RetroBodyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13, weight: .medium, design: .monospaced))
            .foregroundStyle(TrailColor.text)
    }
}

struct RetroCaptionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 11, weight: .regular, design: .monospaced))
            .foregroundStyle(TrailColor.text.opacity(0.7))
    }
}

struct RetroStatModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .bold, design: .monospaced))
            .foregroundStyle(TrailColor.text)
            .monospacedDigit()
    }
}

extension View {
    func retroTitle() -> some View { modifier(RetroTitleModifier()) }
    func retroBody() -> some View { modifier(RetroBodyModifier()) }
    func retroCaption() -> some View { modifier(RetroCaptionModifier()) }
    func retroStat() -> some View { modifier(RetroStatModifier()) }
}

// MARK: - Retro Panel Modifier

struct RetroPanelModifier: ViewModifier {
    var filled: Bool = true

    func body(content: Content) -> some View {
        content
            .padding(14)
            .background(filled ? TrailColor.parchment : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(TrailColor.darkEarth, lineWidth: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct RetroCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(TrailColor.parchment.opacity(0.8))
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .strokeBorder(TrailColor.darkEarth.opacity(0.6), lineWidth: 1.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}

extension View {
    func retroPanel(filled: Bool = true) -> some View {
        modifier(RetroPanelModifier(filled: filled))
    }
    func retroCard() -> some View {
        modifier(RetroCardModifier())
    }
}

// MARK: - Retro Button Style

struct RetroButtonStyle: ButtonStyle {
    var tint: Color = TrailColor.coral

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 13, weight: .bold, design: .monospaced))
            .foregroundStyle(TrailColor.parchment)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(configuration.isPressed ? tint.opacity(0.7) : tint)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .strokeBorder(TrailColor.darkEarth, lineWidth: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: 3))
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
    }
}

struct RetroSecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 12, weight: .medium, design: .monospaced))
            .foregroundStyle(TrailColor.text)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(configuration.isPressed ? TrailColor.desertSand.opacity(0.5) : TrailColor.desertSand.opacity(0.3))
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .strokeBorder(TrailColor.darkEarth.opacity(0.5), lineWidth: 1.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}

// MARK: - Retro Progress Bar

struct RetroProgressBar: View {
    let progress: Double
    var fillColor: Color = TrailColor.forestGreen
    var height: CGFloat = 18

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Background
                Rectangle()
                    .fill(TrailColor.darkEarth.opacity(0.15))

                // Fill
                Rectangle()
                    .fill(fillColor)
                    .frame(width: geo.size.width * min(CGFloat(progress), 1.0))
                    .animation(.easeInOut(duration: 0.5), value: progress)

                // Pixel grid overlay
                HStack(spacing: 2) {
                    ForEach(0..<Int(geo.size.width / 6), id: \.self) { _ in
                        Rectangle()
                            .fill(TrailColor.darkEarth.opacity(0.06))
                            .frame(width: 1)
                    }
                }
            }
            .overlay(
                Rectangle()
                    .strokeBorder(TrailColor.darkEarth, lineWidth: 2)
            )
        }
        .frame(height: height)
    }
}

// MARK: - Retro Divider

struct RetroDivider: View {
    var body: some View {
        Text(String(repeating: "\u{2550}", count: 40))
            .font(.system(size: 11, weight: .regular, design: .monospaced))
            .foregroundStyle(TrailColor.darkEarth.opacity(0.5))
            .lineLimit(1)
    }
}

// MARK: - Retro Section Header

struct RetroSectionHeader: View {
    let title: String

    var body: some View {
        VStack(spacing: 2) {
            RetroDivider()
            Text(title.uppercased())
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text)
                .tracking(2)
            RetroDivider()
        }
    }
}

// MARK: - Retro Stat Row (trail inventory style)

struct RetroStatRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 0) {
            Text(label)
                .font(.system(size: 13, weight: .medium, design: .monospaced))
                .foregroundStyle(TrailColor.text)
            Spacer()
                .overlay(
                    Text(String(repeating: ".", count: 40))
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .foregroundStyle(TrailColor.darkEarth.opacity(0.3))
                        .lineLimit(1)
                        .truncationMode(.tail)
                )
            Text(value)
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text)
                .monospacedDigit()
        }
    }
}

// MARK: - Retro Background

struct RetroBackground: View {
    var body: some View {
        ZStack {
            TrailColor.parchment
            // Subtle parchment texture using scanlines
            VStack(spacing: 3) {
                ForEach(0..<200, id: \.self) { _ in
                    Rectangle()
                        .fill(TrailColor.darkEarth.opacity(0.015))
                        .frame(height: 1)
                    Spacer().frame(height: 2)
                }
            }
        }
        .ignoresSafeArea()
    }
}
