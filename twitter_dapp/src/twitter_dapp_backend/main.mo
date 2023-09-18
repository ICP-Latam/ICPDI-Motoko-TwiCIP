import Time "mo:base/Time";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Nat32 "mo:base/Nat32";

actor {
  type Tweet = {
    author: Text;
    content: Text;
    timestamp: Nat;
  };
  
  var tweets: [Tweet] = [];

  public func postTweet(author: Text, content: Text): async Bool {
    let timestamp = intToNat(Time.now());
    let newTweet = {author = author; content = content; timestamp = timestamp};
    let newTweets = Array.tabulate<Tweet>(tweets.size() + 1, func(index: Nat) : Tweet {
      if (index == 0) {
        return newTweet;
      } else {
        return tweets[index - 1];
      }
    });
    tweets := newTweets;
    return true;
  };

  public func getTweets(): async [Tweet] {
    return tweets;
  };

  public func deleteTweet(timestamp: Nat): async Bool {
    tweets := Array.filter<Tweet>(tweets, func(tweet: Tweet): Bool {
      return tweet.timestamp != timestamp;
    });
    return true;
  };

  private func intToNat(x: Int) : Nat {
    let absValue = Int.abs(x);
    let nat32Value = Nat32.fromIntWrap(absValue);
    return Nat32.toNat(nat32Value); // Convierte el valor de Nat32 a Nat
  }
}
