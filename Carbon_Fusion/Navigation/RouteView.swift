



import SwiftUI

struct RouterView<T: Hashable, Content: View>: View {
    
    @ObservedObject
    var router: Router<T>
    
    @ViewBuilder var buildView: (T, Any?) -> Content
    var body: some View {
        NavigationStack(path: $router.paths) {
            buildView(router.root, nil)
            .navigationDestination(for: T.self) { path in
                buildView(path, router.values[path] ?? nil)
            }
        }
        .environmentObject(router)
    }
}






