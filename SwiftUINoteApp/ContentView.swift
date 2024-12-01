import SwiftUI

struct DraggableSquareView: View {
    // State for the position of the square
    @State private var position: CGPoint = CGPoint(x: 100, y: 100)
    
    // Size of the square
    private let squareSize: CGFloat = 50
    
    @State private var screenWidth: CGFloat = 300.0
    
    @State private var screenHeight: CGFloat = 300.0
    
    var body: some View {
        GeometryReader { geometry in
            // Container view
            ZStack {
                // Boundary of the container
                Color.gray.opacity(0.2)
                
                // Draggable square
                Rectangle()
                    .frame(width: squareSize, height: squareSize)
                    .foregroundColor(.blue)
                    .position(position)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newPosition = CGPoint(
                                    x: min(max(value.location.x, squareSize / 2), geometry.size.width - squareSize / 2),
                                    y: min(max(value.location.y, squareSize / 2), geometry.size.height - squareSize / 2)
                                )
                                position = newPosition
                            }
                    )
            }
            .onAppear {
                screenWidth = geometry.size.width
                screenHeight = geometry.size.height
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        DraggableSquareView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
