// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class LikeRoomMutation: GraphQLMutation {
  static let operationName: String = "LikeRoom"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation LikeRoom($roomId: String!) { LikeRoom(RoomId: $roomId) { __typename Likes } }"#
    ))

  public var roomId: String

  public init(roomId: String) {
    self.roomId = roomId
  }

  public var __variables: Variables? { ["roomId": roomId] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("LikeRoom", LikeRoom?.self, arguments: ["RoomId": .variable("roomId")]),
    ] }

    var likeRoom: LikeRoom? { __data["LikeRoom"] }

    init(
      likeRoom: LikeRoom? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "LikeRoom": likeRoom._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(LikeRoomMutation.Data.self)
        ]
      ))
    }

    /// LikeRoom
    ///
    /// Parent Type: `Room`
    struct LikeRoom: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("Likes", Int?.self),
      ] }

      var likes: Int? { __data["Likes"] }

      init(
        likes: Int? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Room.typename,
            "Likes": likes,
          ],
          fulfilledFragments: [
            ObjectIdentifier(LikeRoomMutation.Data.LikeRoom.self)
          ]
        ))
      }
    }
  }
}
