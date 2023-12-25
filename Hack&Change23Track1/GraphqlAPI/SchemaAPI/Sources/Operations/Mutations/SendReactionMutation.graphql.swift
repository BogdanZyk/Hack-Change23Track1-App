// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SendReactionMutation: GraphQLMutation {
  public static let operationName: String = "SendReaction"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SendReaction($roomId: String!, $reaction: String!) { SendReaction(RoomId: $roomId, Reaction: $reaction) }"#
    ))

  public var roomId: String
  public var reaction: String

  public init(
    roomId: String,
    reaction: String
  ) {
    self.roomId = roomId
    self.reaction = reaction
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "reaction": reaction
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("SendReaction", Bool?.self, arguments: [
        "RoomId": .variable("roomId"),
        "Reaction": .variable("reaction")
      ]),
    ] }

    public var sendReaction: Bool? { __data["SendReaction"] }

    public init(
      sendReaction: Bool? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "SendReaction": sendReaction,
        ],
        fulfilledFragments: [
          ObjectIdentifier(SendReactionMutation.Data.self)
        ]
      ))
    }
  }
}
