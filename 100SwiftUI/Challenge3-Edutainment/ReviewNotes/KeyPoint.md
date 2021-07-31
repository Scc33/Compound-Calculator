## Key Points
 - ranges with ForEach and list
    - When we write 0..<5 we get a Range<Int>, but when we write 0...5 we get a ClosedRange<Int> so to use ForEach we need to have ..<
    - Range declaration -> public init(_ data: Range<Int>, @ViewBuilder content: @escaping (Int) -> Content)
 - app bundles
    - asset catalogs for storing images
    - loose assets for all other kinds of media used in app
        - they all end up getting stored in the same resources file
        - you cannot (!!) use the same filename for an asset anywhere in a project
        - for example two "start.txt" files wouldn't work

### Review
 - working with dates uses the Date, DateComponenets, and DateFormatter
 - crashing code with fatalError()
