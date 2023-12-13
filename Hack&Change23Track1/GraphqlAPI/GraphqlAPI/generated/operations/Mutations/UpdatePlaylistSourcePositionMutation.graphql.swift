// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class UpdatePlaylistSourcePositionMutation: GraphQLMutation {
  static let operationName: String = "UpdatePlaylistSourcePosition"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdatePlaylistSourcePosition($roomId: String!, $sourceId: String!, $newPositionIndex: Int!) { UpdatePlaylistSourcePosition( RoomId: $roomId SourceId: $sourceId NewPositionIndex: $newPositionIndex ) { __typename ...SourceAttrs } }"#,
      fragments: [SourceAttrs.self]
    ))

  public var roomId: String
  public var sourceId: String
  public var newPositionIndex: Int

  public init(
    roomId: String,
    sourceId: String,
    newPositionIndex: Int
  ) {
    self.roomId = roomId
    self.sourceId = sourceId
    self.newPositionIndex = newPositionIndex
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "sourceId": sourceId,
    "newPositionIndex": newPositionIndex
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("UpdatePlaylistSourcePosition", [UpdatePlaylistSourcePosition?]?.self, arguments: [
        "RoomId": .variable("roomId"),
        "SourceId": .variable("sourceId"),
        "NewPositionIndex": .variable("newPositionIndex")
      ]),
    ] }

    var updatePlaylistSourcePosition: [UpdatePlaylistSourcePosition?]? { __data["UpdatePlaylistSourcePosition"] }

    init(
      updatePlaylistSourcePosition: [UpdatePlaylistSourcePosition?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "UpdatePlaylistSourcePosition": updatePlaylistSourcePosition._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(UpdatePlaylistSourcePositionMutation.Data.self)
        ]
      ))
    }

    /// UpdatePlaylistSourcePosition
    ///
    /// Parent Type: `PlaylistSource`
    struct UpdatePlaylistSourcePosition: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlaylistSource }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(SourceAttrs.self),
      ] }

      var name: String? { __data["Name"] }
      var id: String? { __data["Id"] }
      var cover: String? { __data["Cover"] }
      var index: Int? { __data["Index"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var sourceAttrs: SourceAttrs { _toFragment() }
      }

      init(
        name: String? = nil,
        id: String? = nil,
        cover: String? = nil,
        index: Int? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.PlaylistSource.typename,
            "Name": name,
            "Id": id,
            "Cover": cover,
            "Index": index,
          ],
          fulfilledFragments: [
            ObjectIdentifier(UpdatePlaylistSourcePositionMutation.Data.UpdatePlaylistSourcePosition.self),
            ObjectIdentifier(SourceAttrs.self)
          ]
        ))
      }
    }
  }
}
