// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SendRoomReactionMutation: GraphQLMutation {
  public static let operationName: String = "SendRoomReaction"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SendRoomReaction($roomId: String!) { SendRoomReaction(RoomId: $roomId) }"#
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
      .field("SendRoomReaction", Int?.self, arguments: ["RoomId": .variable("roomId")]),
    ] }

    public var sendRoomReaction: Int? { __data["SendRoomReaction"] }

    public init(
      sendRoomReaction: Int? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "SendRoomReaction": sendRoomReaction,
        ],
        fulfilledFragments: [
          ObjectIdentifier(SendRoomReactionMutation.Data.self)
        ]
      ))
    }
  }
}
