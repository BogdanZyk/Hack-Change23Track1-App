// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import Hack&Change23Track1&

class DeleteRoomMutation: GraphQLMutation {
  static let operationName: String = "DeleteRoom"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteRoom($roomId: String!) { DeleteRoom(RoomId: $roomId) { __typename Id } }"#
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
      .field("DeleteRoom", DeleteRoom?.self, arguments: ["RoomId": .variable("roomId")]),
    ] }

    var deleteRoom: DeleteRoom? { __data["DeleteRoom"] }

    init(
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
    struct DeleteRoom: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("Id", String?.self),
      ] }

      var id: String? { __data["Id"] }

      init(
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
