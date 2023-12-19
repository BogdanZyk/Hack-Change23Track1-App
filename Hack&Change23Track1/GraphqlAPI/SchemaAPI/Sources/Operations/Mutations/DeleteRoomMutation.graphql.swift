// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteRoomMutation: GraphQLMutation {
  public static let operationName: String = "DeleteRoom"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteRoom($roomId: String!) { DeleteRoom(RoomId: $roomId) { __typename Id } }"#
    ))

  public var roomId: String

  public init(roomId: String) {
    self.roomId = roomId
  }

  public var __variables: Variables? { ["roomId": roomId] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("DeleteRoom", DeleteRoom?.self, arguments: ["RoomId": .variable("roomId")]),
    ] }

    public var deleteRoom: DeleteRoom? { __data["DeleteRoom"] }

    public init(
      deleteRoom: DeleteRoom? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "DeleteRoom": deleteRoom._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(DeleteRoomMutation.Data.self)
        ]
      ))
    }

    /// DeleteRoom
    ///
    /// Parent Type: `Room`
    public struct DeleteRoom: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("Id", String?.self),
      ] }

      public var id: String? { __data["Id"] }

      public init(
        id: String? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Room.typename,
            "Id": id,
          ],
          fulfilledFragments: [
            ObjectIdentifier(DeleteRoomMutation.Data.DeleteRoom.self)
          ]
        ))
      }
    }
  }
}
