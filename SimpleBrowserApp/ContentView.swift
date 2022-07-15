//
//  ContentView.swift
//  SimpleBrowserApp
//
//  Created by Jordan Peralta on 2022-06-26.
//
import SwiftUI
import WebKit

struct ContentView: View {
    @StateObject var model = WebViewModel()
    @State var view = WKWebView()
    @State var webAddress: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                WebView(webView: model.webView)
                    .ignoresSafeArea(.all, edges: .bottom)
                VStack {
                    HStack {
                        TextField("https://www...", text: $webAddress)
                            .background(Color.gray.opacity(0.2).cornerRadius(5))
                            .frame(width: 340, height: 20, alignment: .trailing)
                            .font(.system(size: 20))
                            .keyboardType(.URL)
                            .textInputAutocapitalization(.never)
                        Button(action: {
                            showWebsite(fetchURL: "https://www." + webAddress)
                        }, label: {
                            Image(systemName: "arrow.right.circle")
                                .font(.system(size: 25))
                                .foregroundColor(.yellow)
                        })
                    }
                    HStack {
                        Button(action: {
                            model.webView.goBack()
                        }, label: {
                            Text("Go \nBack")
                                .font(.system(size: 10))
                            Image(systemName: "arrow.counterclockwise")
                                .font(.system(size: 25))
                                .foregroundColor(.orange)
                        })
                        Button(action: {
                            model.webView.reload()
                        }, label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 25))
                                .foregroundColor(.orange)
                        })
                        
                        Button(action: {
                            model.webView.goForward()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 25))
                                .foregroundColor(.orange)
                            Text("Go \nForward")
                                .font(.system(size: 10))
                        })
                    }
                }
            }
            .navigationBarTitle("Simple Browser")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func showWebsite(fetchURL: String){
        guard let url = URL(string: fetchURL) else {
            return
        }
        model.webView.load(URLRequest(url: url))
    }
}

class WebViewModel: ObservableObject {
    let webView: WKWebView
    let url: URL
    
    init() {
        webView = WKWebView(frame: .zero)
        url = URL(string: "https://www.apple.com/ca")!
        defaultURL()
    }
    
    func defaultURL() {
        webView.load(URLRequest(url: url))
    }
}

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
