// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetRoomPlaylistQuery: GraphQLQuery {
  public static let operationName: String = "GetRoomPlaylist"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetRoomPlaylist($roomId: String!) { GetRoomPlaylist(RoomId: $roomId) { __typename ...PlaylistRowAttrs } }"#,
      fragments: [PlaylistRowAttrs.self, SourceAttrs.self]
    ))

  public var roomId: String

  public init(roomId: String) {
    self.roomId = roomId
  }

  public var __variables: Variables? { ["roomId": roomId] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("GetRoomPlaylist", [GetRoomPlaylist?]?.self, arguments: ["RoomId": .variable("roomId")]),
    ] }

    public var getRoomPlaylist: [GetRoomPlaylist?]? { __data["GetRoomPlaylist"] }

    public init(
      getRoomPlaylist: [GetRoomPlaylist?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "GetRoomPlaylist": getRoomPlaylist._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(GetRoomPlaylistQuery.Data.self)
        ]
      ))
    }

    /// GetRoomPlaylist
    ///
    /// Parent Type: `PlaylistRow`
    public struct GetRoomPlaylist: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlaylistRow }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(PlaylistRowAttrs.self),
      ] }

      public var id: String? { __data["Id"] }
      public var index: Int? { __data["Index"] }
      public var source: Source? { __data["Source"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var playlistRowAttrs: PlaylistRowAttrs { _toFragment() }
      }

      public init(
        id: String? = nil,
        index: Int? = nil,
        source: Source? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.PlaylistRow.typename,
            "Id": id,
            "Index": index,
            "Source": source._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(GetRoomPlaylistQuery.Data.GetRoomPlaylist.self),
            ObjectIdentifier(PlaylistRowAttrs.self)
          ]
        ))
      }

      /// GetRoomPlaylist.Source
      ///
      /// Parent Type: `Source`
      public struct Source: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

        public var id: String? { __data["Id"] }
        public var cover: String? { __data["Cover"] }
        public var name: String? { __data["Name"] }
        public var url: String? { __data["Url"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var sourceAttrs: SourceAttrs { _toFragment() }
        }

        public init(
          id: String? = nil,
          cover: String? = nil,
          name: String? = nil,
          url: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.Source.typename,
              "Id": id,
              "Cover": cover,
              "Name": name,
              "Url": url,
            ],
            fulfilledFragments: [
              ObjectIdentifier(GetRoomPlaylistQuery.Data.GetRoomPlaylist.Source.self),
              ObjectIdentifier(SourceAttrs.self),
              ObjectIdentifier(PlaylistRowAttrs.Source.self)
            ]
          ))
        }
      }
    }
  }
}
