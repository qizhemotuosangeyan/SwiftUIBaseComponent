//
//  MainView.swift
//  SwiftUIBaseComponments
//
//  Created by 千千 on 7/26/24.
//

import SwiftUI

enum Componment: String {
    case button
    case picker
    
    
    var id: String { self.rawValue }
    var displayName: String {
        switch self {
        case .button:
            return "Button"
        case .picker:
            return "Picker"
        }
    }
}

struct MainView: View {
    //TODO: 这里开发结束后记得改回nil
    @State private var selectedItem: Componment? = .button
    var body: some View {
        NavigationSplitView {
            SidebarView(item: $selectedItem)
        } detail: {
            DetailView(item: $selectedItem)
        }
    }
}

struct SidebarView: View {
    @Binding var item: Componment?
    let items: [Componment] = [.button, .picker]

    var body: some View {
        List(items, id: \.self, selection: $item) { i in
            Text(i.displayName)
        }
        .navigationTitle("SwiftUI标准控件")
    }
}

struct DetailView: View {
    @Binding var item: Componment?
    var body: some View {
        if let item = item {
            switch item {
            case .button:
                ButtonPreview()
            case .picker:
                PickerPreview()
            }
        } else {
            Text("选择一个控件查看预览")
                .navigationTitle("预览")
        }
    }
}
struct ButtonPreview: View {
    var body: some View {
        LazyVGrid(columns: [GridItem()]) {
            Divider()
            Text("Button基础样式\n会固定字体，提供foreground和background等常见API")
            Button("Base Text Button") {
                print("tap")
            }
            Button("Button with systemImage", systemImage: "button.programmable") {}
            Button("Button with simple config") {}
                .foregroundStyle(.green)
                .background(.orange)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            Divider()
            Text("可以通过自定义Button的ShadowStyle的方式来实现自定义按钮")
            Button("Scale and shadow Button") {}
                .buttonStyle(ShadowScaleStyle())
            ZStack {
                Color.blue
                Button("Button like Duolinguo") {}
                    .buttonStyle(BottomShadowStyle())
            }
            .frame(width: 300,height: 140)
        }
    }
}

// 对于自定义按钮，只需要自定义按钮的ButtonSytle即可，通过实现ButtonStyle协议的makeBody方法，即可享受Button的自带属性与能力
struct ShadowScaleStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .font(.custom("Arial", size: 20)) // 自定义字体
            .shadow(color: .black.opacity(configuration.isPressed ? 0.4 : 0), radius: configuration.isPressed ? 10 : 0, x: 0, y: configuration.isPressed ? 5 : 0) // 按下时的阴影
            .scaleEffect(configuration.isPressed ? 0.7 : 1.0) // 按下时的缩放效果
    }
}

struct BottomShadowStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let offset = configuration.isPressed ? CGSize.zero : CGSize(width: 0, height: -6.0)
        let cornerRadius = CGSize(width: 10, height: 10)
        configuration.label
            .offset(offset)
            .padding()
            .background {
                ZStack {
                    RoundedRectangle(cornerSize: cornerRadius).foregroundColor(Color.white.opacity(0.5))
                    RoundedRectangle(cornerSize: cornerRadius).foregroundColor(Color.white)
                    .offset(offset)
                }
            }
            .foregroundColor(.blue)
            .font(.custom("Arial", size: 20)) // 自定义字体
    }
}

struct PickerPreview: View {
    var body: some View {
        LazyVGrid(columns: [GridItem()]) {
            Text("PickerPreview")
        }
    }
}
#Preview {
    MainView()
}
