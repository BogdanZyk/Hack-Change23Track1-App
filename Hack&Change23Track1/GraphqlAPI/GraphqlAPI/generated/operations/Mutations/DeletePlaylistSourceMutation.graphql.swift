// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class DeletePlaylistSourceMutation: GraphQLMutation {
  static let operationName: String = "DeletePlaylistSource"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeletePlaylistSource($roomId: String!, $sourceId: String!) { DeletePlaylistSource(RoomId: $roomId, SourceId: $sourceId) { __typename ...SourceAttrs } }"#,
      fragments: [SourceAttrs.self]
    ))

  public var roomId: String
  public var sourceId: String

  public init(
    roomId: String,
    sourceId: String
  ) {
    self.roomId = roomId
    self.sourceId = sourceId
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "sourceId": sourceId
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("DeletePlaylistSource", [DeletePlaylistSource?]?.self, arguments: [
        "RoomId": .variable("roomId"),
        "SourceId": .variable("sourceId")
      ]),
    ] }

    var deletePlaylistSource: [DeletePlaylistSource?]? { __data["DeletePlaylistSource"] }

    init(
      deletePlaylistSource: [DeletePlaylistSource?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "DeletePlaylistSource": deletePlaylistSource._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(DeletePlaylistSourceMutation.Data.self)
        ]
      ))
    }

    /// DeletePlaylistSource
    ///
    /// Parent Type: `Source`
    struct DeletePlaylistSource: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(SourceAttrs.self),
      ] }

      var name: String? { __data["Name"] }
      var id: String? { __data["Id"] }
      var cover: String? { __data["Cover"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var sourceAttrs: SourceAttrs { _toFragment() }
      }

      init(
        name: String? = nil,
        id: String? = nil,
        cover: String? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Source.typename,
            "Name": name,
            "Id": id,
            "Cover": cover,
          ],
          fulfilledFragments: [
            ObjectIdentifier(DeletePlaylistSourceMutation.Data.DeletePlaylistSource.self),
            ObjectIdentifier(SourceAttrs.self)
          ]
        ))
      }
    }
  }
}
