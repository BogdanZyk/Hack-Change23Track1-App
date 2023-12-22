// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SendMessageMutation: GraphQLMutation {
  public static let operationName: String = "SendMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SendMessage($roomId: String!, $message: MessageInput!) { SendMessage(RoomId: $roomId, Message: $message) }"#
    ))

  public var roomId: String
  public var message: MessageInput

  public init(
    roomId: String,
    message: MessageInput
  ) {
    self.roomId = roomId
    self.message = message
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "message": message
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("SendMessage", Bool?.self, arguments: [
        "RoomId": .variable("roomId"),
        "Message": .variable("message")
      ]),
    ] }

    public var sendMessage: Bool? { __data["SendMessage"] }

    public init(
      sendMessage: Bool? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "SendMessage": sendMessage,
        ],
        fulfilledFragments: [
          ObjectIdentifier(SendMessageMutation.Data.self)
        ]
      ))
    }
  }
}
